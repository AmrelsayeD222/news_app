import 'package:dio/dio.dart';

import '../../core/utils/constants.dart';
import '../model/news_model.dart';

class NewsService {
  static final Dio _dio = Dio();

  Future<Newsmodel> getNews({
    String category = 'general',
  }) async {
    Response<dynamic> response = await _dio.get(
      '$baseUrl$endpoint',
      queryParameters: {
        'category': category,
        'apiKey': apiKey,
      },
    );
    return Newsmodel.fromJson(response.data);
  }
}
