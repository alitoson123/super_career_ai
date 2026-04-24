import 'package:dio/dio.dart';

class DioService {
  final Dio dio;

  DioService({required this.dio});

  Future<List<dynamic>> getMethod({required String url}) async {
    final response = await dio.get(url);
    return response.data;
  }




  Future<List<dynamic>> postMethod({required String url,required Map<String, dynamic> data}) async {
    final response = await dio.post(url,data: data);
    return response.data;
  }
}
