import '../../domain/entities/vehicle.dart';

class VehicleModel extends Vehicle {
  VehicleModel({
    required String name,
    required String model,
    required String manufacturer,
    required String costInCredits,
    required String length,
    required String maxAtmosheringSpeed,
    required String crew,
    required String passengers,
    required String cargoCapacity,
    required String consumables,
    required String vehicleClass,
    required List<dynamic> pilots,
    required List<dynamic> films,
  }) : super(
          name: name,
          model: model,
          manufacturer: manufacturer,
          costInCredits: costInCredits,
          length: length,
          maxAtmospheringSpeed: maxAtmosheringSpeed,
          crew: crew,
          passengers: passengers,
          cargoCapacity: cargoCapacity,
          consumables: consumables,
          vehicleClass: vehicleClass,
          pilots: pilots,
          films: films,
        );

  factory VehicleModel.fromJson({required json}) {
    return VehicleModel(
      name: json['name'],
      model: json['model'],
      manufacturer: json['manufacturer'],
      costInCredits: json['cost_in_credits'],
      length: json['length'],
      maxAtmosheringSpeed: json['max_atmosphering_speed'],
      crew: json['crew'],
      passengers: json['passengers'],
      cargoCapacity: json['cargo_capacity'],
      consumables: json['consumables'],
      vehicleClass: json['vehicle_class'],
      pilots: json['pilots'],
      films: json['films'],
    );
  }
}
