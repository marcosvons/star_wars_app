import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../core/utils/assets_constants.dart';
import '../../core/utils/dimension_constants.dart';
import '../../core/utils/palette.dart';
import '../../core/utils/service_constants.dart';
import '../../core/utils/string_constants.dart';
import '../blocs/interfaces/i_people_bloc.dart';

Widget error(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Lottie.asset(AssetsConstants.errorAnimationPath),
      const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.emptyErrorTextHorizontalPadding,
          vertical: Dimensions.emptyErrorTextVerticalPadding,
        ),
        child: Text(
          StringConstants.errorMessage,
          style: TextStyle(
            fontSize: Dimensions.emptyErrorTextFontSize,
            fontFamily: AssetsConstants.appMainFont,
            color: Palette.starWarsYellow,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      TextButton(
        onPressed: () {
          Provider.of<IPeopleBloc>(context, listen: false).getPeople(
            endpoint: ServiceConstants.endpoints[StringConstants.peopleString]!,
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Palette.buttonsBackgroundColor,
          ),
        ),
        child: const Text(
          StringConstants.tryAgainButton,
          style: TextStyle(
            color: Palette.starWarsYellow,
            fontFamily: AssetsConstants.secondaryFont,
            fontSize: Dimensions.tryAgainButtonFontSize,
          ),
        ),
      ),
    ],
  );
}
