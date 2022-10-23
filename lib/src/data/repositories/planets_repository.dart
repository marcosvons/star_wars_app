import 'dart:convert';
import 'dart:io';

import 'package:star_wars_app/src/domain/entities/planet_event.dart';
import 'package:star_wars_app/src/domain/repositories/i_planets_repository.dart';
import '../../core/utils/status_constants.dart';
import '../../core/utils/string_constants.dart';
import '../../domain/repositories/crop.dart';
import '../datasources/remote/api_service.dart';
import '../models/planet_model.dart';

class PlanetsRepository with Crop implements IPlanetsRepository {
  final ApiService _service;

  PlanetsRepository(this._service);

  @override
  Future<PlanetEvent> fetchPlanetInformation(
      {required String planetEndpoint}) async {
    try {
      String specificEndpoint = cropEndpoint(endpoint: planetEndpoint);
      var apiResponse = await _service.apiCall(endpoint: specificEndpoint);
      if (apiResponse.statusCode == HttpStatus.ok) {
        Map<String, dynamic> planetJson = json.decode(apiResponse.body);
        if (planetJson.isEmpty) {
          return PlanetEvent(status: Status.empty);
        } else {
          var planet = PlanetModel.fromJson(json: planetJson);
          return PlanetEvent(
            planet: planet,
            status: Status.success,
          );
        }
      }
      return PlanetEvent(
        status: Status.error,
        errorMsg: StringConstants.apiErrorMessage,
      );
    } catch (e) {
      return PlanetEvent(
        status: Status.error,
        errorMsg: '$e',
      );
    }
  }
}
