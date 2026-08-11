import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/constants/index.dart';

class Diorequest {
  final _dio = Dio();

  Diorequest() {
    _dio.options
      ..baseUrl = GloblConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GloblConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GloblConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GloblConstants.TIME_OUT);

    _addInterceptor();
  }
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, Handle) {
          if (response.statusCode! >= 200 && response.statusCode! <= 300) {
            Handle.next(response);
            return;
          }
          Handle.reject(DioException(requestOptions: response.requestOptions));
        },
        onRequest: (request, Handle) {
          Handle.next(request);
        },
        onError: (error, Handle) {
          Handle.reject(error);
        },
      ),
    );
  }

  Future<dynamic> get(url, {Map<String, dynamic>? params}) {
    return _handelResponse(_dio.get(url, queryParameters: params));
  }

  // 进一步处理返回的数据

  Future<dynamic> _handelResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GloblConstants.SUCCESS_CODE) {
        return data['result'];
      }

      throw Exception(data['msg'] ?? '数据加载异常');
    } catch (e) {
      throw Exception(e);
    }
  }
}

final dioRequest = Diorequest();
