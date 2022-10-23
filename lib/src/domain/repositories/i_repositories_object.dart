import 'i_planets_repository.dart';
import 'i_starships_repository.dart';
import 'i_vehicles_repository.dart';

abstract class IRepositoriesObject {
  IPlanetsRepository get planetsRepository;
  IVehiclesRepository get vehiclesRepository;
  IStarshipsRepository get starshipRepository;
}
