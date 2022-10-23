import 'dart:async';

import '../../data/models/person_model.dart';
import '../../domain/entities/person_event.dart';
import 'interfaces/i_person_bloc.dart';
import '../../core/usecases/i_usecase.dart';
import '../../core/utils/status_constants.dart';

class PersonBloc implements IPersonBloc {
  final UseCase _getPersonInformationUsecase;
  final UseCase _sendPersonInformationUsecase;

  PersonBloc(
    this._getPersonInformationUsecase,
    this._sendPersonInformationUsecase,
  );

  final StreamController<PersonEvent> _streamController =
      StreamController<PersonEvent>.broadcast();

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  Stream<PersonEvent> getStream() => _streamController.stream;

  @override
  void initialize() {
    _streamController.sink.add(PersonEvent(status: Status.initial));
  }

  @override
  Future<void> getPersonInfo({required PersonModel person}) async {
    _streamController.sink.add(PersonEvent(status: Status.loading));
    _streamController.sink
        .add(await _getPersonInformationUsecase(params: person));
  }

  @override
  Future<Status> sendPersonInfo({required PersonModel person}) async {
    return await _sendPersonInformationUsecase(params: person);
  }
}
