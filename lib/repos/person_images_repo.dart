// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/image_model.dart';

import '../models/global_variables.dart';

enum PersonImagesStatus {
  Uninitialized,
  Loaded,
  Loading,
  Unloaded,
}

class PersonImagesRepo extends ChangeNotifier {
  PersonImagesStatus _personImagesStatus = PersonImagesStatus.Uninitialized;
  PersonImagesStatus get personImagesStatus => _personImagesStatus;
  final List<ImageModel> _images = [];
  List<ImageModel> get onePersonImages => _images;
  final Dio _dio;

  PersonImagesRepo()
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

  Future<void> getImages(int id) async {
    _images.clear();
    _personImagesStatus = PersonImagesStatus.Loading;
    await Future.delayed(Duration.zero);
    notifyListeners();
    try {
      Response response = await _dio.get(
        themoviedb + '/person/$id/images' + APIkey,
      );
      if (response.data != null) {
        response.data['profiles'].forEach(((e) {
          _images.add(ImageModel.fromMap(e));
        }));

        _personImagesStatus = PersonImagesStatus.Loaded;
      }
    } catch (e) {
      _personImagesStatus = PersonImagesStatus.Unloaded;
      debugPrint("error :" + e.toString());
    }
    notifyListeners();
  }
}
