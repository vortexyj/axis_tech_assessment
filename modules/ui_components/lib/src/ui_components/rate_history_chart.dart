import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

/// A 7-day rate line chart with a gradient fill under the line and a dot on
/// the latest point — or, when [isLoading] is true, a shimmer placeholder in
/// its place. The spec requires the loading state to be a shimmer, not a
/// spinner.
class RateHistoryChart extends StatelessWidget {
  const RateHistoryChart({
    super.key,
    required this.points,
    required this.color,
    this.height = 130,
    this.isLoading = false,
  });

  /// Rates oldest-to-newest.
  final List<num> points;
  final Color color;
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
    }

    if (points.isEmpty) return SizedBox(height: height);

    final spots = [
      for (var i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), points[i].toDouble()),
    ];
    final minY = points.reduce((a, b) => a < b ? a : b).toDouble();
    final maxY = points.reduce((a, b) => a > b ? a : b).toDouble();
    final pad = (maxY - minY) * 0.15;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          minY: minY - (pad == 0 ? 1 : pad),
          maxY: maxY + (pad == 0 ? 1 : pad),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: color,
              barWidth: 2.2,
              dotData: FlDotData(
                show: true,
                checkToShowDot: (spot, _) => spot.x == spots.last.x,
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(radius: 4, color: color, strokeWidth: 0),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withValues(alpha: 0.18),
                    color.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
