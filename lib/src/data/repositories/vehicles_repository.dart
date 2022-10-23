import 'dart:convert';
import 'dart:io';

import '../../core/utils/status_constants.dart';
import '../../core/utils/string_constants.dart';
import '../models/vehicle_model.dart';
import '../../domain/entities/vehicle_event.dart';
import '../../domain/repositories/i_vehicles_repository.dart';
import '../../domain/repositories/crop.dart';
import '../datasources/remote/api_service.dart';

class VehiclesRepository with Crop implements IVehiclesRepository {
  final ApiService _service;

  VehiclesRepository(this._service);

  @override
  Future<VehicleEvent> fetchVehicleInformation(
      {required List<dynamic> vehiclesEndpoint}) async {
    List<String> croppedEndpoints = [];
    List<VehicleModel> vehicles = [];
    bool apiErrorOccurred = false;

    try {
      for (int i = 0; i < vehiclesEndpoint.length; i++) {
        croppedEndpoints.add(cropEndpoint(endpoint: vehiclesEndpoint[i]));
        var apiResponse = await _service.apiCall(endpoint: croppedEndpoints[i]);
        if (apiResponse.statusCode == HttpStatus.ok) {
          Map<String, dynamic> vehicleJson = json.decode(apiResponse.body);
          if (vehicleJson.isEmpty) {
            continue;
          } else {
            vehicles.add(VehicleModel.fromJson(json: vehicleJson));
          }
        } else {
          apiErrorOccurred = true;
        }
      }
      if (vehicles.isEmpty && apiErrorOccurred == true) {
        return VehicleEvent(
          status: Status.error,
          errorMsg: StringConstants.apiErrorMessage,
        );
      } else if (vehicles.isEmpty) {
        return VehicleEvent(status: Status.empty);
      }
      return VehicleEvent(
        vehicles: vehicles,
        status: Status.success,
      );
    } catch (e) {
      return VehicleEvent(
        status: Status.error,
        errorMsg: '$e',
      );
    }
  }
}
