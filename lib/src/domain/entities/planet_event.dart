import 'package:star_wars_app/src/data/models/planet_model.dart';

import '../../core/utils/status_constants.dart';

class PlanetEvent {
  final PlanetModel? planet;
  final Status status;
  final String? errorMsg;

  PlanetEvent({
    this.planet,
    required this.status,
    this.errorMsg,
  });
}
