import 'package:dio/dio.dart';
import 'package:legends_panel/app/data/http/config/dio_interceptors_header.dart';
import 'package:legends_panel/app/data/http/config/dio_state.dart';
import 'package:logger/logger.dart';

class DioClient {
  Dio instance = Dio();
  final log = Logger();

  static const int _SUCCESS = 200;
  static const int _UNAUTHORIZED = 401;

  final String riotBaseAmericasUrl = "https://americas.api.riotgames.com";
  final String riotBaseAsiaUrl = "https://asia.api.riotgames.com";
  final String riotBaseEuropeUrl = "https://europe.api.riotgames.com";
  final String riotDragonBaseUrl = "https://ddragon.leagueoflegends.com";
  final String rawDragonBaseUrl = "https://raw.communitydragon.org";
  final String riotStaticConstBaseUrl =
      "https://static.developer.riotgames.com";

  DioClient({
    riotDragon = false,
    rawDragon = false,
    riotStaticConst = false,
    americas = false,
    asia = false,
    europe = false,
    region = "br1",
  }) {
    BaseOptions options = BaseOptions(
      baseUrl:
          getBaseUrl(riotDragon, rawDragon, riotStaticConst, americas, region, asia, europe),
      responseType: ResponseType.json,
    );
    instance = Dio(options);
    instance.interceptors.clear();
    instance.interceptors.add(HeadersInterceptor(dioClient: instance));
  }

  String getBaseUrl(bool riotDragon, bool rawDragon, bool riotStaticConst,
      bool americas, String region, bool asia, bool europe) {
    if (riotDragon) {
      return riotDragonBaseUrl;
    } else if (rawDragon) {
      return rawDragonBaseUrl;
    } else if (riotStaticConst) {
      return riotStaticConstBaseUrl;
    } else if (americas) {
      return riotBaseAmericasUrl;
    }else if (asia) {
      return riotBaseAsiaUrl;
    }else if (europe) {
      return riotBaseEuropeUrl;
    }
    return "https://$region.api.riotgames.com";
  }

  Future<DioState> post(String path, String data, [queryParameters]) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await instance.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      log.d(' PATH $path executed in ${stopwatch.elapsed}');
      stopwatch.stop();
      if (response.statusCode == _SUCCESS) {
        return DioState(CustomState.SUCCESS, response);
      } else if (response.statusCode == _UNAUTHORIZED) {
        return DioState(CustomState.UNAUTHORIZED, response);
      }
      return DioState(CustomState.BAD_REQUEST, response);
    } on DioError catch (e) {
      print("ERROR: ${e.error.toString()}");
      return DioState(CustomState.BAD_REQUEST, e.response!.data);
    }
  }

  Future<DioState> get(String path, [queryParameters]) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await instance.get(
        path,
        queryParameters: queryParameters,
      );
      log.d(' PATH $path executed in ${stopwatch.elapsed}');
      stopwatch.stop();
      if (response.statusCode == _SUCCESS) {
        return DioState(CustomState.SUCCESS, response);
      } else if (response.statusCode == _UNAUTHORIZED) {
        return DioState(CustomState.UNAUTHORIZED, response);
      }
      log.d(' Not found:  ${response.data}');
      return DioState(CustomState.BAD_REQUEST, response);
    } on DioError catch (e) {
      print("ERROR: ${e.error.toString()}");
      return DioState(CustomState.BAD_REQUEST, e.response!.data);
    }
  }
}
