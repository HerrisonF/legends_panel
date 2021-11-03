final String imageAssetsRoot = "images/";
final String imageRockTopLeft = _getImagePath("objRockTl.png");
final String imageRockTopRight = _getImagePath("objRockTr.png");
final String imagePengu = _getImagePath("objPengu.png");

String _getImagePath(String fileName){
  return imageAssetsRoot + fileName;
}