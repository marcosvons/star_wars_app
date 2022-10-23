import 'interfaces/i_connection_bloc.dart';

class ConnectionBloc implements IConnectionBloc {
  bool _isConnected = true;

  @override
  bool get getConnectionStatus => _isConnected;

  @override
  set setConnectionStatus(bool status) => _isConnected = status;

}