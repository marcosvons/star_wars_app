import 'dart:convert';
import 'dart:io';

import 'package:star_wars_app/src/data/datasources/remote/api_service.dart';
import 'package:star_wars_app/src/data/models/person_model.dart';
import 'package:star_wars_app/src/domain/entities/people_event.dart';

import '../../core/utils/string_constants.dart';
import '../../domain/repositories/i_people_repository.dart';

class PeopleRepository implements IPeopleRepository {
  final ApiService _service;

  PeopleRepository(this._service);

  @override
  Future<PeopleEvent> fetchPeople({required endpoint}) async {
    List<PersonModel> people = [];
    try {
      var apiResponse = await _service.apiCall(endpoint: endpoint);
      if (apiResponse.statusCode == HttpStatus.ok) {
        List<dynamic> peopleJson = json.decode(apiResponse.body)['results'];
        if (peopleJson.isEmpty) {
          return PeopleEvent(status: Status.empty);
        } else {
          peopleJson.forEach((person) {
            people.add(PersonModel.fromJson(json: person));
          });
          return PeopleEvent(
            people: people,
            status: Status.success,
          );
        }
      }
      return PeopleEvent(
        status: Status.error,
        errorMsg: StringConstants.apiErrorMessage,
      );
    } catch (e) {
      return PeopleEvent(
        status: Status.error,
        errorMsg: '$e',
      );
    }
  }
}
