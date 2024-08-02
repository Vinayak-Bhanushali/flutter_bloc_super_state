import 'package:dio/dio.dart';

import 'api_interceptor.dart';

class DioBuilderResponse {
  Dio dio;
  Options dioOptions;

  DioBuilderResponse({required this.dio, required this.dioOptions});
}

class DioBuilder {
  DioBuilderResponse buildNonCachedDio({
    required String baseUrl,
    String? apiKey,
    bool shouldQueue = false,
  }) {
    Options dioOptions = _getDioOptions();

    final heaaders = {
      'Content-Type': 'application/json',
    };

    if (apiKey != null) {
      heaaders['X-API-Key'] = apiKey;
    }

    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 15000,
        receiveTimeout: 15000,
        headers: heaaders,
      ),
    );

    dio.interceptors.add(DioInterceptor(dio));
    if (shouldQueue) dio.interceptors.add(QueuedInterceptor());
    return DioBuilderResponse(dio: dio, dioOptions: dioOptions);
  }

  Options _getDioOptions() {
    return Options(
      followRedirects: false,
    );
  }
}
