import 'package:star_wars_app/src/data/models/person_model.dart';

import '../../core/usecases/i_usecase.dart';
import '../../core/utils/status_constants.dart';
import '../entities/person_event.dart';
import '../repositories/i_people_repository.dart';

class SendPersonInformationUseCase implements UseCase<Status, PersonModel> {
  final IPeopleRepository _peopleRepository;

  SendPersonInformationUseCase(this._peopleRepository);

  @override
  Future<Status> call({required PersonModel params}) async {
    return await _peopleRepository.sendPersonInformation(person: params);
  }
}
