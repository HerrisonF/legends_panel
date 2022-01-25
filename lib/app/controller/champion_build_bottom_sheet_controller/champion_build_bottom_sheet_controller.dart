import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/model/data_analysis/data_analysis_model.dart';

class ChampionBuildBottomSheetController {

  Rx<bool> isLoading = false.obs;

  DataAnalysisModel dataAnalysisModel = DataAnalysisModel();

  startLoading(){
    isLoading(true);
  }

  stopLoading(){
    isLoading(false);
  }

  init(String championId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference champions = firestore.collection('champions');
    startLoading();
    champions
        .doc(championId)
        .get()
        .then((value) => transformJson(value))
        .catchError((error) => print("Failed to get champions: $error"));
  }

  transformJson(var value){
    stopLoading();
    print("AQUI > $value");
    dataAnalysisModel.collectionChampionId = value.id;
    dataAnalysisModel = DataAnalysisModel.fromJson(value.data());
  }
}
