import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/utils/assets_constants.dart';
import '../../core/utils/dimension_constants.dart';
import '../../core/utils/palette.dart';
import '../../core/utils/status_constants.dart';
import '../../core/utils/string_constants.dart';

Widget propertiesList({
  required Status status,
  List? list,
}) {
  switch (status) {
    case Status.initial:
    case Status.loading:
    case Status.success:
      return Expanded(
        flex: list!.length,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return AutoSizeText(
              list[index].name.toLowerCase(),
              style: const TextStyle(
                fontFamily: AssetsConstants.appMainFont,
                fontSize: Dimensions.characterDetailFontSize,
                color: Palette.starWarsYellow,
              ),
              maxLines: 2,
              textAlign: TextAlign.end,
            );
          },
        ),
      );
    case Status.empty:
      return const Expanded(
        flex: Dimensions.detailPropertiesFlex,
        child: Text(
          StringConstants.noneProperty,
          style: TextStyle(
              fontFamily: AssetsConstants.appMainFont,
              fontSize: Dimensions.characterDetailFontSize,
              color: Palette.starWarsYellow),
          textAlign: TextAlign.center,
        ),
      );
    case Status.error:
      return const Expanded(
        flex: Dimensions.detailPropertiesFlex,
        child: AutoSizeText(
          StringConstants.errorProperty,
          style: TextStyle(
            fontFamily: AssetsConstants.appMainFont,
            fontSize: Dimensions.characterDetailFontSize,
            color: Palette.starWarsYellow,
          ),
          textAlign: TextAlign.center,
        ),
      );
  }
}
