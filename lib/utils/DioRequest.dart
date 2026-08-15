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
      ..receiveTimeout = Duration(seconds: GloblConstants.TIME_OUT)
      ..headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
        'Accept-Encoding': 'gzip, deflate',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Referer': 'http://meikou-api.itheima.net/',
        'Origin': 'http://meikou-api.itheima.net',
        'Sec-Fetch-Dest': 'empty',
        'Sec-Fetch-Mode': 'cors',
        'Sec-Fetch-Site': 'same-origin',
      };

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

  Future<dynamic> post(url, {Map<String, dynamic>? data}) {
    return _handelResponse(_dio.post(url, data: data));
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
