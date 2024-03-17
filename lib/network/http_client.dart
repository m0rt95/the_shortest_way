import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../database/dao/server_ip_dao.dart';
import 'error/error_handler.dart';

@LazySingleton(as: HttpClientBase)
class HttpClient implements HttpClientBase {
  HttpClient({
    required this.serverIpDao,
    required this.errorHandler,
  }) {
    final _logInterceptor = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      compact: false,
    );

    headers = {
      'Fic-App-Version': '1.0.0',
      'Accept': 'application/json',
      // You can specify the client type directly here
      // 'Fi-Client-Type': '${AppType.flutter.apiType}',
    };
    httpClient = dio.Dio();
    httpClient.interceptors.add(_logInterceptor);
  }

  late Map<String, String> headers;
  late dio.Dio httpClient;
  final UrlSourceI serverIpDao;
  final ErrorHandlerI errorHandler;

  @override
  Future<dio.Response<dynamic>> fetch({
    required HttpRequestConst httpRequest,
    String contentType = 'application/json',
  }) async {
    headers['content-type'] = contentType;

    late String url;

    //final String baseUrl = httpRequest.baseUrl ?? await serverIpDao.getApiUrl();
    url = '${httpRequest.method}/';
    dynamic response;
    try {
      if (httpRequest.type == HttpRequestType.post) {
        response = await httpClient.post<dynamic>(
          url,
          data: httpRequest.body,
          options: dio.Options(
            headers: headers,
            validateStatus: (_) => true,
            sendTimeout: const Duration(seconds: 115),
            receiveTimeout: const Duration(seconds: 15),
          ),
          onSendProgress: httpRequest.onSendProgress,
        );
      } else if (httpRequest.type == HttpRequestType.get) {
        response = await httpClient.get<dynamic>(
          url,
          options: dio.Options(
            headers: headers,
            validateStatus: (_) => true,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 15),
          ),
        );
      }
    } on Exception catch (error) {
      // Handle Dio errors
      await errorHandler.handleDioError(error, StackTrace.empty);
    }

    // Handle response and return
    return errorHandler.handleError(response as dio.Response<dynamic>);
  }
}

abstract class HttpClientBase {
  Future<dio.Response<dynamic>> fetch(
      {required HttpRequestConst httpRequest,
      String contentType = 'application/json'});
}

class HttpRequestConst {
  HttpRequestConst.post({
    required this.method,
    this.onSendProgress,
    this.body,
    this.baseUrl,
  }) : type = HttpRequestType.post;

  HttpRequestConst.get({
    required this.method,
    this.baseUrl,
  })  : body = null,
        onSendProgress = null,
        type = HttpRequestType.get;
  final HttpRequestType type;
  final String method;
  final String? baseUrl;
  final Object? body;
  final void Function(int bytes, int totalBytes)? onSendProgress;
}

enum HttpRequestType { post, get }
