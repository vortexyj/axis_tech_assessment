import 'package:core/core.dart';
import 'package:core/packages/dartz/dartz.dart';
part 'exchange_state.dart';

class ExchangeCubit extends BaseCubit<ExchangeState> {
  ExchangeCubit() : super(const ExchangeState());
  @override
  Future<void> initState() async {}
}
