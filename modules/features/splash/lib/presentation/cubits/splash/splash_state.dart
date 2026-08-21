part of 'splash_cubit.dart';

class SplashState extends BaseState {
  const SplashState({super.failure, super.pageState});

  @override
  SplashState copyWith({Failure? failure, PageState? pageState}) {
    return SplashState(pageState: pageState ?? super.pageState);
  }

  @override
  List<Object?> get props => [pageState, failure];
}
