import 'dart:convert';
import 'dart:io';

import 'package:booking_services_riverpod/app/constant.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  final Dio dio;

  BaseRepository({required this.dio});
   

  Future<dynamic> gets(
      {String? param =null, required services, String? token}) async {
    try {
      final response = await dio.get(
        param != null ? "${services}/" + param : "${services}",
        options: Options(
          headers: token != null
              ? {
                  HttpHeaders.contentTypeHeader: "application/json",
                  HttpHeaders.authorizationHeader: "Bearer $token",
                }
              : {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
          contentType: "aplication/json",
        ),
      );
      print(response);
      
     
      return response.data;
    } on DioError catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on SocketException catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on BaseRepositoryException catch (e) {
      throw BaseRepositoryException(message: e.message);
    }
  }

  Future<Map<String, dynamic>> post({
    required Map<String, dynamic> body,
    required String service,
    String? token,
  }) async {
    try {
  
      final response = await dio.post(
        // Constant.baseUrl + service,
        service,
        data: jsonEncode(body),
        options: Options(
          headers: token != null
              ? {
                  HttpHeaders.contentTypeHeader: "application/json",
                  HttpHeaders.authorizationHeader: "Bearer $token",
                }
              : {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
          contentType: "application/json",
          
        ),
      );
      if (response.statusCode != 200) {
        throw BaseRepositoryException(
          message: "Invalid Http Response ${response.statusCode}",
        );
      }
      print(response.data);
      final data = response.data;
      if (data["status"] != 200) {
        throw BaseRepositoryException(
          message: data["message"],
        );
      } else {
        return data;
      }
    } on DioError catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on SocketException catch (e) {
      throw BaseRepositoryException(message: e.message);
    } on BaseRepositoryException catch (e) {
      throw BaseRepositoryException(message: e.message);
    }
  }
}

class BaseRepositoryException implements Exception {
  final String message;
  BaseRepositoryException({
    required this.message,
  });
}
