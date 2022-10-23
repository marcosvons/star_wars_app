import '../../core/utils/status_constants.dart';
import '../../data/models/person_model.dart';

class PeopleEvent {
  final List<PersonModel>? people;
  final Status status;
  final String? errorMsg;
  final String? previousPage;
  final String? nextPage;
  final int? page;

  PeopleEvent({
    this.people,
    required this.status,
    this.errorMsg,
    this.previousPage,
    this.nextPage,
    this.page,
  });
}
