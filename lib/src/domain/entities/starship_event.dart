import '../../data/models/starship_model.dart';
import '../../core/utils/status_constants.dart';

class StarshipEvent {
  final List<StarshipModel>? starships;
  final Status status;
  final String? errorMsg;

  StarshipEvent({
    this.starships,
    required this.status,
    this.errorMsg,
  });
}
