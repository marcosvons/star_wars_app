import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_app/src/core/utils/assets_constants.dart';

import '../../domain/entities/people_event.dart';
import '../blocs/interfaces/i_people_bloc.dart';
import '../../core/utils/service_constants.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({Key? key}) : super(key: key);

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  int page = 1;

  @override
  void initState() {
    Provider.of<IPeopleBloc>(context, listen: false)
        .getPeople(endpoint: ServiceConstants.endpoints['People']);
    super.initState();
  }

  void incrementPage() {
    page++;
  }

  void decreasePage() {
    page--;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AssetsConstants.pathToBackgroundImg),
            fit: BoxFit.cover,
          )),
          child: StreamBuilder<PeopleEvent>(
            stream: Provider.of<IPeopleBloc>(context).getStream(),
            initialData: PeopleEvent(status: Status.loading),
            builder:
                (BuildContext context, AsyncSnapshot<PeopleEvent> snapshot) {
              switch (snapshot.data!.status) {
                case Status.initial:
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); //animation maybe?
                  }
                case Status.loading:
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case Status.success:
                  {
                    return Column(
                      children: [
                        ListView.builder(
                          itemCount: snapshot.data!.people!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white.withOpacity(0.1),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.people![index].name),
                                    Text(snapshot.data!.people![index].gender),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.focused))
                                    return Colors.red;
                                  return null; // Defer to the widget's default.
                                }),
                              ),
                              onPressed: () {
                                decreasePage();
                                Provider.of<IPeopleBloc>(context, listen: false)
                                    .getPeople(endpoint: 'people/?page=$page');
                              },
                              child: Text('Previous'),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.focused))
                                    return Colors.red;
                                  return null; // Defer to the widget's default.
                                }),
                              ),
                              onPressed: () {
                                incrementPage();
                                Provider.of<IPeopleBloc>(context, listen: false)
                                    .getPeople(endpoint: 'people/?page=$page');
                              },
                              child: Text('Next'),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                case Status.empty:
                  {
                    return const Text('Empty people list');
                  }
                case Status.error:
                  {
                    return Text('Error: ${snapshot.data!.errorMsg!}');
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
