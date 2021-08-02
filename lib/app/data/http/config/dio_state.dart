import 'package:dio/dio.dart';

enum CustomState { SUCCESS, BAD_REQUEST, UNAUTHORIZED }

class DioState {
  final CustomState state;
  final Response result;
  DioState(this.state, this.result);
}