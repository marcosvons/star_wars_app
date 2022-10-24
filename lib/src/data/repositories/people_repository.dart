import 'dart:convert';
import 'dart:io';

import '../datasources/remote/api_service.dart';
import '../models/person_model.dart';
import '../../domain/entities/people_event.dart';
import '../../domain/entities/person_event.dart';
import '../../domain/entities/planet_event.dart';
import '../../domain/entities/starship_event.dart';
import '../../domain/entities/vehicle_event.dart';
import '../../domain/repositories/format_json.dart';
import '../../domain/repositories/i_planets_repository.dart';
import '../../domain/repositories/i_starships_repository.dart';
import '../../domain/repositories/i_vehicles_repository.dart';
import '../../core/utils/status_constants.dart';
import '../../core/utils/string_constants.dart';
import '../../domain/repositories/i_people_repository.dart';
import '../../domain/repositories/i_repositories_object.dart';

class PeopleRepository with FormatJson implements IPeopleRepository {
  final ApiService _service;
  final IRepositoriesObject _repositories;

  PeopleRepository(
    this._service,
    this._repositories,
  );

  @override
  Future<PeopleEvent> fetchPeople({required endpoint}) async {
    List<PersonModel> people = [];
    int page;
    try {
      var apiResponse = await _service.apiCall(url: endpoint);
      if (apiResponse.statusCode == HttpStatus.ok) {
        Map<String, dynamic> jsonDecoded = json.decode(apiResponse.body);
        List<dynamic> peopleJson = json.decode(apiResponse.body)['results'];
        if (peopleJson.isEmpty) {
          return PeopleEvent(status: Status.empty);
        } else {
          peopleJson.forEach((person) {
            people.add(PersonModel.fromJson(json: person));
          });
          if (jsonDecoded['previous'] != null){
            page = int.parse(jsonDecoded['previous'].substring(jsonDecoded['previous'].indexOf('=')+1))+1;
          } else {
            page = int.parse(jsonDecoded['next'].substring(jsonDecoded['next'].indexOf('=')+1))-1;
          }
          return PeopleEvent(
            people: people,
            status: Status.success,
            previousPage: jsonDecoded['previous'],
            nextPage: jsonDecoded['next'],
            page: page,
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

  @override
  Future<PersonEvent> fetchPersonAdditionalInformation(
      {required PersonModel person}) async {
    final IPlanetsRepository planetsRepository =
        _repositories.planetsRepository;
    final IStarshipsRepository starshipsRepository =
        _repositories.starshipRepository;
    final IVehiclesRepository vehiclesRepository =
        _repositories.vehiclesRepository;
    try {
      PlanetEvent planetEvent = await planetsRepository.fetchPlanetInformation(
          planetEndpoint: person.homeworld);
      VehicleEvent vehicleEvent = await vehiclesRepository
          .fetchVehicleInformation(vehiclesEndpoint: person.vehicles);
      StarshipEvent starshipEvent = await starshipsRepository
          .fetchStarshipInformation(starshipsEndpoint: person.starships);
      return PersonEvent(
        homeworld: planetEvent,
        vehicles: vehicleEvent,
        starships: starshipEvent,
        status: Status.success,
      );
    } catch (e) {
      return PersonEvent(status: Status.error);
    }
  }

  @override
  Future<Status> sendPersonInformation({required PersonModel person}) async {
    try {
      Map<String, dynamic> personJson = PersonModel.toJson(person);
      String body = formatPostJson(personJson: personJson);
      var httpResponse = await _service.postCharacter(body: body);
      if (httpResponse.statusCode == HttpStatus.created) {
        return Status.success;
      }
      return Status.error;
    } catch(e){
      return Status.error;
    }
  }
}
