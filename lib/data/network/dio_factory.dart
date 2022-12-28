import 'package:dio/dio.dart';
import 'package:shopping_app/app/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "athorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  Future<Dio> getDio() async{
    Dio dio = Dio();

    int _timeOut = 60*1000; // a min time out

    Map<String, String> headers = 
    {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "SEND TOKEN HERE",
      DEFAULT_LANGUAGE: "eng", //TODO get lang from app prefs
      CONTENT_TYPE: APPLICATION_JSON,
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: _timeOut,
      sendTimeout: _timeOut
    );
    return dio;
  }
}
