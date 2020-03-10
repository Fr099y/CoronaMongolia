import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import 'MyRepository.dart';

final _repository = MyRepository();

final mainBloc = MainStatisticBloc();

final _globalDataFetcher = BehaviorSubject<dynamic>();
Stream<dynamic> get globalStatisticData => _globalDataFetcher.stream;

class MainStatisticBloc {
  Future<dynamic> getGlobalStatistics() async {
    dynamic _response = await _repository.getGlobalStatistics();
    _globalDataFetcher.sink.add(jsonDecode(_response));
    return _response;
  }
}
