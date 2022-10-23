import '../../domain/entities/planet.dart';

class PlanetModel extends Planet {
  PlanetModel({
    required String name,
    required String rotationPerdiod,
    required String orbitalPeriod,
    required String diameter,
    required String climate,
    required String gravity,
    required String terrain,
    required String surfaceWater,
    required String population,
    required List<dynamic> residents,
    required List<dynamic> films,
  }) : super(
          name: name,
          rotationPeriod: rotationPerdiod,
          orbitalPeriod: orbitalPeriod,
          diameter: diameter,
          climate: climate,
          gravity: gravity,
          terrain: terrain,
          surfaceWater: surfaceWater,
          population: population,
          residents: residents,
          films: films,
        );

  factory PlanetModel.fromJson({required json}) {
    return PlanetModel(
      name: json['name'],
      rotationPerdiod: json['rotation_period'],
      orbitalPeriod: json['orbital_period'],
      diameter: json['diameter'],
      climate: json['climate'],
      gravity: json['gravity'],
      terrain: json['terrain'],
      surfaceWater: json['surface_water'],
      population: json['population'],
      residents: json['residents'],
      films: json['films'],
    );
  }
}
