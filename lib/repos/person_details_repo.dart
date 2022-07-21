// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/global_variables.dart';
import '../models/one_person.dart';

enum PersonDetailsStatus {
  Uninitialized,
  Loaded,
  Loading,
  Unloaded,
}

class PersonDetailsRepo extends ChangeNotifier {
  PersonDetailsStatus _personDetailsStatus = PersonDetailsStatus.Uninitialized;
  PersonDetailsStatus get personDetailsStatus => _personDetailsStatus;
  OnePersonDetails? _onePersonDetails;
  OnePersonDetails? get onePersonDetails => _onePersonDetails;
  final Dio _dio;

  PersonDetailsRepo()
      : _dio = Dio()
          ..interceptors.add(
            InterceptorsWrapper(onRequest: (options, handler) async {
              options.responseType = ResponseType.json;
              options.contentType = Headers.jsonContentType;
              return handler.next(options);
            }, onResponse: (Response response, handler) async {
              return handler.next(response);
            }, onError: (DioError e, handler) {
              return handler.next(e);
            }),
          );

  Future<void> getDetails(int id) async {
    _personDetailsStatus = PersonDetailsStatus.Loading;
    await Future.delayed(Duration.zero);
    notifyListeners();
    try {
      Response response = await _dio.get(
        themoviedb + '/person/$id' + keyAPI,
      );
      if (response.data != null) {
        _onePersonDetails = OnePersonDetails.fromMap(response.data);

        _personDetailsStatus = PersonDetailsStatus.Loaded;
      }
    } catch (e) {
      _personDetailsStatus = PersonDetailsStatus.Unloaded;
      debugPrint("error :" + e.toString());
    }
    notifyListeners();
  }
}
