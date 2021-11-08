final String imageAssetsRoot = "images/";
final String imageRockTopLeft = _getImagePath("objRockTl.png");
final String imageRockTopRight = _getImagePath("objRockTr.png");
final String imagePengu = _getImagePath("objPengu.png");
final String imageBackgroundCurrentGame = _getImagePath("background_current_game_soul.png");
final String imageBackgroundProfilePengu = _getImagePath("background_current_game_pengu_store.png");
final String imageBackgroundAboutPage = _getImagePath("background_about_page.png");

String _getImagePath(String fileName){
  return imageAssetsRoot + fileName;
}