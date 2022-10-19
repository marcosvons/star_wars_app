import '../entities/people_event.dart';

abstract class IPeopleRepository {
  Future<PeopleEvent> fetchPeople({required endpoint});
}
