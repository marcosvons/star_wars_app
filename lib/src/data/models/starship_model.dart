import '../../domain/entities/starship.dart';

class StarshipModel extends Starship {
  StarshipModel({
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
    required String hyperdriveRating,
    required String MGLT,
    required String starshipClass,
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
          hyperdriveRating: hyperdriveRating,
          MGLT: MGLT,
          starshipClass: starshipClass,
          pilots: pilots,
          films: films,
        );

  factory StarshipModel.fromJson({required json}) {
    return StarshipModel(
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
      hyperdriveRating: json['hyperdrive_rating'],
      MGLT: json['MGLT'],
      starshipClass: json['starship_class'],
      pilots: json['pilots'],
      films: json['films'],
    );
  }
}
