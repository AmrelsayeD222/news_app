import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../core/utils/constants.dart';
import '../model/news_model.dart';

class NewsService {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'application/json',
        'Accept-Language': 'en-US,en;q=0.9',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    ),
  );

  Future<Newsmodel> getNews({
    String category = 'general',
  }) async {
    try {
      Response<dynamic> response = await _dio.get(
        '$baseUrl$endpoint',
        queryParameters: {
          'category': category,
          'apiKey': apiKey,
        },
      );
      return Newsmodel.fromJson(response.data);
    } on DioException catch (e) {
      log('DioException: ${e.type} - ${e.message}');
      if (e.error is SocketException) {
        log('SocketException: ${(e.error as SocketException).osError?.errorCode}');
      }
      rethrow;
    } catch (e) {
      log('Unexpected error: $e');
      rethrow;
    }
  }
}
