import '../entities/vehicle_event.dart';

abstract class IVehiclesRepository {
  Future<VehicleEvent> fetchVehicleInformation({required List<dynamic> vehiclesEndpoint});
}
