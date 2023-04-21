import 'package:dio/dio.dart';

class NetworkService {
  static NetworkService? _instance;

  static NetworkService getInstance({BaseOptions? baseOptions}) {
    _instance ??= NetworkService._init(baseOptions);
    return _instance!;
  }

  late final Dio dio;
  late final BaseOptions _baseOptions;

  NetworkService._init(BaseOptions? baseOptions) {
    _baseOptions = baseOptions ?? BaseOptions();
    dio = Dio(_baseOptions);
  }
}
