import 'dart:async';

import 'package:star_wars_app/src/core/usecases/i_usecase.dart';
import 'package:star_wars_app/src/domain/entities/people_event.dart';
import 'package:star_wars_app/src/presentation/blocs/interfaces/i_people_bloc.dart';

class PeopleBloc implements IPeopleBloc {
  final UseCase _getPeopleUsecase;

  PeopleBloc(this._getPeopleUsecase);

  final StreamController<PeopleEvent> _streamController =
      StreamController<PeopleEvent>.broadcast();

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  Future<void> getPeople({required endpoint}) async {
    _streamController.sink.add(PeopleEvent(status: Status.loading));
    _streamController.sink.add(await _getPeopleUsecase(params: endpoint));
  }

  @override
  Stream<PeopleEvent> getStream() => _streamController.stream;

  @override
  void initialize() {
    _streamController.sink.add(PeopleEvent(status: Status.initial));
  }
}
