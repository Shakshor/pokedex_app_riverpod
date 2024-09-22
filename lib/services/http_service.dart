

import 'dart:developer';

import 'package:dio/dio.dart';

class HTTPService{
  HTTPService();

  final _dio = Dio();

  Future<Response?> get(String path) async{
    try{
      Response res = await _dio.get(path);
      log('response_in_http_service: ${res.statusCode}');
      return res;
    }catch(e){
      log('error_in_dio: ${e.toString()}');
    }
    return null;
  }
}