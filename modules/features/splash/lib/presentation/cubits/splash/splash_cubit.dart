import 'package:core/core.dart';
part 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit() : super(const SplashState());
  @override
  Future<void> initState() async {
    await splashScreenDelay();
  }

  Future<void> splashScreenDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    emitIfNotClosed(state.copyWith(pageState: PageState.success));
  }
}
