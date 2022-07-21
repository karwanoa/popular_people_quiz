// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/global_variables.dart';
import '../models/popular_people.dart';

enum PopularPeopeleStatus {
  Uninitialized,
  Loaded,
  Loading,
  Unloaded,
  FromCache,
}

class PopularPeopeleRepo extends ChangeNotifier {
  PopularPeopeleStatus _popularPeopeleStatus =
      PopularPeopeleStatus.Uninitialized;
  PopularPeopeleStatus get popularPeopeleStatus => _popularPeopeleStatus;
  final List<PopularPeople> _popularPeople = [];
  List<PopularPeople> get popularPeople => _popularPeople;
  final Dio _dio;
  int pageIndex = 1;

  PopularPeopeleRepo()
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

  Future<void> getPopularPeople() async {
    _popularPeopeleStatus = PopularPeopeleStatus.Loading;
    await Future.delayed(Duration.zero);
    notifyListeners();
    try {
      Response response = await _dio.get(
        themoviedb + 'person/popular' + keyAPI + '&page=$pageIndex',
      );
      if (response.data != null) {
        if (response.data['page'] == 1) {
          await Hive.box<PopularPeople>('popular_people').clear();
        }

        debugPrint(response.data['results'][0].toString());
        response.data['results'].forEach((e) {
          _popularPeople.add(PopularPeople.fromMap(e));
          if (response.data['page'] == 1) {
            Hive.box<PopularPeople>('popular_people')
                .add(PopularPeople.fromMap(e));
          }
        });
        pageIndex++;
        _popularPeopeleStatus = PopularPeopeleStatus.Loaded;
      }
    } on DioError catch (e) {
      _popularPeopeleStatus = PopularPeopeleStatus.Unloaded;

      debugPrint("error :" + e.toString());
      // Box<PopularPeople> hive = Hive.box<PopularPeople>('popular_people');
      // _popularPeople.addAll(hive.values);
      // _popularPeopeleStatus = PopularPeopeleStatus.Loaded;
    }
    notifyListeners();
  }

  getPopularPeopleFromCache() async {
    _popularPeopeleStatus = PopularPeopeleStatus.Loading;
    await Future.delayed(Duration.zero);
    notifyListeners();
    Box<PopularPeople> hive = Hive.box<PopularPeople>('popular_people');
    _popularPeople.addAll(hive.values);
    _popularPeopeleStatus = PopularPeopeleStatus.FromCache;
    notifyListeners();
  }
}
