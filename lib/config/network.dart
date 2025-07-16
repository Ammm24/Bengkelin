// lib/config/network.dart

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bengkelin/config/model/resp.dart';
import 'package:flutter_bengkelin/config/endpoint.dart';
import 'package:flutter_bengkelin/config/pref.dart'; // Pastikan path ini benar untuk Session()

class Network {
  static final Network _instance = Network._internal();
  factory Network() => _instance;
  Network._internal();

  static Dio _createDioInstance({String? overrideBaseUrl}) {
    String actualBaseUrl = overrideBaseUrl ?? Endpoint.baseUrl;
    debugPrint('Dio Base URL: $actualBaseUrl');
    return Dio(
        BaseOptions(
          baseUrl: actualBaseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
          contentType: 'application/json',
        ),
      )
      ..interceptors.addAll([
        // Jika Anda memiliki Interceptor, aktifkan di sini
        // AuthorizationInterceptor(),
        // LoggerInterceptor(),
        // LanguageInterceptor(),
      ]);
  }

  static Future<Resp> postApi(String url, dynamic formData) async {
    try {
      var dio = _createDioInstance();
      debugPrint('Sending POST request to: ${dio.options.baseUrl}$url');
      Response rest = await dio.post(url, data: formData);
      dio.close();
      // Cek apakah data adalah Map sebelum memanggil fromJson
      if (rest.data is Map<String, dynamic>) {
        return Resp.fromJson(rest.data);
      } else {
        // Jika bukan Map, bungkus dalam Resp dengan data mentah
        return Resp(
          code: rest.statusCode ?? 200,
          message: 'Unexpected response format for POST',
          data: rest.data,
        );
      }
    } on DioException catch (e) {
      debugPrint('DioException (postApi) - URL: ${e.requestOptions.uri}');
      debugPrint(
        'DioException (postApi) - Response status: ${e.response?.statusCode}',
      );
      debugPrint('DioException (postApi) - Response data: ${e.response?.data}');

      if (e.response != null) {
        // Coba parsing sebagai JSON Map jika memungkinkan
        if (e.response!.data is Map<String, dynamic>) {
          return Resp.fromJson(e.response!.data);
        } else if (e.response!.data is String) {
          try {
            final decodedError = json.decode(e.response!.data);
            if (decodedError is Map<String, dynamic>) {
              return Resp.fromJson(decodedError);
            } else {
              return Resp(
                code: e.response!.statusCode,
                message: decodedError.toString(),
                error: e.response!.data,
              );
            }
          } catch (_) {
            // String tidak bisa di-decode sebagai JSON
            return Resp(
              code: e.response!.statusCode,
              message: e.response!.statusMessage ?? 'Server error',
              error: e.response!.data,
            );
          }
        } else {
          // Tipe data respons error yang tidak terduga
          return Resp(
            code: e.response!.statusCode,
            message: 'Unexpected error response format',
            error: e.response!.data.toString(),
          );
        }
      } else {
        return Resp(
          code: 500,
          message: e.message ?? 'Unknown network error',
          error: e.toString(),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error (postApi): $e');
      return Resp(
        code: 500,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  static Future<Resp> postApiWithHeaders(
    String url,
    dynamic body,
    Map<String, dynamic> header,
  ) async {
    try {
      var dio = _createDioInstance();
      debugPrint("url: $url");
      Response restValue = await dio.post(
        url,
        data: body,
        options: Options(headers: header),
      );
      debugPrint("postApiWithHeaders: ${restValue.data}");
      dio.close();
      header.clear();
      if (restValue.data is Map<String, dynamic>) {
        return Resp.fromJson(restValue.data);
      } else {
        return Resp(
          code: restValue.statusCode ?? 200,
          message: 'Unexpected response format for POST with headers',
          data: restValue.data,
        );
      }
    } on DioException catch (e) {
      debugPrint(
        'DioException (postApiWithHeaders) - URL: ${e.requestOptions.uri}',
      );
      debugPrint(
        'DioException (postApiWithHeaders) - Response status: ${e.response?.statusCode}',
      );
      debugPrint(
        'DioException (postApiWithHeaders) - Response data: ${e.response?.data}',
      );
      if (e.response?.statusCode == 401) {
        await Session().logout();
        // Anda mungkin ingin menavigasi ke halaman login di sini
        // navigatorKey.currentState?.pushNamedAndRemoveUntil('/', (route) => false,);
        return Resp(
          code: 401,
          message: 'Unauthorized',
          error: e.response?.data,
        );
      }
      if (e.response != null) {
        if (e.response!.data is Map<String, dynamic>) {
          return Resp.fromJson(e.response!.data);
        } else if (e.response!.data is String) {
          try {
            final decodedError = json.decode(e.response!.data);
            if (decodedError is Map<String, dynamic>) {
              return Resp.fromJson(decodedError);
            } else {
              return Resp(
                code: e.response!.statusCode,
                message: decodedError.toString(),
                error: e.response!.data,
              );
            }
          } catch (_) {
            return Resp(
              code: e.response!.statusCode,
              message: e.response!.statusMessage ?? 'Server error',
              error: e.response!.data,
            );
          }
        } else {
          return Resp(
            code: e.response!.statusCode,
            message: 'Unexpected error response format',
            error: e.response!.data.toString(),
          );
        }
      } else {
        return Resp(
          code: 500,
          message: e.message ?? 'Unknown network error',
          error: e.toString(),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error (postApiWithHeaders): $e');
      return Resp(
        code: 500,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  static Future<Resp> getApi(String url, {String? baseurl}) async {
    try {
      var dio = _createDioInstance(overrideBaseUrl: baseurl);
      debugPrint('Sending GET request to: ${dio.options.baseUrl}$url');
      Response restGet = await dio.get(url);
      dio.close();

      // *** Modifikasi penting di sini ***
      if (restGet.data is Map<String, dynamic>) {
        // Jika respons adalah Map, coba parse sebagai Resp standar
        return Resp.fromJson(restGet.data);
      } else if (restGet.data is List) {
        // Jika respons adalah List (seperti data kecamatan/kelurahan langsung),
        // bungkus dalam objek Resp dengan status OK
        return Resp(
          code: restGet.statusCode ?? 200,
          success: true,
          data: restGet.data,
        );
      } else {
        // Handle tipe respons lain yang tidak terduga
        return Resp(
          code: restGet.statusCode ?? 500,
          message: 'Unexpected API response format',
          error: restGet.data.toString(),
        );
      }
    } on DioException catch (e) {
      debugPrint('DioException (getApi) - URL: ${e.requestOptions.uri}');
      debugPrint(
        'DioException (getApi) - Response status: ${e.response?.statusCode}',
      );
      debugPrint('DioException (getApi) - Response data: ${e.response?.data}');

      if (e.response != null) {
        if (e.response!.data is Map<String, dynamic>) {
          return Resp.fromJson(e.response!.data);
        } else if (e.response!.data is String) {
          try {
            final decodedError = json.decode(e.response!.data);
            if (decodedError is Map<String, dynamic>) {
              return Resp.fromJson(decodedError);
            } else {
              return Resp(
                code: e.response!.statusCode,
                message: decodedError.toString(),
                error: e.response!.data,
              );
            }
          } catch (_) {
            return Resp(
              code: e.response!.statusCode,
              message: e.response!.statusMessage ?? 'Server error',
              error: e.response!.data,
            );
          }
        } else {
          return Resp(
            code: e.response!.statusCode,
            message: 'Unexpected error response format',
            error: e.response!.data.toString(),
          );
        }
      } else {
        return Resp(
          code: 500,
          message: e.message ?? 'Unknown network error',
          error: e.toString(),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error (getApi): $e');
      return Resp(
        code: 500,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  static Future<Resp> putApi(String url, dynamic formData) async {
    try {
      var dio = _createDioInstance();
      Response restValue = await dio.put(url, data: formData);
      dio.close();
      if (restValue.data is Map<String, dynamic>) {
        return Resp.fromJson(restValue.data);
      } else {
        return Resp(
          code: restValue.statusCode ?? 200,
          message: 'Unexpected response format for PUT',
          data: restValue.data,
        );
      }
    } on DioException catch (e) {
      debugPrint('DioException (putApi) - URL: ${e.requestOptions.uri}');
      debugPrint(
        'DioException (putApi) - Response status: ${e.response?.statusCode}',
      );
      debugPrint('DioException (putApi) - Response data: ${e.response?.data}');
      if (e.response != null) {
        if (e.response!.data is Map<String, dynamic>) {
          return Resp.fromJson(e.response!.data);
        } else if (e.response!.data is String) {
          try {
            final decodedError = json.decode(e.response!.data);
            if (decodedError is Map<String, dynamic>) {
              return Resp.fromJson(decodedError);
            } else {
              return Resp(
                code: e.response!.statusCode,
                message: decodedError.toString(),
                error: e.response!.data,
              );
            }
          } catch (_) {
            return Resp(
              code: e.response!.statusCode,
              message: e.response!.statusMessage ?? 'Server error',
              error: e.response!.data,
            );
          }
        } else {
          return Resp(
            code: e.response!.statusCode,
            message: 'Unexpected error response format',
            error: e.response!.data.toString(),
          );
        }
      } else {
        return Resp(
          code: 500,
          message: e.message ?? 'Unknown network error',
          error: e.toString(),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error (putApi): $e');
      return Resp(
        code: 500,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  static Future<Resp> putApiWithHeaders(
    String url,
    dynamic body,
    Map<String, dynamic> header,
  ) async {
    try {
      var dio = _createDioInstance();
      Response restValue = await dio.put(
        url,
        data: body,
        options: Options(headers: header),
      );
      dio.close();
      header.clear();
      if (restValue.data is Map<String, dynamic>) {
        return Resp.fromJson(restValue.data);
      } else {
        return Resp(
          code: restValue.statusCode ?? 200,
          message: 'Unexpected response format for PUT with headers',
          data: restValue.data,
        );
      }
    } on DioException catch (e) {
      debugPrint(
        'DioException (putApiWithHeaders) - URL: ${e.requestOptions.uri}',
      );
      debugPrint(
        'DioException (putApiWithHeaders) - Response status: ${e.response?.statusCode}',
      );
      debugPrint(
        'DioException (putApiWithHeaders) - Response data: ${e.response?.data}',
      );
      if (e.response != null) {
        if (e.response!.data is Map<String, dynamic>) {
          return Resp.fromJson(e.response!.data);
        } else if (e.response!.data is String) {
          try {
            final decodedError = json.decode(e.response!.data);
            if (decodedError is Map<String, dynamic>) {
              return Resp.fromJson(decodedError);
            } else {
              return Resp(
                code: e.response!.statusCode,
                message: decodedError.toString(),
                error: e.response!.data,
              );
            }
          } catch (_) {
            return Resp(
              code: e.response!.statusCode,
              message: e.response!.statusMessage ?? 'Server error',
              error: e.response!.data,
            );
          }
        } else {
          return Resp(
            code: e.response!.statusCode,
            message: 'Unexpected error response format',
            error: e.response!.data.toString(),
          );
        }
      } else {
        return Resp(
          code: 500,
          message: e.message ?? 'Unknown network error',
          error: e.toString(),
        );
      }
    } catch (e) {
      debugPrint('Unexpected error (putApiWithHeaders): $e');
      return Resp(
        code: 500,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }
}
