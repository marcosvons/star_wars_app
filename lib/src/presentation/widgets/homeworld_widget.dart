import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/utils/string_constants.dart';
import '../../core/utils/assets_constants.dart';
import '../../core/utils/dimension_constants.dart';
import '../../core/utils/palette.dart';
import '../../core/utils/status_constants.dart';

Widget homeworldWidget({
  required Status status,
  required flex,
  String? homeworld,
}) {
  switch (status) {
    case Status.initial:
    case Status.loading:
    case Status.success:
      return Expanded(
        flex: flex,
        child: AutoSizeText(
          homeworld!,
          style: const TextStyle(
            fontFamily: AssetsConstants.appMainFont,
            fontSize: Dimensions.characterDetailFontSize,
            color: Palette.starWarsYellow,
          ),
          textAlign: TextAlign.end,
        ),
      );
    case Status.empty:
      return const Text(
        StringConstants.noDetailProperty,
        style: TextStyle(
          fontFamily: AssetsConstants.appMainFont,
          fontSize: Dimensions.characterDetailFontSize,
          color: Palette.starWarsYellow,
        ),
        textAlign: TextAlign.end,
      );
    case Status.error:
      return const Expanded(
        flex: Dimensions.detailPropertiesFlex,
        child: AutoSizeText(
          StringConstants.errorMessageDetailProperties,
          style: TextStyle(
            fontFamily: AssetsConstants.appMainFont,
            fontSize: Dimensions.characterDetailFontSize,
            color: Palette.starWarsYellow,
          ),
          textAlign: TextAlign.end,
          maxLines: Dimensions.detailMaxLines,
        ),
      );
  }
}
