import 'planet_event.dart';
import 'starship_event.dart';
import 'vehicle_event.dart';
import '../../core/utils/status_constants.dart';

class PersonEvent {
  final PlanetEvent? homeworld;
  final VehicleEvent? vehicles;
  final StarshipEvent? starships;
  final Status status;
  final String? errorMsg;

  PersonEvent({
    this.homeworld,
    this.vehicles,
    this.starships,
    required this.status,
    this.errorMsg,
  });
}
