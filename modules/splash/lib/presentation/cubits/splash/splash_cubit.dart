import 'package:core/core.dart';
import 'package:core/packages/dartz/dartz.dart';
part 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit() : super(const SplashState());
  @override
  Future<void> initState() async {}
}
