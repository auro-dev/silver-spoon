import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/app_configs/environment.dart';
import 'package:platemate_user/data_models/rest_error.dart';
import 'package:platemate_user/utils/app_auth_helper.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:http_parser/http_parser.dart' as p;

///
/// Created by Sunil Kumar from Boiler plate
///
enum RequestMethod { get, create, patch, remove }

class ApiCall {
  static Future<Response<T>> _generalApiCall<T>(
      String path, RequestMethod requestMethod,
      {String id = '',
      String basePath = Environment.baseApiUrl,
      Map<String, dynamic> query = const {},
      dynamic body = const {},
      bool isAuthNeeded = true,
      Options? extraOptions}) async {
    Dio _dio = Dio();

    if (isAuthNeeded &&
        SharedPreferenceHelper.user != null &&
        SharedPreferenceHelper.user!.accessToken != null)
      _dio.options.headers['Authorization'] =
          SharedPreferenceHelper.user!.accessToken;
    try {
      log('URL $requestMethod $basePath/$path/$id $query ${jsonEncode(body)} ${SharedPreferenceHelper.user?.accessToken}');
      if (Platform.isIOS)
        print(
            'URL $requestMethod $basePath/$path/$id $query ${jsonEncode(body)} ${SharedPreferenceHelper.user?.accessToken}');

      Response<T> response;
      switch (requestMethod) {
        case RequestMethod.get:
          response =
              await _dio.get<T>('$basePath/$path/$id', queryParameters: query);
          break;
        case RequestMethod.create:
          response = await _dio.post<T>('$basePath/$path/$id',
              data: body, queryParameters: query, options: extraOptions);
          break;
        case RequestMethod.patch:
          response = await _dio.patch<T>('$basePath/$path/$id',
              data: body, queryParameters: query, options: extraOptions);
          break;
        case RequestMethod.remove:
          response = await _dio.delete<T>('$basePath/$path/$id',
              queryParameters: query, options: extraOptions);
          break;
        default:
          throw ArgumentError('Invalid RequestMethod $requestMethod');
      }
      return response;
    } on SocketException {
      log("...>>>>>>>>>> SocketException ERROR  ");
      throw NoInternetError();
    } catch (error, s) {
      log('ERROR URL $basePath/$path/$id ${_dio.options.headers['Authorization']} ${jsonEncode(body)}',
          error: '$error', stackTrace: s);
      log("...>>>>>>>>>>  $error ::::$s ");
      if ((error as dynamic).response == null) {
        throw NoInternetError();
      }
      if (error is DioError) {
        if (error.response?.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response!.data);
          if (restError.code == 401) {
            if (isAuthNeeded) AuthHelper.logoutUser();
          }
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  static Future<Response<T>> get<T>(String path,
      {String id = '',
      String basePath = Environment.baseApiUrl,
      Map<String, dynamic> query = const {},
      bool isAuthNeeded = true,
      Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.get,
        id: id, basePath: basePath, query: query, isAuthNeeded: isAuthNeeded);
  }

  static Future<Response<T>> post<T>(String path,
      {String id = '',
      String basePath = Environment.baseApiUrl,
      Map<String, dynamic> query = const {},
      dynamic body = const {},
      bool isAuthNeeded = true,
      Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.create,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        body: body,
        extraOptions: extraOptions);
  }

  static Future<Response<T>> patch<T>(
    String path, {
    String id = '',
    String basePath = Environment.baseApiUrl,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> body = const {},
    bool isAuthNeeded = true,
    Options? extraOptions,
  }) async {
    return _generalApiCall<T>(path, RequestMethod.patch,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        extraOptions: extraOptions,
        body: body);
  }

  static Future<Response<T>> delete<T>(String path,
      {String id = '',
      String basePath = Environment.baseApiUrl,
      Map<String, dynamic> query = const {},
      Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.remove,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: true,
        extraOptions: extraOptions);
  }

  /// Single file upload
  /// Single file upload
  static Future<String?> singleFileUpload(File file,
      {String path = ApiRoutes.upload,
      bool isPdf = false,
      String purpose = "profile"}) async {
    try {
      print("$path : $isPdf");
      final Dio dio = Dio();
      if (SharedPreferenceHelper.user != null) {
        dio.options.headers['Authorization'] =
            SharedPreferenceHelper.user!.accessToken;
      }

      Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
          data: FormData.fromMap({
            "photo": await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last,
                contentType: isPdf
                    ? p.MediaType('application', 'pdf')
                    : p.MediaType('image', 'jpeg')),
            "purpose": purpose,
          }));

      log("base api log : $response");

      return response.data[0]["filePath"];
    } on SocketException {
      throw NoInternetError();
    } catch (error) {
      if ((error as dynamic).response == null) {
        throw NoInternetError();
      }
      if (error is DioError) {
        if (error.response!.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response!.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  /// Multiple file upload
  static Future<List<String>?> multiFileUpload(List<File> files,
      {String path = ApiRoutes.upload, bool isPdf = false}) async {
    try {
      if (SharedPreferenceHelper.user == null ||
          SharedPreferenceHelper.user!.accessToken == null) {
        return null;
      } else {
        // log("-----------");
        final Dio dio = Dio();
        dio.options.headers['Authorization'] =
            SharedPreferenceHelper.user!.accessToken;

        Map<String, dynamic> body = {};

        for (int i = 0; i < files.length; i++) {
          body['photo$i'] = await MultipartFile.fromFile(files[i].path,
              contentType: isPdf
                  ? p.MediaType('application', 'pdf')
                  : p.MediaType('image', 'jpeg'));
        }
        // body['purpose'] = purpose;

        //log("====>>> UPLOAD BODY :: ${body}");

        Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
            data: FormData.fromMap(body));
        // log("====>>> UPLOAD RESPONSE---------$response");

        return response.data is List
            ? List<String>.generate(response.data.length,
                (index) => "${response.data[index]["link"]}")
            : ["${response.data["link"]}"];
      }
    } on SocketException {
      throw NoInternetError();
    } catch (error) {
      if (error is DioError) {
        if (error.response!.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          log("${error.response!.data}");
          final restError = RestError.fromJson(error.response!.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  /// Multiple file upload
  static Future<List<dynamic>?> multiFileUploadForGallery(List<File> files,
      {String path = ApiRoutes.upload}) async {
    try {
      if (SharedPreferenceHelper.user == null ||
          SharedPreferenceHelper.user!.accessToken == null) {
        return null;
      } else {
        // log("-----------");
        final Dio dio = Dio();
        dio.options.headers['Authorization'] =
            SharedPreferenceHelper.user!.accessToken;

        Map<String, dynamic> body = {};

        List multiFiles = [];

        for (int i = 0; i < files.length; i++) {
          final img = await MultipartFile.fromFile(files[i].path,
              contentType: p.MediaType('image', 'jpeg'));
          multiFiles.add(img);
        }
        body['feed'] = multiFiles;
        // body['purpose'] = purpose;

        //log("====>>> UPLOAD BODY :: ${body}");

        Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
            data: FormData.fromMap(body));
        // log("====>>> UPLOAD RESPONSE---------$response");

        return response.data;
      }
    } on SocketException {
      throw NoInternetError();
    } catch (error) {
      if (error is DioError) {
        if (error.response!.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          log("${error.response!.data}");
          final restError = RestError.fromJson(error.response!.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }
}
