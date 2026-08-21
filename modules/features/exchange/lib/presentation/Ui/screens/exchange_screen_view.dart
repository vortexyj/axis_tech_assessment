import 'package:core/core.dart';
import 'package:exchange/domain/entities/exchange_rate/exchange_rate_item.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';

import '../../cubits/exchange/exchange_cubit.dart';

class ExchangeScreenView extends BaseView<ExchangeCubit, ExchangeState> {
  static const String id = '/ExchangeScreenView';
  ExchangeScreenView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: AppValues.padding_24,
          end: AppValues.padding_24,
          top: AppValues.paddingTop_16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: AppValues.padding_8),
            Expanded(child: _buildRatesList(context)),
          ],
        ),
      ),
    );
  }

  /// Title + "Base EGP · Updated ..." subtitle. Only rebuilds on pageState
  /// or lastUpdated changes — the rate list rebuilding doesn't touch this.
  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<ExchangeCubit, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.pageState != current.pageState ||
          previous.lastUpdated != current.lastUpdated,
      builder: (context, state) {
        final isLoading = state.pageState == PageState.loading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Exchange Rates', style: TextStyles.headline),
            SizedBox(height: 5.h),
            if (isLoading)
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  width: 150.w,
                  height: 11.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            else
              Text(_subtitle(state), style: TextStyles.caption),
          ],
        );
      },
    );
  }

  String _subtitle(ExchangeState state) {
    final updated = state.lastUpdated;
    if (updated == null) return 'Base EGP';
    final formatted = DateFormat('MMM d, yyyy · h:mm a').format(updated);
    return 'Base EGP · Updated $formatted';
  }

  /// Loading / error / empty / loaded — only rebuilds on pageState or rates
  /// changes, independent of the header section above.
  Widget _buildRatesList(BuildContext context) {
    return BlocBuilder<ExchangeCubit, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.pageState != current.pageState ||
          previous.rates != current.rates,
      builder: (context, state) {
        switch (state.pageState) {
          case PageState.loading:
            return _buildSkeletonList();
          case PageState.failure:
            return _buildErrorState(context);
          case PageState.empty:
            return _buildEmptyState(context);
          case PageState.success:
            return _buildLoadedList(context, state.rates ?? const []);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildSkeletonList() {
    return Column(
      children: List.generate(5, (index) {
        return AppCard(
          title: null,
          isLoading: true,
          hasStartWidget: true,
          hasEndWidget: true,
          hasShadow: false,
          hasBorder: false,
          bottomBorder: index != 4,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.symmetric(
            vertical: AppValues.padding_13,
            horizontal: AppPadding.p6,
          ),
        );
      }),
    );
  }

  Widget _buildLoadedList(BuildContext context, List<ExchangeRateItem> rates) {
    return RefreshIndicator(
      onRefresh: () => context.read<ExchangeCubit>().getExchangeRates(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: rates.length,
        itemBuilder: (context, index) {
          return _buildRateRow(rates[index], isLast: index == rates.length - 1);
        },
      ),
    );
  }

  Widget _buildRateRow(ExchangeRateItem item, {required bool isLast}) {
    final code = item.currency.name;
    return AppCard(
      title: item.currency.displayName,
      subTitle: code,
      hasStartWidget: true,
      hasEndWidget: true,
      hasShadow: false,
      hasBorder: false,
      bottomBorder: !isLast,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(
        vertical: AppValues.padding_13,
        horizontal: AppPadding.p6,
      ),
      startWidget: _CurrencyBadge(code: code),
      endWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${item.rate.toStringAsFixed(3)} EGP', style: TextStyles.rowValue),
          SizedBox(height: 3.h),
          RateChangeText(change: item.absoluteChange, label: _changeLabel(item)),
        ],
      ),
    );
  }

  String _changeLabel(ExchangeRateItem item) {
    final sign = item.absoluteChange > 0
        ? '+'
        : item.absoluteChange < 0
            ? '-'
            : '~';
    final abs = item.absoluteChange.abs().toStringAsFixed(3);
    final pct = item.percentChange.abs().toStringAsFixed(2);
    return '$sign$abs · $sign$pct%';
  }

  Widget _buildErrorState(BuildContext context) {
    return ErrorWidgetView(
      icon: Icons.error_outline,
      title: "Couldn't load rates",
      subTitle: 'Check your internet connection and try again.',
      buttonTitle: 'Retry',
      onClickFunction: (_) => context.read<ExchangeCubit>().getExchangeRates(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return ErrorWidgetView(
      icon: Icons.inbox_outlined,
      title: 'No rates available',
      subTitle: "We couldn't find any exchange rate data right now.",
      buttonTitle: 'Refresh',
      buttonBackgroundColor: AppColors.lightMainColor,
      buttonTextColor: AppColors.textColor,
      onClickFunction: (_) => context.read<ExchangeCubit>().getExchangeRates(),
    );
  }
}

class _CurrencyBadge extends StatelessWidget {
  const _CurrencyBadge({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        code.substring(0, 2),
        style: TextStyles.bold.copyWith(fontSize: 12, color: AppColors.textColor),
      ),
    );
  }
}
