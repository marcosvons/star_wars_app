import 'package:star_wars_app/src/core/bloc/i_bloc.dart';

import '../../../domain/entities/people_event.dart';

abstract class IPeopleBloc implements IBloc {
  Stream<PeopleEvent> getStream();
  Future<void> getPeople({required String endpoint});
}
