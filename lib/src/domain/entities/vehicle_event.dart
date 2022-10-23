import '../../data/models/vehicle_model.dart';
import '../../core/utils/status_constants.dart';

class VehicleEvent {
  final List<VehicleModel>? vehicles;
  final Status status;
  final String? errorMsg;

  VehicleEvent({
    this.vehicles,
    required this.status,
    this.errorMsg,
  });
}
