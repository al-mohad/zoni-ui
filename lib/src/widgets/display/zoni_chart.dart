import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Chart types supported by ZoniChart.
enum ZoniChartType {
  /// Line chart for showing trends over time.
  line,
  /// Bar chart for comparing values.
  bar,
  /// Pie chart for showing proportions.
  pie,
  /// Area chart for showing cumulative data.
  area,
  /// Donut chart for showing proportions with center space.
  donut,
}

/// Data point for charts.
class ZoniChartDataPoint {
  /// Creates a chart data point.
  const ZoniChartDataPoint({
    required this.x,
    required this.y,
    this.label,
    this.color,
  });

  /// X-axis value.
  final double x;

  /// Y-axis value.
  final double y;

  /// Optional label for the data point.
  final String? label;

  /// Optional color for the data point.
  final Color? color;
}

/// Data series for charts.
class ZoniChartSeries {
  /// Creates a chart data series.
  const ZoniChartSeries({
    required this.name,
    required this.data,
    this.color,
    this.strokeWidth = 2.0,
    this.fillOpacity = 0.3,
  });

  /// Name of the series.
  final String name;

  /// Data points in the series.
  final List<ZoniChartDataPoint> data;

  /// Color of the series.
  final Color? color;

  /// Stroke width for line charts.
  final double strokeWidth;

  /// Fill opacity for area charts.
  final double fillOpacity;
}

/// Simple chart component for data visualization.
class ZoniChart extends StatelessWidget {
  /// Creates a chart.
  const ZoniChart({
    super.key,
    required this.type,
    required this.series,
    this.title,
    this.subtitle,
    this.width,
    this.height = 300.0,
    this.showLegend = true,
    this.showGrid = true,
    this.showAxes = true,
    this.backgroundColor,
    this.gridColor,
    this.axisColor,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.elevation = 2.0,
  });

  /// Type of chart to display.
  final ZoniChartType type;

  /// Data series to display.
  final List<ZoniChartSeries> series;

  /// Optional title for the chart.
  final String? title;

  /// Optional subtitle for the chart.
  final String? subtitle;

  /// Width of the chart.
  final double? width;

  /// Height of the chart.
  final double height;

  /// Whether to show legend.
  final bool showLegend;

  /// Whether to show grid lines.
  final bool showGrid;

  /// Whether to show axes.
  final bool showAxes;

  /// Background color of the chart.
  final Color? backgroundColor;

  /// Color of grid lines.
  final Color? gridColor;

  /// Color of axes.
  final Color? axisColor;

  /// Padding around the chart.
  final EdgeInsets padding;

  /// Border radius of the chart container.
  final double borderRadius;

  /// Elevation of the chart container.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      color: backgroundColor ?? theme.cardColor,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null || subtitle != null) _buildHeader(theme),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _buildChart(theme)),
                  if (showLegend) _buildLegend(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                subtitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChart(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: gridColor ?? theme.dividerColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: CustomPaint(
        painter: _ChartPainter(
          type: type,
          series: series,
          showGrid: showGrid,
          showAxes: showAxes,
          gridColor: gridColor ?? theme.dividerColor,
          axisColor: axisColor ?? theme.textTheme.bodyMedium?.color,
          theme: theme,
        ),
        child: Container(),
      ),
    );
  }

  Widget _buildLegend(ThemeData theme) {
    return Container(
      width: 120.0,
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Legend',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          ...series.asMap().entries.map((entry) {
            final index = entry.key;
            final seriesData = entry.value;
            final color = seriesData.color ?? _getDefaultColor(index);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      seriesData.name,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getDefaultColor(int index) {
    final colors = [
      ZoniColors.primary,
      ZoniColors.success,
      ZoniColors.warning,
      ZoniColors.error,
      ZoniColors.info,
      ZoniColors.neutralGray,
    ];
    return colors[index % colors.length];
  }
}

/// Custom painter for drawing charts.
class _ChartPainter extends CustomPainter {
  _ChartPainter({
    required this.type,
    required this.series,
    required this.showGrid,
    required this.showAxes,
    required this.gridColor,
    required this.axisColor,
    required this.theme,
  });

  final ZoniChartType type;
  final List<ZoniChartSeries> series;
  final bool showGrid;
  final bool showAxes;
  final Color gridColor;
  final Color? axisColor;
  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) return;

    final paint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, size, paint);
    }

    // Draw axes
    if (showAxes) {
      _drawAxes(canvas, size, paint);
    }

    // Draw chart based on type
    switch (type) {
      case ZoniChartType.line:
        _drawLineChart(canvas, size, paint);
        break;
      case ZoniChartType.bar:
        _drawBarChart(canvas, size, paint);
        break;
      case ZoniChartType.pie:
        _drawPieChart(canvas, size, paint);
        break;
      case ZoniChartType.area:
        _drawAreaChart(canvas, size, paint);
        break;
      case ZoniChartType.donut:
        _drawDonutChart(canvas, size, paint);
        break;
    }
  }

  void _drawGrid(Canvas canvas, Size size, Paint paint) {
    paint.color = gridColor.withValues(alpha: 0.3);
    paint.strokeWidth = 1.0;

    // Vertical grid lines
    for (int i = 1; i < 5; i++) {
      final x = (size.width / 5) * i;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal grid lines
    for (int i = 1; i < 5; i++) {
      final y = (size.height / 5) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  void _drawAxes(Canvas canvas, Size size, Paint paint) {
    paint.color = axisColor ?? Colors.black;
    paint.strokeWidth = 2.0;

    // X-axis
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      paint,
    );

    // Y-axis
    canvas.drawLine(
      const Offset(0, 0),
      Offset(0, size.height),
      paint,
    );
  }

  void _drawLineChart(Canvas canvas, Size size, Paint paint) {
    for (int seriesIndex = 0; seriesIndex < series.length; seriesIndex++) {
      final seriesData = series[seriesIndex];
      final color = seriesData.color ?? _getDefaultColor(seriesIndex);
      
      paint.color = color;
      paint.strokeWidth = seriesData.strokeWidth;

      final path = Path();
      bool isFirst = true;

      for (final point in seriesData.data) {
        final x = (point.x / _getMaxX()) * size.width;
        final y = size.height - (point.y / _getMaxY()) * size.height;

        if (isFirst) {
          path.moveTo(x, y);
          isFirst = false;
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  void _drawBarChart(Canvas canvas, Size size, Paint paint) {
    final barWidth = size.width / (series.first.data.length * series.length + series.length + 1);
    
    for (int seriesIndex = 0; seriesIndex < series.length; seriesIndex++) {
      final seriesData = series[seriesIndex];
      final color = seriesData.color ?? _getDefaultColor(seriesIndex);
      
      paint.color = color;
      paint.style = PaintingStyle.fill;

      for (int i = 0; i < seriesData.data.length; i++) {
        final point = seriesData.data[i];
        final x = (i * series.length + seriesIndex + 1) * barWidth;
        final barHeight = (point.y / _getMaxY()) * size.height;
        final y = size.height - barHeight;

        canvas.drawRect(
          Rect.fromLTWH(x, y, barWidth * 0.8, barHeight),
          paint,
        );
      }
    }
  }

  void _drawPieChart(Canvas canvas, Size size, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width < size.height ? size.width : size.height) / 2 * 0.8;
    
    final total = series.first.data.fold<double>(0, (sum, point) => sum + point.y);
    double startAngle = -90 * (3.14159 / 180); // Start from top

    for (int i = 0; i < series.first.data.length; i++) {
      final point = series.first.data[i];
      final sweepAngle = (point.y / total) * 2 * 3.14159;
      final color = point.color ?? _getDefaultColor(i);

      paint.color = color;
      paint.style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  void _drawAreaChart(Canvas canvas, Size size, Paint paint) {
    for (int seriesIndex = 0; seriesIndex < series.length; seriesIndex++) {
      final seriesData = series[seriesIndex];
      final color = seriesData.color ?? _getDefaultColor(seriesIndex);
      
      final path = Path();
      path.moveTo(0, size.height);

      for (final point in seriesData.data) {
        final x = (point.x / _getMaxX()) * size.width;
        final y = size.height - (point.y / _getMaxY()) * size.height;
        path.lineTo(x, y);
      }

      path.lineTo(size.width, size.height);
      path.close();

      paint.color = color.withValues(alpha: seriesData.fillOpacity);
      paint.style = PaintingStyle.fill;
      canvas.drawPath(path, paint);

      // Draw line on top
      paint.color = color;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = seriesData.strokeWidth;
      
      final linePath = Path();
      bool isFirst = true;
      for (final point in seriesData.data) {
        final x = (point.x / _getMaxX()) * size.width;
        final y = size.height - (point.y / _getMaxY()) * size.height;

        if (isFirst) {
          linePath.moveTo(x, y);
          isFirst = false;
        } else {
          linePath.lineTo(x, y);
        }
      }
      canvas.drawPath(linePath, paint);
    }
  }

  void _drawDonutChart(Canvas canvas, Size size, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = (size.width < size.height ? size.width : size.height) / 2 * 0.8;
    final innerRadius = outerRadius * 0.6;
    
    final total = series.first.data.fold<double>(0, (sum, point) => sum + point.y);
    double startAngle = -90 * (3.14159 / 180);

    for (int i = 0; i < series.first.data.length; i++) {
      final point = series.first.data[i];
      final sweepAngle = (point.y / total) * 2 * 3.14159;
      final color = point.color ?? _getDefaultColor(i);

      paint.color = color;
      paint.style = PaintingStyle.fill;

      final path = Path();
      path.addArc(
        Rect.fromCircle(center: center, radius: outerRadius),
        startAngle,
        sweepAngle,
      );
      path.addArc(
        Rect.fromCircle(center: center, radius: innerRadius),
        startAngle + sweepAngle,
        -sweepAngle,
      );
      path.close();

      canvas.drawPath(path, paint);
      startAngle += sweepAngle;
    }
  }

  double _getMaxX() {
    double max = 0;
    for (final seriesData in series) {
      for (final point in seriesData.data) {
        if (point.x > max) max = point.x;
      }
    }
    return max == 0 ? 1 : max;
  }

  double _getMaxY() {
    double max = 0;
    for (final seriesData in series) {
      for (final point in seriesData.data) {
        if (point.y > max) max = point.y;
      }
    }
    return max == 0 ? 1 : max;
  }

  Color _getDefaultColor(int index) {
    final colors = [
      ZoniColors.primary,
      ZoniColors.success,
      ZoniColors.warning,
      ZoniColors.error,
      ZoniColors.info,
      ZoniColors.neutralGray,
    ];
    return colors[index % colors.length];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
