import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/person_event.dart';
import '../blocs/interfaces/i_connection_bloc.dart';
import '../widgets/character_information.dart';
import '../widgets/list.dart';
import '../../core/utils/status_constants.dart';
import '../../data/models/person_model.dart';
import '../blocs/interfaces/i_person_bloc.dart';
import '../../core/utils/assets_constants.dart';
import '../../core/utils/bool_constants.dart';
import '../../core/utils/dimension_constants.dart';
import '../../core/utils/palette.dart';
import '../../core/utils/string_constants.dart';
import '../widgets/empty_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/homeworld_widget.dart';
import '../widgets/loading_widget.dart';

class PersonDetail extends StatefulWidget {
  final PersonModel characterInfo;

  const PersonDetail({
    Key? key,
    required this.characterInfo,
  }) : super(key: key);

  @override
  State<PersonDetail> createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  @override
  void initState() {
    Provider.of<IPersonBloc>(
      context,
      listen: BoolConstants.listenProvider,
    ).getPersonInfo(person: widget.characterInfo);
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
          leading: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Palette.appBarIconColor,
            ),
          ),
          centerTitle: BoolConstants.appBarTitleCentered,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AssetsConstants.pathToBackgroundImg),
            fit: BoxFit.cover,
          )),
          child: StreamBuilder<PersonEvent>(
            stream: Provider.of<IPersonBloc>(context).getStream(),
            initialData: PersonEvent(status: Status.loading),
            builder: (
              BuildContext context,
              AsyncSnapshot<PersonEvent> snapshot,
            ) {
              switch (snapshot.data!.status) {
                case Status.initial:
                  return loading();
                case Status.loading:
                  return loading();
                case Status.success:
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.characterDetailHorizontalPadding,
                      right: Dimensions.characterDetailHorizontalPadding,
                      top: Dimensions.characterDetailVerticalPadding,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    Dimensions
                                        .propertiesNamesRowWidthMultiplier,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    characterInformation(
                                      information: StringConstants.nameProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.genderProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.birthYearProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.homeworldProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.heightProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information: StringConstants.massProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.eyeColorProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.hairColorProperty,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.starshipsProperty,
                                      flex: snapshot.data!.starships!.starships
                                              ?.length ??
                                          Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                    characterInformation(
                                      information:
                                          StringConstants.vehiclesProperty,
                                      flex: snapshot.data!.vehicles!.vehicles
                                              ?.length ??
                                          Dimensions.detailPropertiesFlex,
                                      align: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    Dimensions
                                        .characterDetailRowWidthMultiplier,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    characterInformation(
                                      information: widget.characterInfo.name,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.end,
                                    ),
                                    characterInformation(
                                      information: widget.characterInfo.gender,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.end,
                                    ),
                                    characterInformation(
                                      information:
                                          widget.characterInfo.birthYear,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.end,
                                    ),
                                    homeworldWidget(
                                      status: snapshot.data!.homeworld!.status,
                                      flex: Dimensions.detailPropertiesFlex,
                                      homeworld: snapshot
                                          .data!.homeworld!.planet?.name,
                                    ),
                                    characterInformation(
                                      information: widget.characterInfo.height,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.end,
                                    ),
                                    characterInformation(
                                      information: widget.characterInfo.mass,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.end,
                                    ),
                                    characterInformation(
                                      information:
                                          widget.characterInfo.eyeColor,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.end,
                                    ),
                                    characterInformation(
                                      information:
                                          widget.characterInfo.hairColor,
                                      flex: Dimensions.detailPropertiesFlex,
                                      align: TextAlign.end,
                                    ),
                                    propertiesList(
                                      status: snapshot.data!.starships!.status,
                                      list: snapshot.data!.starships!.starships,
                                    ),
                                    propertiesList(
                                      status: snapshot.data!.vehicles!.status,
                                      list: snapshot.data!.vehicles!.vehicles,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Provider.of<IConnectionBloc>(
                          context,
                          listen: BoolConstants.listenProvider,
                        ).getConnectionStatus
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  top: Dimensions.detailReportButtonTopPadding,
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentMaterialBanner();
                                    Status response =
                                        await Provider.of<IPersonBloc>(
                                      context,
                                      listen: BoolConstants.listenProvider,
                                    ).sendPersonInfo(
                                            person: widget.characterInfo);
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context)
                                        .showMaterialBanner(
                                      MaterialBanner(
                                        padding: const EdgeInsets.all(
                                          Dimensions.materialBannerPadding,
                                        ),
                                        content: response == Status.success
                                            ? const Text(
                                                StringConstants
                                                    .reportSightingSuccessful,
                                                style: TextStyle(
                                                  color: Palette
                                                      .materialBannerText,
                                                  fontSize: Dimensions
                                                      .materialBannerFontSize,
                                                  fontFamily: AssetsConstants
                                                      .secondaryFont,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : const Text(
                                                StringConstants
                                                    .reportSightingFailed,
                                                style: TextStyle(
                                                  color: Palette
                                                      .materialBannerText,
                                                  fontSize: Dimensions
                                                      .materialBannerFontSize,
                                                  fontFamily: AssetsConstants
                                                      .secondaryFont,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                        backgroundColor: response ==
                                                Status.success
                                            ? Palette
                                                .reportSuccessfulMaterialBanner
                                            : Palette
                                                .reportFailedMaterialBanner,
                                        leading: response == Status.success
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.close),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => ScaffoldMessenger
                                                    .of(context)
                                                .hideCurrentMaterialBanner(),
                                            child: Text(
                                              StringConstants
                                                  .closeMaterialBanner,
                                              style: TextStyle(
                                                color:
                                                    Palette.closeMaterialBanner,
                                                fontSize: Dimensions
                                                    .materialBannerFontSize,
                                                fontFamily: AssetsConstants
                                                    .secondaryFont,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Palette.buttonsBackgroundColor,
                                    ),
                                  ),
                                  child: const Text(
                                    StringConstants.reportSighting,
                                    style: TextStyle(
                                      color: Palette.starWarsYellow,
                                      fontSize:
                                          Dimensions.paginationButtonFontSize,
                                      fontFamily: AssetsConstants.secondaryFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
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
