import '../../domain/entities/person.dart';

class PersonModel extends Person {
  PersonModel({
    required String name,
    required String height,
    required String mass,
    required String hairColor,
    required String skinColor,
    required String eyeColor,
    required String birthYear,
    required String gender,
    required String homeworld,
    required List<dynamic> films,
    required List<dynamic> species,
    required List<dynamic> vehicles,
    required List<dynamic> starships,
  }) : super(
          name: name,
          height: height,
          mass: mass,
          hairColor: hairColor,
          skinColor: skinColor,
          eyeColor: eyeColor,
          birthYear: birthYear,
          gender: gender,
          homeworld: homeworld,
          films: films,
          species: species,
          vehicles: vehicles,
          starships: starships,
        );

  factory PersonModel.fromJson({required json}) {
    return PersonModel(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      homeworld: json['homeworld'],
      films: json['films'],
      species: json['species'],
      vehicles: json['vehicles'],
      starships: json['starships'],
    );
  }
}
