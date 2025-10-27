import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for time picker variants.
enum ZoniTimePickerVariant {
  /// Standard time picker with default styling.
  standard,

  /// Outlined time picker with border.
  outlined,

  /// Filled time picker with background color.
  filled,
}

/// Enum for time picker size.
enum ZoniTimePickerSize {
  /// Small time picker.
  small,

  /// Medium time picker.
  medium,

  /// Large time picker.
  large,
}

/// Enum for time format.
enum ZoniTimeFormat {
  /// 12-hour format with AM/PM.
  twelveHour,

  /// 24-hour format.
  twentyFourHour,
}

/// A time selection component following Zoni design system.
///
/// The [ZoniTimePicker] widget provides a time picker with hour/minute
/// selection and AM/PM support.
///
/// Example usage:
/// ```dart
/// ZoniTimePicker(
///   label: 'Select Time',
///   onTimeSelected: (time) {
///     print('Selected time: $time');
///   },
/// )
/// ```
class ZoniTimePicker extends StatefulWidget {
  /// Creates a Zoni time picker.
  const ZoniTimePicker({
    super.key,
    this.initialTime,
    this.onTimeSelected,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = ZoniTimePickerVariant.outlined,
    this.size = ZoniTimePickerSize.medium,
    this.timeFormat = ZoniTimeFormat.twelveHour,
    this.enabled = true,
    this.readOnly = false,
    this.showClearButton = true,
    this.use24HourFormat,
    this.fieldWidth,
    this.fieldHeight,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.controller,
    this.focusNode,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.minuteInterval = 1,
    this.orientation,
    this.builder,
  });

  /// Initial time to display.
  final TimeOfDay? initialTime;

  /// Callback when a time is selected.
  final void Function(TimeOfDay time)? onTimeSelected;

  /// Label text for the field.
  final String? label;

  /// Hint text for the field.
  final String? hintText;

  /// Helper text style for the field.
  final TextStyle? helperStyle;

  /// Error text for the field.
  final String? errorText;

  /// Prefix icon for the field.
  final Widget? prefixIcon;

  /// Suffix icon for the field.
  final Widget? suffixIcon;

  /// Visual variant of the time picker.
  final ZoniTimePickerVariant variant;

  /// Size of the time picker.
  final ZoniTimePickerSize size;

  /// Time format for display.
  final ZoniTimeFormat timeFormat;

  /// Whether the time picker is enabled.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether to show the clear button.
  final bool showClearButton;

  /// Whether to use 24-hour format (overrides timeFormat).
  final bool? use24HourFormat;

  /// Width of the input field.
  final double? fieldWidth;

  /// Height of the input field.
  final double? fieldHeight;

  /// Border radius of the field.
  final BorderRadius? borderRadius;

  /// Background color of the field.
  final Color? backgroundColor;

  /// Border color of the field.
  final Color? borderColor;

  /// Focused border color of the field.
  final Color? focusedBorderColor;

  /// Error border color of the field.
  final Color? errorBorderColor;

  /// Text style for the field.
  final TextStyle? textStyle;

  /// Text style for the label.
  final TextStyle? labelStyle;

  /// Text style for the hint.
  final TextStyle? hintStyle;

  /// Helper text for the field.
  final String? helperText;

  /// Text style for the error text.
  final TextStyle? errorStyle;

  /// Text editing controller for the field.
  final TextEditingController? controller;

  /// Focus node for the field.
  final FocusNode? focusNode;

  /// Validator function for the field.
  final String? Function(String?)? validator;

  /// Callback when the field is tapped.
  final VoidCallback? onTap;

  /// Callback when the field value changes.
  final void Function(String)? onChanged;

  /// Callback when the field is submitted.
  final void Function(String)? onFieldSubmitted;

  /// Minute interval for time selection.
  final int minuteInterval;

  /// Orientation of the time picker dialog.
  final Orientation? orientation;

  /// Builder for customizing the time picker dialog.
  final Widget Function(BuildContext, Widget?)? builder;

  @override
  State<ZoniTimePicker> createState() => _ZoniTimePickerState();
}

class _ZoniTimePickerState extends State<ZoniTimePicker> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _selectedTime = widget.initialTime;
    _updateFieldText();
  }

  @override
  void didUpdateWidget(ZoniTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTime != oldWidget.initialTime) {
      _selectedTime = widget.initialTime;
      _updateFieldText();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  bool get _use24HourFormat {
    return widget.use24HourFormat ??
        (widget.timeFormat == ZoniTimeFormat.twentyFourHour);
  }

  double get _fieldHeight {
    if (widget.fieldHeight != null) return widget.fieldHeight!;
    switch (widget.size) {
      case ZoniTimePickerSize.small:
        return 40.0;
      case ZoniTimePickerSize.medium:
        return 48.0;
      case ZoniTimePickerSize.large:
        return 56.0;
    }
  }

  EdgeInsets get _contentPadding {
    switch (widget.size) {
      case ZoniTimePickerSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniTimePickerSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniTimePickerSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
    }
  }

  BorderRadius get _borderRadius {
    return widget.borderRadius ??
        const BorderRadius.all(Radius.circular(ZoniBorderRadius.sm));
  }

  InputBorder get _border {
    final Color borderColor = widget.borderColor ?? ZoniColors.outline;
    switch (widget.variant) {
      case ZoniTimePickerVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniTimePickerVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniTimePickerVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: _borderRadius,
        );
    }
  }

  InputBorder get _focusedBorder {
    final Color borderColor = widget.focusedBorderColor ?? ZoniColors.primary;
    switch (widget.variant) {
      case ZoniTimePickerVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
      case ZoniTimePickerVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
      case ZoniTimePickerVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
    }
  }

  InputBorder get _errorBorder {
    final Color borderColor = widget.errorBorderColor ?? ZoniColors.error;
    switch (widget.variant) {
      case ZoniTimePickerVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniTimePickerVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniTimePickerVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
    }
  }

  Color? get _fillColor {
    if (widget.backgroundColor != null) return widget.backgroundColor;
    return widget.variant == ZoniTimePickerVariant.filled
        ? ZoniColors.surfaceVariant
        : null;
  }

  void _updateFieldText() {
    if (_selectedTime != null) {
      _controller.text = _formatTime(_selectedTime!);
    } else {
      _controller.text = '';
    }
  }

  String _formatTime(TimeOfDay time) {
    if (_use24HourFormat) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      final int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final String period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
    }
  }

  Future<void> _showTimePicker() async {
    if (!widget.enabled) return;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: widget.builder ??
          (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: _use24HourFormat,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: ZoniColors.primary,
                        onPrimary: ZoniColors.onPrimary,
                        surface: ZoniColors.surface,
                        onSurface: ZoniColors.onSurface,
                        secondary: ZoniColors.secondary,
                        onSecondary: ZoniColors.onSecondary,
                      ),
                  timePickerTheme: TimePickerThemeData(
                    backgroundColor: ZoniColors.surface,
                    hourMinuteTextColor: ZoniColors.onSurface,
                    hourMinuteColor: ZoniColors.surfaceVariant,
                    dayPeriodTextColor: ZoniColors.onSurface,
                    dayPeriodColor: ZoniColors.surfaceVariant,
                    dialHandColor: ZoniColors.primary,
                    dialBackgroundColor: ZoniColors.surfaceVariant,
                    dialTextColor: ZoniColors.onSurface,
                    entryModeIconColor: ZoniColors.onSurfaceVariant,
                    helpTextStyle: ZoniTextStyles.labelMedium.copyWith(
                      color: ZoniColors.onSurfaceVariant,
                    ),
                    hourMinuteTextStyle: ZoniTextStyles.headlineLarge.copyWith(
                      color: ZoniColors.onSurface,
                    ),
                    dayPeriodTextStyle: ZoniTextStyles.titleMedium.copyWith(
                      color: ZoniColors.onSurface,
                    ),
                  ),
                ),
                child: child!,
              ),
            );
          },
      orientation: widget.orientation,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (picked != null && picked != _selectedTime) {
      // Apply minute interval if specified
      TimeOfDay adjustedTime = picked;
      if (widget.minuteInterval > 1) {
        final int adjustedMinute =
            (picked.minute / widget.minuteInterval).round() *
                widget.minuteInterval;
        adjustedTime = picked.replacing(minute: adjustedMinute % 60);
      }

      setState(() {
        _selectedTime = adjustedTime;
        _updateFieldText();
      });
      widget.onTimeSelected?.call(adjustedTime);
    }
  }

  void _clearSelection() {
    setState(() {
      _selectedTime = null;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.fieldWidth,
      height: _fieldHeight,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        readOnly: true,
        validator: widget.validator,
        onTap: () {
          widget.onTap?.call();
          _showTimePicker();
        },
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: widget.textStyle ??
            ZoniTextStyles.bodyMedium.copyWith(
              color: widget.enabled
                  ? ZoniColors.onSurface
                  : ZoniColors.onSurface.withValues(alpha: 0.6),
            ),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText ?? 'Select time',
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon ??
              Icon(
                Icons.access_time,
                color: widget.enabled
                    ? ZoniColors.onSurfaceVariant
                    : ZoniColors.onSurface.withValues(alpha: 0.4),
              ),
          suffixIcon: widget.showClearButton && _selectedTime != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: widget.enabled ? _clearSelection : null,
                  color: ZoniColors.onSurfaceVariant,
                )
              : widget.suffixIcon,
          filled: widget.variant == ZoniTimePickerVariant.filled,
          fillColor: _fillColor,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _focusedBorder,
          errorBorder: _errorBorder,
          focusedErrorBorder: _errorBorder,
          contentPadding: _contentPadding,
          labelStyle: widget.labelStyle,
          hintStyle: widget.hintStyle,
          helperStyle: widget.helperStyle,
          errorStyle: widget.errorStyle,
        ),
      ),
    );
  }
}
