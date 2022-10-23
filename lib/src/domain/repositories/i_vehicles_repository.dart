import 'package:star_wars_app/src/domain/entities/vehicle_event.dart';

abstract class IVehiclesRepository {
  Future<VehicleEvent> fetchVehicleInformation({required List<dynamic> vehiclesEndpoint});
}