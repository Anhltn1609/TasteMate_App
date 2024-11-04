import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastemate_app/feature/home/controller/home_controller.dart';
import 'package:tastemate_app/feature/home/models/post.dart';

mixin HomeMixin {
  HomeController _homeCtrl(WidgetRef ref) =>
      ref.read(homeControllerProvider.notifier);

  // Watch State at home page
  int counterState(WidgetRef ref) =>
      ref.watch(homeControllerProvider.select((state) => state.number));

  AsyncValue<List<Post>> postsAsyncValueState(WidgetRef ref) =>
      ref.watch(homeControllerProvider.select((state) => state.postList));

  // Event at home page
  void refresh(WidgetRef ref) => ref.refresh(homeControllerProvider);
  void increment(WidgetRef ref) => _homeCtrl(ref).increment();
  void decrement(WidgetRef ref) => _homeCtrl(ref).decrement();
  void fetchPost(WidgetRef ref) => _homeCtrl(ref).fetchPost();
}
