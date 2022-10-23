import '../../core/usecases/i_usecase.dart';
import '../entities/people_event.dart';
import '../repositories/i_people_repository.dart';

class GetPeopleUseCase implements UseCase<PeopleEvent, String> {
  final IPeopleRepository _peopleRepository;

  GetPeopleUseCase(this._peopleRepository);

  @override
  Future<PeopleEvent> call({required String params}) async {
    return await _peopleRepository.fetchPeople(endpoint: params);
  }
}
