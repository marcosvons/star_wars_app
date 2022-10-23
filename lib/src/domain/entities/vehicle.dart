class Vehicle {
  final String name;
  final String model;
  final String manufacturer;
  final String costInCredits;
  final String length;
  final String maxAtmospheringSpeed;
  final String crew;
  final String passengers;
  final String cargoCapacity;
  final String consumables;
  final String vehicleClass;
  final List<dynamic> pilots;
  final List<dynamic> films;

  Vehicle({
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.maxAtmospheringSpeed,
    required this.crew,
    required this.passengers,
    required this.cargoCapacity,
    required this.consumables,
    required this.vehicleClass,
    required this.pilots,
    required this.films,
  });
}
