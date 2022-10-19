import '../../data/models/person_model.dart';

class PeopleEvent {
  final List<PersonModel>? people;
  final Status status;
  final String? errorMsg;

  PeopleEvent({
    this.people,
    required this.status,
    this.errorMsg,
  });
}

enum Status {
  initial,
  loading,
  success,
  empty,
  error,
}
