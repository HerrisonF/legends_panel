final String imageAssetsRoot = "images/";
final String imageRockTopLeft = _getImagePath("objRockTl.png");
final String imageRockTopRight = _getImagePath("objRockTr.png");
final String imagePengu = _getImagePath("objPengu.png");
final String imageBackgroundCurrentGame = _getImagePath("home_background/trials2019_generic_celebration.png");
final String imageBackgroundProfilePengu = _getImagePath("background_current_game_pengu_store.png");
final String imageBackgroundAboutPage = _getImagePath("background_about_page.png");
final String imageBackgroundAboutPage2 = _getImagePath("background_about_page_2.png");
final String imageBackgroundProfilePage = _getImagePath("profile_page_background.jpeg");
final String imageIconItemNone = _getImagePath("icon_item_none.png");
final String imageMapSelect = _getImagePath("map_select.jpeg");
final String imageDivider = _getImagePath("divider.png");
final String imageNoChampion = _getImagePath("no_champion.png");
final String imageUnranked = _getImagePath("unranked_icon.png");

String _getImagePath(String fileName){
  return imageAssetsRoot + fileName;
}