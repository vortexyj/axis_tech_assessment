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
            _buildOfflineBanner(context),
            SizedBox(height: AppValues.padding_8),
            Expanded(child: _buildRatesList(context)),
          ],
        ),
      ),
    );
  }

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
            Text('Exchange Rates', style: TextStyles.displayValue),
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

  /// Only rebuilds on isOffline/cachedAt changes — independent of the
  /// header and rate list sections.
  Widget _buildOfflineBanner(BuildContext context) {
    return BlocBuilder<ExchangeCubit, ExchangeState>(
      buildWhen: (previous, current) =>
          previous.isOffline != current.isOffline ||
          previous.cachedAt != current.cachedAt,
      builder: (context, state) {
        if (!state.isOffline) return const SizedBox.shrink();
        return Padding(
          padding: EdgeInsets.only(top: AppValues.padding_8),
          child: OfflineBanner(cachedAt: state.cachedAt),
        );
      },
    );
  }

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
      children: List.generate(10, (index) {
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
      onRefresh: () => context.read<ExchangeCubit>().initState(),
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
      titleColor: AppColors.textColor,
      subTitle: code,
      subTitleColor: AppColors.hintGrey,
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
          Text('${item.rate.toStringAsFixed(3)} EGP', style: TextStyles.bold),
          SizedBox(height: 3.h),
          RateChangeText(
            absoluteChange: item.absoluteChange,
            percentChange: item.percentChange,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return ErrorWidgetView(
      icon: Icons.error_outline,
      title: "Couldn't load rates",
      subTitle: 'Check your internet connection and try again.',
      buttonTitle: 'Retry',
      onClickFunction: (_) => context.read<ExchangeCubit>().initState(),
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
      onClickFunction: (_) => context.read<ExchangeCubit>().initState(),
    );
  }
}

class _CurrencyBadge extends StatelessWidget {
  const _CurrencyBadge({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.w,
      height: 38.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Text(
        code.substring(0, 2),
        style: TextStyles.bold.copyWith(
          fontSize: 16.sp,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}
