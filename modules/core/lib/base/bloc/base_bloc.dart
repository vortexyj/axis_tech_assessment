import 'package:core/core.dart';
import '../../packages/equatable/equatable.dart';
part 'base_state.dart';

class BaseCubit<T extends BaseState> extends Cubit<T> {
  BaseCubit(super.initialState);
  void emitIfNotClosed(T state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> initState() async {}

  void initFeatureConfig() {}
}
