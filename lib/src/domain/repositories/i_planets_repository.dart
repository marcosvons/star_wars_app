import '../entities/planet_event.dart';

abstract class IPlanetsRepository {
  Future<PlanetEvent> fetchPlanetInformation({required String planetEndpoint});
}
