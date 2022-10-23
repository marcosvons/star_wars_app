import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/assets_constants.dart';
import '../../core/utils/dimension_constants.dart';
import '../../core/utils/palette.dart';
import '../../core/utils/string_constants.dart';
import 'person_detail.dart';
import '../../core/utils/bool_constants.dart';
import '../../core/utils/status_constants.dart';
import '../../domain/entities/people_event.dart';
import '../blocs/interfaces/i_people_bloc.dart';
import '../../core/utils/service_constants.dart';
import '../widgets/empty_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({Key? key}) : super(key: key);

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  void initState() {
    Provider.of<IPeopleBloc>(
      context,
      listen: BoolConstants.listenProvider,
    ).getPeople(
        endpoint: ServiceConstants.endpoints[StringConstants.peopleString]!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.appBarBackgroundColor,
          title: const Text(
            StringConstants.appTitle,
            style: TextStyle(
              color: Palette.starWarsYellow,
              fontFamily: AssetsConstants.appTitleFont,
              fontSize: Dimensions.appTitleFontSize,
            ),
          ),
          centerTitle: BoolConstants.appBarTitleCentered,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsConstants.pathToBackgroundImg),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder<PeopleEvent>(
            stream: Provider.of<IPeopleBloc>(context).getStream(),
            initialData: PeopleEvent(status: Status.loading),
            builder: (
              BuildContext context,
              AsyncSnapshot<PeopleEvent> snapshot,
            ) {
              switch (snapshot.data!.status) {
                case Status.initial:
                case Status.loading:
                  return loading();
                case Status.success:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselSlider.builder(
                          options: CarouselOptions(
                            aspectRatio: Dimensions.carouselAspectRatio,
                            enlargeCenterPage:
                                BoolConstants.carouselEnlargedCenterPage,
                            scrollDirection: Axis.vertical,
                            enableInfiniteScroll:
                                BoolConstants.carouselInfiniteScroll,
                            height: MediaQuery.of(context).size.height *
                                Dimensions.carouselMultiplierHeight,
                            viewportFraction:
                                Dimensions.carouselViewportFraction,
                            autoPlay: BoolConstants.carouselAutoPlay,
                          ),
                          itemCount: snapshot.data!.people!.length,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                            int pageViewIndex,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.charactersListPadding,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PersonDetail(
                                        characterInfo:
                                            snapshot.data!.people![index],
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        snapshot.data!.people![index].name,
                                        style: const TextStyle(
                                          color: Palette.starWarsYellow,
                                          fontSize:
                                              Dimensions.characterNameFontSize,
                                          fontFamily:
                                              AssetsConstants.appMainFont,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Flexible(
                                      child: AutoSizeText(
                                        snapshot.data!.people![index].gender,
                                        style: const TextStyle(
                                          color: Palette.starWarsYellow,
                                          fontSize: Dimensions
                                              .characterGenderFontSize,
                                          fontFamily:
                                              AssetsConstants.appMainFont,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            snapshot.data!.previousPage != null
                                ? Expanded(
                                    flex: Dimensions.paginationButtonsFlex,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .paginationButtonsHorizontalPadding,
                                        vertical: Dimensions
                                            .paginationButtonsVerticalPadding,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Provider.of<IPeopleBloc>(
                                            context,
                                            listen:
                                                BoolConstants.listenProvider,
                                          ).getPeople(
                                            endpoint:
                                                snapshot.data!.previousPage!,
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Palette.buttonsBackgroundColor,
                                          ),
                                        ),
                                        child: const Text(
                                          StringConstants.previousButtonText,
                                          style: TextStyle(
                                            color: Palette.starWarsYellow,
                                            fontSize: Dimensions
                                                .paginationButtonFontSize,
                                            fontFamily:
                                                AssetsConstants.secondaryFont,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const Expanded(
                                    flex: Dimensions.paginationButtonsFlex,
                                    child: SizedBox(),
                                  ),
                            Expanded(
                              flex: Dimensions.paginationNumberFlex,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions
                                      .paginationButtonsHorizontalPadding,
                                  vertical: Dimensions
                                      .paginationButtonsVerticalPadding,
                                ),
                                child: Text(
                                  snapshot.data!.page!.toString(),
                                  style: const TextStyle(
                                    color: Palette.starWarsYellow,
                                    fontSize:
                                        Dimensions.paginationNumberFontSize,
                                    fontFamily: AssetsConstants.appMainFont,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            snapshot.data!.nextPage != null
                                ? Expanded(
                                    flex: Dimensions.paginationButtonsFlex,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .paginationButtonsHorizontalPadding,
                                        vertical: Dimensions
                                            .paginationButtonsVerticalPadding,
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Provider.of<IPeopleBloc>(
                                            context,
                                            listen:
                                                BoolConstants.listenProvider,
                                          ).getPeople(
                                            endpoint: snapshot.data!.nextPage!,
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Palette.buttonsBackgroundColor,
                                          ),
                                        ),
                                        child: const Text(
                                          StringConstants.nextButtonText,
                                          style: TextStyle(
                                            color: Palette.starWarsYellow,
                                            fontSize: Dimensions
                                                .paginationButtonFontSize,
                                            fontFamily:
                                                AssetsConstants.secondaryFont,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const Expanded(
                                    flex: Dimensions.paginationButtonsFlex,
                                    child: SizedBox(),
                                  ),
                          ],
                        ),
                      )
                    ],
                  );
                case Status.empty:
                  return empty(context);
                case Status.error:
                  return error(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
