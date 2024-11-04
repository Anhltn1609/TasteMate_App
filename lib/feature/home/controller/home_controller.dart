import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tastemate_app/feature/home/controller/home_state.dart';
import 'package:tastemate_app/feature/home/data/home_repository.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    fetchPost();

    return HomeState();
  }

  Future<void> fetchPost() async {
    final asyncPosts = await ref.read(homeRepoProvider.notifier).fetchPosts();

    state = state.copyWith(postList: asyncPosts);
  }

  FutureOr<void> fetchDetail({required int userId}) async {
    final asyncPosts = await ref
        .read(homeRepoProvider.notifier)
        .fetchPostDetail(userId: userId);

    state = state.copyWith(postList: asyncPosts);
  }

  void increment() => state = state.copyWith(number: state.number + 1);
  void decrement() => state = state.copyWith(number: state.number - 1);
}
