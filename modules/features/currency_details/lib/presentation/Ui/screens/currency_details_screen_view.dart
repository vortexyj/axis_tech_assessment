import 'package:core/core.dart';
import 'package:currency_details/domain/entities/currency_history/currency_history_point.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import '../../cubits/currency_details/currency_details_cubit.dart';

class CurrencyDetailsScreenView
    extends BaseView<CurrencyDetailsCubit, CurrencyDetailsState> {
  static const String id = '/CurrencyDetailsScreenView';
  CurrencyDetailsScreenView({super.key, required this.currency});

  final CurrencyEnums currency;

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    final cubit = context.read<CurrencyDetailsCubit>();
    if (cubit.state.pageState == PageState.idle) {
      cubit.getCurrencyDetails(currency);
    }

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
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppValues.padding_8),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currency.displayName,
                style: TextStyles.bold.copyWith(fontSize: 16),
              ),
              Text(currency.name, style: TextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }

  /// Only rebuilds on isOffline/cachedAt changes.
  Widget _buildOfflineBanner(BuildContext context) {
    return BlocBuilder<CurrencyDetailsCubit, CurrencyDetailsState>(
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

  /// Loading / error / empty / loaded — only rebuilds on pageState changes.
  Widget _buildContent(BuildContext context) {
    return BlocBuilder<CurrencyDetailsCubit, CurrencyDetailsState>(
      buildWhen: (previous, current) => previous.pageState != current.pageState,
      builder: (context, state) {
        switch (state.pageState) {
          case PageState.loading:
            return _buildFullSkeleton();
          case PageState.failure:
            return _buildErrorState(context);
          case PageState.empty:
            return _buildEmptyState(context);
          case PageState.shimmerLoading:
          case PageState.success:
            return _buildLoadedContent(context);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFullSkeleton() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighlightColor,
            child: Container(
              width: 150.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          SizedBox(height: AppValues.padding_16),
          const RateHistoryChart(
            points: [],
            color: Colors.transparent,
            isLoading: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRateSection(context),
          SizedBox(height: AppValues.padding_24),
          _buildChartSection(context),
        ],
      ),
    );
  }

  /// Only rebuilds on rate/previousRate/lastUpdated changes — independent of
  /// the chart section below it.
  Widget _buildRateSection(BuildContext context) {
    return BlocBuilder<CurrencyDetailsCubit, CurrencyDetailsState>(
      buildWhen: (previous, current) =>
          previous.rate != current.rate ||
          previous.previousRate != current.previousRate ||
          previous.lastUpdated != current.lastUpdated,
      builder: (context, state) {
        final rate = state.rate;
        if (rate == null) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1 ${currency.name} equals', style: TextStyles.caption),
            SizedBox(height: 4.h),
            Text(
              '${rate.toStringAsFixed(3)} EGP',
              style: TextStyles.displayValue,
            ),
            SizedBox(height: 8.h),
            RateChangeText(
              absoluteChange: state.absoluteChange ?? 0,
              percentChange: state.percentChange ?? 0,
              style: TextStyles.bold.copyWith(fontSize: 14),
            ),
            SizedBox(height: 8.h),
            if (state.lastUpdated != null)
              Text(
                'Updated ${DateFormat('MMM d, yyyy').format(state.lastUpdated!)}',
                style: TextStyles.caption,
              ),
          ],
        );
      },
    );
  }

  /// Only rebuilds on pageState/history changes — shows the chart shimmer
  /// while [PageState.shimmerLoading] (rate ready, chart still loading).
  Widget _buildChartSection(BuildContext context) {
    return BlocBuilder<CurrencyDetailsCubit, CurrencyDetailsState>(
      buildWhen: (previous, current) =>
          previous.pageState != current.pageState ||
          previous.history != current.history,
      builder: (context, state) {
        final isChartLoading = state.pageState == PageState.shimmerLoading;
        final points =
            state.history?.map((p) => p.rate).toList() ?? const <num>[];
        final color = (state.absoluteChange ?? 0).directionColor;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LAST 7 DAYS', style: TextStyles.sectionLabel),
            SizedBox(height: 10.h),
            RateHistoryChart(
              points: points,
              color: color,
              isLoading: isChartLoading,
            ),
            if (!isChartLoading && (state.history?.isNotEmpty ?? false)) ...[
              SizedBox(height: 2.h),
              _buildDateRange(state.history!),
              SizedBox(height: 14.h),
              _buildLowHigh(state.history!),
            ],
          ],
        );
      },
    );
  }

  Widget _buildDateRange(List<CurrencyHistoryPoint> history) {
    final fmt = DateFormat('MMM d');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fmt.format(history.first.date),
          style: TextStyles.caption.copyWith(fontSize: 11),
        ),
        Text(
          fmt.format(history.last.date),
          style: TextStyles.caption.copyWith(fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildLowHigh(List<CurrencyHistoryPoint> history) {
    final rates = history.map((p) => p.rate).toList();
    final low = rates.reduce((a, b) => a < b ? a : b);
    final high = rates.reduce((a, b) => a > b ? a : b);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _lowHighTile('Low', low, alignEnd: false),
        _lowHighTile('High', high, alignEnd: true),
      ],
    );
  }

  Widget _lowHighTile(String label, num value, {required bool alignEnd}) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.caption.copyWith(fontSize: 11)),
        Text(
          value.toStringAsFixed(3),
          style: TextStyles.bold.copyWith(fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return ErrorWidgetView(
      icon: Icons.error_outline,
      title: 'Unable to load details',
      subTitle:
          "We couldn't load the exchange rate for ${currency.name}. Please try again.",
      buttonTitle: 'Retry',
      onClickFunction: (_) =>
          context.read<CurrencyDetailsCubit>().getCurrencyDetails(currency),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return ErrorWidgetView(
      icon: Icons.inbox_outlined,
      title: 'No data available',
      subTitle: "We couldn't find any exchange rate history right now.",
      buttonTitle: 'Refresh',
      buttonBackgroundColor: AppColors.lightMainColor,
      buttonTextColor: AppColors.textColor,
      onClickFunction: (_) =>
          context.read<CurrencyDetailsCubit>().getCurrencyDetails(currency),
    );
  }
}
