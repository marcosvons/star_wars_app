import '../entities/starship_event.dart';

abstract class IStarshipsRepository {
  Future<StarshipEvent> fetchStarshipInformation({required List<dynamic> starshipsEndpoint});
}
