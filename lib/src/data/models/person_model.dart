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
    required String url,
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
          url: url,
        );

  factory PersonModel.fromJson({required json}) {
    return PersonModel(
      name: json['name'].toLowerCase(),
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hair_color'].toLowerCase(),
      skinColor: json['skin_color'].toLowerCase(),
      eyeColor: json['eye_color'].toLowerCase(),
      birthYear: json['birth_year'],
      gender: json['gender'].toLowerCase(),
      homeworld: json['homeworld'].toLowerCase(),
      films: json['films'],
      species: json['species'],
      vehicles: json['vehicles'],
      starships: json['starships'],
      url: json['url'],
    );
  }

  static Map<String, dynamic> toJson(PersonModel person) {
    return {
      'id': person.url.substring(
        person.url.indexOf('people') + 7,
        person.url.lastIndexOf('/'),
      ),
      'name': person.name,
      'height': person.height,
      'mass': person.mass,
      'hair_color': person.hairColor,
      'skin_color': person.skinColor,
      'eye_color': person.eyeColor,
      'birth_year': person.birthYear,
      'gender': person.gender,
      'homeworld': person.homeworld,
      'films': person.films,
      'species': person.species,
      'vehicles': person.vehicles,
      'starships': person.starships,
      'url': person.url,
    };
  }
}
