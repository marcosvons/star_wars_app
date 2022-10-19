import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'src/core/usecases/i_usecase.dart';
import 'src/data/datasources/remote/api_service.dart';
import 'src/data/repositories/people_repository.dart';
import 'src/domain/repositories/i_people_repository.dart';
import 'src/domain/usecases/get_people_usecase.dart';
import 'src/presentation/blocs/interfaces/i_people_bloc.dart';
import 'src/presentation/blocs/people_bloc.dart';
import 'src/presentation/views/people_list.dart';

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

  @override
  void initState() {
    _client = http.Client();
    _apiService = ApiService(client: _client);
    _peopleRepository = PeopleRepository(_apiService);
    _getPeopleUsecase = GetPeopleUseCase(_peopleRepository);
    _peopleBloc = PeopleBloc(_getPeopleUsecase);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IPeopleBloc>.value(value: _peopleBloc),
      ],
      child: MaterialApp(
        title: 'Star Wars',
        theme: ThemeData(),
        home: const PeopleList(),
      ),
    );
  }
}
