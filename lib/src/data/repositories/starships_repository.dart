import 'dart:convert';
import 'dart:io';

import '../datasources/remote/api_service.dart';
import '../models/starship_model.dart';
import '../../domain/entities/starship_event.dart';
import '../../domain/repositories/i_starships_repository.dart';
import '../../core/utils/status_constants.dart';
import '../../core/utils/string_constants.dart';

class StarshipsRepository implements IStarshipsRepository {
  final ApiService _service;

  StarshipsRepository(this._service);

  @override
  Future<StarshipEvent> fetchStarshipInformation(
      {required List<dynamic> starshipsEndpoint}) async {
    List<StarshipModel> starships = [];
    bool apiErrorOccurred = false;

    try {
      for (int i = 0; i < starshipsEndpoint.length; i++) {
        var apiResponse = await _service.apiCall(url: starshipsEndpoint[i]);
        if (apiResponse.statusCode == HttpStatus.ok) {
          Map<String, dynamic> starshipJson = json.decode(apiResponse.body);
          if (starshipJson.isEmpty) {
            continue;
          } else {
            starships.add(StarshipModel.fromJson(json: starshipJson));
          }
        } else {
          apiErrorOccurred = true;
        }
      }
      if (starships.isEmpty && apiErrorOccurred == true) {
        return StarshipEvent(
          status: Status.error,
          errorMsg: StringConstants.apiErrorMessage,
        );
      } else if (starships.isEmpty) {
        return StarshipEvent(status: Status.empty);
      }
      return StarshipEvent(
        starships: starships,
        status: Status.success,
      );
    } catch (e) {
      return StarshipEvent(
        status: Status.error,
        errorMsg: '$e',
      );
    }
  }
}
