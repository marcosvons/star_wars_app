import '../../data/models/person_model.dart';
import '../../core/usecases/i_usecase.dart';
import '../entities/person_event.dart';
import '../repositories/i_people_repository.dart';

class GetPersonInformationUseCase implements UseCase<PersonEvent, PersonModel> {
  final IPeopleRepository _peopleRepository;

  GetPersonInformationUseCase(this._peopleRepository);

  @override
  Future<PersonEvent> call({required PersonModel params}) async {
    return await _peopleRepository.fetchPersonAdditionalInformation(person: params);
  }
}
