import 'package:star_wars_app/src/domain/entities/starship_event.dart';

abstract class IStarshipsRepository {
  Future<StarshipEvent> fetchStarshipInformation({required List<dynamic> starshipsEndpoint});
}