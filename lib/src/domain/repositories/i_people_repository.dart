import '../../core/utils/status_constants.dart';
import '../../data/models/person_model.dart';
import '../entities/people_event.dart';
import '../entities/person_event.dart';

abstract class IPeopleRepository {
  Future<PeopleEvent> fetchPeople({required String endpoint});
  Future<PersonEvent> fetchPersonAdditionalInformation ({required PersonModel person});
  Future<Status> sendPersonInformation({required PersonModel person});
}
