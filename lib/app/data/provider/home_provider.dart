import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:legends_panel/app/data/http/config/logging_interceptor.dart';
import 'package:legends_panel/app/data/model/user.dart';

class HomeApiClient {
  GetStorage box = GetStorage('default_storage');

  final String path = "/lol/summoner/v4/summoners/by-name/houtebeen";

  LoggingInterceptor loggingInterceptor = LoggingInterceptor();

  Future<User> getAlgo() async {
    try {
      final response = await loggingInterceptor.dio.get(path);
      print(response.data.toString());
    } catch (e) {
      print("DEU RUIM $e");
    }
    return User();
  }
}
