import 'dart:async';

import '../../core/usecases/i_usecase.dart';
import '../../domain/entities/people_event.dart';
import 'interfaces/i_people_bloc.dart';
import '../../core/utils/status_constants.dart';

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
