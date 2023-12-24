abstract class RoutesPath {

  /// TELAS INICIAIS. AS REFERENTES À BOTTOM BAR.
  static const PROFILE_PAGE = "/profile";
  static const CURRENT_GAME_PAGE = "/current_game";
  static const ABOUT_PAGE = "/about";

  /// SUB TELAS
  static const PROFILE_SUB = "/profile_sub";
  static const SPLASHSCREEN = "/";

  /// Essas variáveis servem para substituir os números mágicos de cada página
  /// no menuNavigator.
  static int profilePageIndex = 0;
  static int currentGamePageIndex = 1;
  static int aboutPageIndex = 2;
}