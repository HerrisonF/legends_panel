import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository_local_impl.dart';
import 'package:legends_panel/app/modules/app_initialization/data/repositories/splash_repository/splash_repository_remote_impl.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/models/lol_constants/lol_constants_model.dart';
import 'package:legends_panel/app/modules/app_initialization/domain/usecases/game_constants_usecase/fetch_game_constants_usecase_impl.dart';
import 'package:legends_panel/app/modules/app_initialization/presenter/splashscreen_page/splashscreen_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
    super.initState();
    SplashscreenController(
      callback: goToProfilePage,
      fetchGameConstantsUsecase: FetchGameConstantsUsecaseImpl(
        remoteRepository: SplashRepositoryRemoteImpl(
          httpServices: GetIt.I<HttpServices>(),
        ),
        localRepository: SplashRepositoryLocalImpl(
          sharedPreferences: GetIt.I<SharedPreferences>(),
        ),
        localization: Platform.localeName,
      ),
      generalController: GetIt.I<GeneralController>(),
    );
  }

  goToProfilePage(LolConstantsModel lolConstantsModel) {
    context.go(
      RoutesPath.PROFILE_PAGE,
      extra: lolConstantsModel,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _linearBlueBackground(context),
        child: Stack(
          children: [
            _rockImageOne(context),
            _rockImageTwo(context),
            _rockImageThree(context),
            _rockImageFour(context),
            _rockImageFive(context),
            _penguImage(context),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _applicationNameTitle(context),
                _applicationNameSubTitle(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _applicationNameTitle(BuildContext context) {
    return _textSplashscreenMaker(
      text: AppLocalizations.of(context)!.appNameTitle,
    );
  }

  Widget _applicationNameSubTitle(BuildContext context) {
    return _textSplashscreenMaker(
      text: AppLocalizations.of(context)!.appNameSubTitle,
      margin: 15,
    );
  }

  Positioned _penguImage(BuildContext context) {
    return Positioned(
      child: Image(
        image: AssetImage(imagePengu),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
      right: -2,
      bottom: -2,
    );
  }

  Positioned _rockImageFive(BuildContext context) {
    return Positioned(
      child: Image(
        image: AssetImage(imageRockTopLeft),
        height: MediaQuery.of(context).size.height / 2.2,
      ),
      left: MediaQuery.of(context).size.width / 2,
      bottom: MediaQuery.of(context).size.width / 2,
    );
  }

  Positioned _rockImageFour(BuildContext context) {
    return Positioned(
      child: Image(
        image: AssetImage(imageRockTopLeft),
        height: MediaQuery.of(context).size.height / 2.2,
      ),
      left: 0,
      bottom: 0,
    );
  }

  Positioned _rockImageThree(BuildContext context) {
    return Positioned(
      child: Image(
        image: AssetImage(imageRockTopLeft),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
      left: MediaQuery.of(context).size.width / 1.5,
      top: -150,
    );
  }

  Positioned _rockImageTwo(BuildContext context) {
    return Positioned(
      child: Image(
        image: AssetImage(imageRockTopRight),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
      left: MediaQuery.of(context).size.width / 2,
      top: 150,
    );
  }

  Positioned _rockImageOne(BuildContext context) {
    return Positioned(
      child: Image(
        image: AssetImage(imageRockTopRight),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
      left: 0,
      top: 0,
    );
  }

  BoxDecoration _linearBlueBackground(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.1),
        ],
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
      ),
    );
  }

  Widget _textSplashscreenMaker({String? text, double? margin}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: margin ?? 0),
      child: FadeTransition(
        opacity: _animation,
        child: Text(
          text ?? "",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              letterSpacing: 1.2,
              color: Colors.white,
              shadows: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16,
                  offset: Offset(0, 2),
                ),
              ],
              fontSize: 38,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
