import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tastemate_app/core/services/api/api_endpoints.dart';
import 'package:tastemate_app/core/services/api/api_response.dart';
import 'package:tastemate_app/core/services/api/api_service.dart';
import 'package:tastemate_app/core/services/errors/api_exceptions.dart';
import 'package:tastemate_app/feature/home/models/post.dart';

part 'home_repository.g.dart';

@riverpod
class HomeRepo extends _$HomeRepo {
  @override
  AsyncValue<List<Post>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Post>>> fetchPosts() {
    final apiService = ref.read(apiServiceProvider);

    return AsyncValue.guard(() async {
      final response = await apiService.get(ApiEndpoints.post);
      print(response.statusCode);
      final posts =
          (response.data as List).map((e) => Post.fromJson(e)).toList();

      return posts;
    });
  }

  Future<AsyncValue<List<Post>>> fetchPostDetail(
      {required int userId, bool isMock = false}) {
    final apiService = ref.read(apiServiceProvider);

    return AsyncValue.guard(() async {
      if (isMock) {
        final response = json.decode(
          await rootBundle.loadString(
            'assets/jsons/post_response.json',
          ),
        );
        final apiRes = ApiResponse.fromJson(response);
        final res = Post.fromJson(apiRes.data);

        return [res];
      }

      final response =
          await apiService.get(ApiEndpoints(userId: userId).postDetail);
      final posts = Post.fromJson(response.data as Map<String, dynamic>);

      return [posts];
    });
  }

  Future<AsyncValue<List<Post>>> postWithError({bool isMock = true}) {
    final apiService = ref.read(apiServiceProvider);

    return AsyncValue.guard(() async {
      if (isMock) {
        final response = json.decode(
          await rootBundle.loadString(
            'assets/jsons/error_response.json',
          ),
        );
        final apiRes = ApiResponse.fromJson(response);

        if (apiRes.error != null) {
          throw ApiException(error: apiRes.error!);
        }
      }

      final response = await apiService.get(ApiEndpoints(userId: 1).postDetail);
      final posts = Post.fromJson(response.data as Map<String, dynamic>);

      return [posts];
    });
  }
}
