import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../core/utils/bool_constants.dart';
import '../blocs/interfaces/i_connection_bloc.dart';
import 'people_list.dart';
import '../../core/utils/assets_constants.dart';
import '../../core/utils/dimension_constants.dart';
import '../../core/utils/palette.dart';
import '../../core/utils/string_constants.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsConstants.pathToBackgroundImg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                StringConstants.appTitle,
                style: TextStyle(
                  color: Palette.starWarsYellow,
                  fontFamily: AssetsConstants.appTitleFont,
                  fontSize: Dimensions.menuTitleFontSize,
                ),
              ),
              Lottie.asset(AssetsConstants.menuAnimation),
              const Text(
                StringConstants.welcomeMessage,
                style: TextStyle(
                  fontFamily: AssetsConstants.appMainFont,
                  fontSize: Dimensions.menuMessageFontSize,
                  color: Palette.starWarsYellow,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PeopleList(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Palette.buttonsBackgroundColor,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(Dimensions.menuButtonPadding),
                  child: Text(
                    StringConstants.menuButton,
                    style: TextStyle(
                      fontFamily: AssetsConstants.appMainFont,
                      fontSize: Dimensions.menuButtonFontSize,
                      color: Palette.starWarsYellow,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Text(
                StringConstants.connectionText,
                style: TextStyle(
                  fontFamily: AssetsConstants.appMainFont,
                  fontSize: Dimensions.menuButtonFontSize,
                  color: Palette.starWarsYellow,
                ),
                textAlign: TextAlign.center,
              ),
              Switch(
                value: Provider.of<IConnectionBloc>(
                  context,
                  listen: BoolConstants.listenProvider,
                ).getConnectionStatus,
                onChanged: (value) {
                  Provider.of<IConnectionBloc>(
                    context,
                    listen: BoolConstants.listenProvider,
                  ).setConnectionStatus = value;
                  setState(() {});
                },
                activeColor: Palette.openConnection,
                inactiveTrackColor: Palette.closedConnection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
