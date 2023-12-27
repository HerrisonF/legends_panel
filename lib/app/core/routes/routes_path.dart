abstract class RoutesPath {

  ///INICIO DA APLICAÇÃO
  static const SPLASHSCREEN = "/";

  /// TELAS INICIAIS. AS REFERENTES À BOTTOM BAR.
  static const PROFILE_PAGE = "/profile_search";
  static const ACTIVE_GAME_SEARCH_PAGE = "/active_search_game";
  static const ABOUT_PAGE = "/about";

  /// SUB TELAS
  static const ACTIVE_GAME_RESULT = "/active_game_result";
  static const PROFILE_SUB = "/profile_found_result";

  /// Essas variáveis servem para substituir os números mágicos de cada página
  /// no menuNavigator.
  static int profileSearchPageIndex = 0;
  static int activeGamePageIndex = 1;
  static int aboutPageIndex = 2;
}