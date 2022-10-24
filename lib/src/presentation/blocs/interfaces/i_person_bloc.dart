import '../../../core/bloc/i_bloc.dart';
import '../../../core/utils/status_constants.dart';
import '../../../data/models/person_model.dart';
import '../../../domain/entities/person_event.dart';

abstract class IPersonBloc implements IBloc {
  Stream<PersonEvent> getStream();
  Future<void> getPersonInfo({required PersonModel person});
  Future<Status> sendPersonInfo({required PersonModel person});
}
