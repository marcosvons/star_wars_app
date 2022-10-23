import '../../domain/repositories/i_planets_repository.dart';
import '../../domain/repositories/i_starships_repository.dart';
import '../../domain/repositories/i_vehicles_repository.dart';
import '../../domain/repositories/i_repositories_object.dart';

class RepositoriesObject implements IRepositoriesObject {
  final IPlanetsRepository _planetsRepository;
  final IStarshipsRepository _starshipsRepository;
  final IVehiclesRepository _vehiclesRepository;

  RepositoriesObject(
    this._planetsRepository,
    this._starshipsRepository,
    this._vehiclesRepository,
  );

  @override
  IPlanetsRepository get planetsRepository => _planetsRepository;

  @override
  IStarshipsRepository get starshipRepository => _starshipsRepository;

  @override
  IVehiclesRepository get vehiclesRepository => _vehiclesRepository;
}
