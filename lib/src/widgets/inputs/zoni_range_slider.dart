import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// A range slider component for selecting a range of values.
class ZoniRangeSlider extends StatefulWidget {
  /// Creates a [ZoniRangeSlider].
  const ZoniRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.labels,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.showLabels = true,
    this.showValues = true,
    this.prefix,
    this.suffix,
    this.onChangeStart,
    this.onChangeEnd,
  });

  /// The current range values.
  final RangeValues values;

  /// Called when the user changes the range.
  final ValueChanged<RangeValues> onChanged;

  /// The minimum value of the range.
  final double min;

  /// The maximum value of the range.
  final double max;

  /// The number of discrete divisions.
  final int? divisions;

  /// Labels for the range values.
  final RangeLabels? labels;

  /// Color of the active track.
  final Color? activeColor;

  /// Color of the inactive track.
  final Color? inactiveColor;

  /// Color of the thumb.
  final Color? thumbColor;

  /// Color of the thumb overlay.
  final Color? overlayColor;

  /// Whether to show value labels.
  final bool showLabels;

  /// Whether to show current values.
  final bool showValues;

  /// Prefix text for values.
  final String? prefix;

  /// Suffix text for values.
  final String? suffix;

  /// Called when the user starts changing the range.
  final ValueChanged<RangeValues>? onChangeStart;

  /// Called when the user stops changing the range.
  final ValueChanged<RangeValues>? onChangeEnd;

  @override
  State<ZoniRangeSlider> createState() => _ZoniRangeSliderState();
}

class _ZoniRangeSliderState extends State<ZoniRangeSlider> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showValues) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.prefix ?? ''}${widget.values.start.round()}${widget.suffix ?? ''}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: widget.activeColor ?? colorScheme.primary,
                ),
              ),
              Text(
                '${widget.prefix ?? ''}${widget.values.end.round()}${widget.suffix ?? ''}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: widget.activeColor ?? colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: ZoniSpacing.xs),
        ],
        
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: widget.activeColor ?? colorScheme.primary,
            inactiveTrackColor: widget.inactiveColor ?? 
                colorScheme.onSurface.withValues(alpha: 0.24),
            thumbColor: widget.thumbColor ?? colorScheme.primary,
            overlayColor: widget.overlayColor ?? 
                colorScheme.primary.withValues(alpha: 0.12),
            valueIndicatorColor: widget.activeColor ?? colorScheme.primary,
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorTextStyle: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
          ),
          child: RangeSlider(
            values: widget.values,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            labels: widget.showLabels ? widget.labels : null,
            onChanged: widget.onChanged,
            onChangeStart: widget.onChangeStart,
            onChangeEnd: widget.onChangeEnd,
          ),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.prefix ?? ''}${widget.min.round()}${widget.suffix ?? ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              '${widget.prefix ?? ''}${widget.max.round()}${widget.suffix ?? ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<RangeValues>('values', widget.values));
    properties.add(DoubleProperty('min', widget.min));
    properties.add(DoubleProperty('max', widget.max));
    properties.add(IntProperty('divisions', widget.divisions));
    properties.add(ColorProperty('activeColor', widget.activeColor));
    properties.add(ColorProperty('inactiveColor', widget.inactiveColor));
    properties.add(ColorProperty('thumbColor', widget.thumbColor));
    properties.add(FlagProperty('showLabels', value: widget.showLabels, ifTrue: 'showLabels'));
    properties.add(FlagProperty('showValues', value: widget.showValues, ifTrue: 'showValues'));
    properties.add(StringProperty('prefix', widget.prefix));
    properties.add(StringProperty('suffix', widget.suffix));
  }
}

/// A price range slider specifically for price selection.
class ZoniPriceRangeSlider extends StatefulWidget {
  /// Creates a [ZoniPriceRangeSlider].
  const ZoniPriceRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1000.0,
    this.currency = '\$',
    this.divisions = 100,
    this.onChangeStart,
    this.onChangeEnd,
  });

  /// The current price range values.
  final RangeValues values;

  /// Called when the user changes the price range.
  final ValueChanged<RangeValues> onChanged;

  /// The minimum price.
  final double min;

  /// The maximum price.
  final double max;

  /// Currency symbol.
  final String currency;

  /// The number of discrete divisions.
  final int? divisions;

  /// Called when the user starts changing the range.
  final ValueChanged<RangeValues>? onChangeStart;

  /// Called when the user stops changing the range.
  final ValueChanged<RangeValues>? onChangeEnd;

  @override
  State<ZoniPriceRangeSlider> createState() => _ZoniPriceRangeSliderState();
}

class _ZoniPriceRangeSliderState extends State<ZoniPriceRangeSlider> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: ZoniSpacing.sm),
        
        ZoniRangeSlider(
          values: widget.values,
          onChanged: widget.onChanged,
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          prefix: widget.currency,
          activeColor: ZoniColors.success,
          labels: RangeLabels(
            '${widget.currency}${widget.values.start.round()}',
            '${widget.currency}${widget.values.end.round()}',
          ),
          onChangeStart: widget.onChangeStart,
          onChangeEnd: widget.onChangeEnd,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<RangeValues>('values', widget.values));
    properties.add(DoubleProperty('min', widget.min));
    properties.add(DoubleProperty('max', widget.max));
    properties.add(StringProperty('currency', widget.currency));
    properties.add(IntProperty('divisions', widget.divisions));
  }
}

/// A date range slider for selecting date ranges.
class ZoniDateRangeSlider extends StatefulWidget {
  /// Creates a [ZoniDateRangeSlider].
  const ZoniDateRangeSlider({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onChanged,
    required this.minDate,
    required this.maxDate,
    this.divisions,
  });

  /// The current start date.
  final DateTime startDate;

  /// The current end date.
  final DateTime endDate;

  /// Called when the user changes the date range.
  final void Function(DateTime startDate, DateTime endDate) onChanged;

  /// The minimum selectable date.
  final DateTime minDate;

  /// The maximum selectable date.
  final DateTime maxDate;

  /// The number of discrete divisions.
  final int? divisions;

  @override
  State<ZoniDateRangeSlider> createState() => _ZoniDateRangeSliderState();
}

class _ZoniDateRangeSliderState extends State<ZoniDateRangeSlider> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _updateValues();
  }

  @override
  void didUpdateWidget(ZoniDateRangeSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.startDate != widget.startDate ||
        oldWidget.endDate != widget.endDate ||
        oldWidget.minDate != widget.minDate ||
        oldWidget.maxDate != widget.maxDate) {
      _updateValues();
    }
  }

  void _updateValues() {
    final totalDays = widget.maxDate.difference(widget.minDate).inDays.toDouble();
    final startDays = widget.startDate.difference(widget.minDate).inDays.toDouble();
    final endDays = widget.endDate.difference(widget.minDate).inDays.toDouble();
    
    _values = RangeValues(
      startDays / totalDays * 100,
      endDays / totalDays * 100,
    );
  }

  void _onChanged(RangeValues values) {
    final totalDays = widget.maxDate.difference(widget.minDate).inDays;
    final startDays = (values.start / 100 * totalDays).round();
    final endDays = (values.end / 100 * totalDays).round();
    
    final newStartDate = widget.minDate.add(Duration(days: startDays));
    final newEndDate = widget.minDate.add(Duration(days: endDays));
    
    widget.onChanged(newStartDate, newEndDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: ZoniSpacing.sm),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(widget.startDate),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: ZoniColors.primary,
              ),
            ),
            Text(
              _formatDate(widget.endDate),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: ZoniColors.primary,
              ),
            ),
          ],
        ),
        
        SizedBox(height: ZoniSpacing.xs),
        
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: ZoniColors.primary,
            inactiveTrackColor: ZoniColors.outline,
            thumbColor: ZoniColors.primary,
            overlayColor: ZoniColors.primary.withValues(alpha: 0.12),
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
          ),
          child: RangeSlider(
            values: _values,
            min: 0,
            max: 100,
            divisions: widget.divisions,
            onChanged: _onChanged,
          ),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(widget.minDate),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              _formatDate(widget.maxDate),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DateTime>('startDate', widget.startDate));
    properties.add(DiagnosticsProperty<DateTime>('endDate', widget.endDate));
    properties.add(DiagnosticsProperty<DateTime>('minDate', widget.minDate));
    properties.add(DiagnosticsProperty<DateTime>('maxDate', widget.maxDate));
    properties.add(IntProperty('divisions', widget.divisions));
  }
}
