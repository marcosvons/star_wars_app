import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/utils/assets_constants.dart';
import '../../core/utils/dimension_constants.dart';

Widget loading() {
  return Center(
    child: SizedBox(
      height: Dimensions.loaderHeight,
      child: Lottie.asset(AssetsConstants.loaderPath),
    ),
  );
}
