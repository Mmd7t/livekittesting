import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:livekit_example/config/constants.dart';

class DioHelper {
  DioHelper();

  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      receiveDataWhenStatusError: true,
    );

    final dio = Dio(options);

    dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) {
      final headers = {'x-api-key': Constants.xApiKey};
      options.headers.addAll(headers);

      log("--> ${options.method} ${"${options.baseUrl}${options.path}"}");
      log('Headers:');
      options.headers.forEach((k, dynamic v) => log('$k: $v'));
      log('queryParameters:');
      options.queryParameters.forEach((k, dynamic v) => log('$k: $v'));
      log(
        '--> END ${options.method}',
      );

      // if (options.headers.containsKey('isToken')) {
      // options.headers.remove('isToken');
      // }

      // Do something before request is sent
      log('\n'
          '------------ Headers ------------\n'
          '${options.headers.toString()}'
          '\n'
          '------------ Request ------------ \n --> body '
          '${options.data}'
          '\n'
          '');

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (response, handler) {
      // Do something with response data
      log('\n'
          'Response : ${response.requestOptions.uri} \n'
          '------------ Headers ------------\n'
          '${response.headers.toString()} \n'
          '------------ Response ------------\n'
          '${jsonEncode(response.data)} \n'
          '');

      return handler.next(response); // continue
    }, onError: (error, handler) {
      // Do something with response error
      log('\n'
          '------------ Response Error ------------ \n'
          '${error.message}'
          '\n'
          '${error.response!.data}'
          '\n'
          '');
      return handler.next(error); //continue
    });
  }
}
