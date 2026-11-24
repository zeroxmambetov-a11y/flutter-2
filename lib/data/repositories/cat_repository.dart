import 'package:dio/dio.dart';
import '../models/cat_model.dart';

class CatRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.thecatapi.com'));

  Future<List<CatModel>> getCats() async {
    final response = await _dio.get('/v1/images/search');

    final List data = response.data;

    List<CatModel> cats = [];
    for (var json in data) {
      cats.add(CatModel.fromJson(json));
    }
    return cats;
  }
}
