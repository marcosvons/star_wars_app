import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'src/core/utils/bool_constants.dart';
import 'src/core/utils/string_constants.dart';
import 'src/data/repositories/planets_repository.dart';
import 'src/data/repositories/repositories.dart';
import 'src/data/repositories/starships_repository.dart';
import 'src/data/repositories/vehicles_repository.dart';
import 'src/domain/repositories/i_planets_repository.dart';
import 'src/domain/repositories/i_repositories_object.dart';
import 'src/domain/repositories/i_starships_repository.dart';
import 'src/domain/repositories/i_vehicles_repository.dart';
import 'src/domain/usecases/get_person_information_usecase.dart';
import 'src/domain/usecases/send_person_information_usecase.dart';
import 'src/presentation/blocs/connection_bloc.dart';
import 'src/presentation/blocs/interfaces/i_connection_bloc.dart';
import 'src/presentation/blocs/interfaces/i_person_bloc.dart';
import 'src/presentation/blocs/person_bloc.dart';
import 'src/core/usecases/i_usecase.dart';
import 'src/data/datasources/remote/api_service.dart';
import 'src/data/repositories/people_repository.dart';
import 'src/domain/repositories/i_people_repository.dart';
import 'src/domain/usecases/get_people_usecase.dart';
import 'src/presentation/blocs/interfaces/i_people_bloc.dart';
import 'src/presentation/blocs/people_bloc.dart';
import 'src/presentation/views/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late IPeopleBloc _peopleBloc;
  late UseCase _getPeopleUsecase;
  late IPeopleRepository _peopleRepository;
  late ApiService _apiService;
  late http.Client _client;
  late IStarshipsRepository _starshipsRepository;
  late IVehiclesRepository _vehiclesRepository;
  late IPlanetsRepository _planetsRepository;
  late IRepositoriesObject _repositories;
  late UseCase _getPersonInformationUseCase;
  late IPersonBloc _personBloc;
  late IConnectionBloc _connectionBloc;
  late SendPersonInformationUseCase _sendPersonInformationUseCase;

  @override
  void initState() {
    _client = http.Client();
    _apiService = ApiService(client: _client);
    _starshipsRepository = StarshipsRepository(_apiService);
    _planetsRepository = PlanetsRepository(_apiService);
    _vehiclesRepository = VehiclesRepository(_apiService);
    _repositories = RepositoriesObject(
      _planetsRepository,
      _starshipsRepository,
      _vehiclesRepository,
    );
    _peopleRepository = PeopleRepository(
      _apiService,
      _repositories,
    );
    _sendPersonInformationUseCase =
        SendPersonInformationUseCase(_peopleRepository);
    _getPersonInformationUseCase =
        GetPersonInformationUseCase(_peopleRepository);
    _personBloc = PersonBloc(
      _getPersonInformationUseCase,
      _sendPersonInformationUseCase,
    );
    _getPeopleUsecase = GetPeopleUseCase(_peopleRepository);
    _peopleBloc = PeopleBloc(_getPeopleUsecase);
    _connectionBloc = ConnectionBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IPeopleBloc>.value(value: _peopleBloc),
        Provider<IPersonBloc>.value(value: _personBloc),
        Provider<IConnectionBloc>.value(value: _connectionBloc),
      ],
      child: const MaterialApp(
        title: StringConstants.appTitle,
        home: Menu(),
        debugShowCheckedModeBanner: BoolConstants.showDebugBanner
      ),
    );
  }
}
