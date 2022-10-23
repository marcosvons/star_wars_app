import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/utils/assets_constants.dart';
import '../../core/utils/dimension_constants.dart';
import '../../core/utils/palette.dart';

Widget characterInformation({
  required String information,
  required int flex,
  required TextAlign align,
}) {
  return Expanded(
    flex: flex,
    child: AutoSizeText(
      information,
      style: const TextStyle(
        fontFamily: AssetsConstants.appMainFont,
        fontSize: Dimensions.characterDetailFontSize,
        color: Palette.starWarsYellow,
      ),
    ),
  );
}
