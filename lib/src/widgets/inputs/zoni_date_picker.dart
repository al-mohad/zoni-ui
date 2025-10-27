import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for date picker variants.
enum ZoniDatePickerVariant {
  /// Standard date picker with default styling.
  standard,

  /// Outlined date picker with border.
  outlined,

  /// Filled date picker with background color.
  filled,
}

/// Enum for date picker size.
enum ZoniDatePickerSize {
  /// Small date picker.
  small,

  /// Medium date picker.
  medium,

  /// Large date picker.
  large,
}

/// Enum for date picker mode.
enum ZoniDatePickerMode {
  /// Date only selection.
  date,

  /// Date and time selection.
  dateTime,

  /// Date range selection.
  dateRange,
}

/// A date selection component following Zoni design system.
///
/// The [ZoniDatePicker] widget provides a date picker with calendar view
/// and input field integration.
///
/// Example usage:
/// ```dart
/// ZoniDatePicker(
///   label: 'Select Date',
///   onDateSelected: (date) {
///     print('Selected date: $date');
///   },
/// )
/// ```
class ZoniDatePicker extends StatefulWidget {
  /// Creates a Zoni date picker.
  const ZoniDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.onDateRangeSelected,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = ZoniDatePickerVariant.outlined,
    this.size = ZoniDatePickerSize.medium,
    this.mode = ZoniDatePickerMode.date,
    this.enabled = true,
    this.readOnly = false,
    this.showClearButton = true,
    this.dateFormat,
    this.locale,
    this.selectableDayPredicate,
    this.initialDatePickerMode = DatePickerMode.day,
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
  });

  /// Initial date to display.
  final DateTime? initialDate;

  /// Earliest selectable date.
  final DateTime? firstDate;

  /// Latest selectable date.
  final DateTime? lastDate;

  /// Callback when a date is selected.
  final void Function(DateTime date)? onDateSelected;

  /// Callback when a date range is selected.
  final void Function(DateTimeRange range)? onDateRangeSelected;

  /// Label text for the field.
  final String? label;

  /// Hint text for the field.
  final String? hintText;

  /// Helper text for the field.
  final String? helperText;

  /// Error text for the field.
  final String? errorText;

  /// Prefix icon for the field.
  final Widget? prefixIcon;

  /// Suffix icon for the field.
  final Widget? suffixIcon;

  /// Visual variant of the date picker.
  final ZoniDatePickerVariant variant;

  /// Size of the date picker.
  final ZoniDatePickerSize size;

  /// Mode of the date picker.
  final ZoniDatePickerMode mode;

  /// Whether the date picker is enabled.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether to show the clear button.
  final bool showClearButton;

  /// Date format for display.
  final String? dateFormat;

  /// Locale for the date picker.
  final Locale? locale;

  /// Predicate to determine selectable days.
  final bool Function(DateTime)? selectableDayPredicate;

  /// Initial mode for the date picker.
  final DatePickerMode initialDatePickerMode;

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

  /// Text style for the helper text.
  final TextStyle? helperStyle;

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

  @override
  State<ZoniDatePicker> createState() => _ZoniDatePickerState();
}

class _ZoniDatePickerState extends State<ZoniDatePicker> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  DateTime? _selectedDate;
  DateTimeRange? _selectedRange;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _selectedDate = widget.initialDate;
    _updateFieldText();
  }

  @override
  void didUpdateWidget(ZoniDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      _selectedDate = widget.initialDate;
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

  String get _dateFormat {
    return widget.dateFormat ?? 'MM/dd/yyyy';
  }

  DateTime get _firstDate {
    return widget.firstDate ?? DateTime(1900);
  }

  DateTime get _lastDate {
    return widget.lastDate ?? DateTime(2100);
  }

  double get _fieldHeight {
    if (widget.fieldHeight != null) return widget.fieldHeight!;
    switch (widget.size) {
      case ZoniDatePickerSize.small:
        return 40.0;
      case ZoniDatePickerSize.medium:
        return 48.0;
      case ZoniDatePickerSize.large:
        return 56.0;
    }
  }

  EdgeInsets get _contentPadding {
    switch (widget.size) {
      case ZoniDatePickerSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniDatePickerSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniDatePickerSize.large:
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
      case ZoniDatePickerVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniDatePickerVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniDatePickerVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: _borderRadius,
        );
    }
  }

  InputBorder get _focusedBorder {
    final Color borderColor = widget.focusedBorderColor ?? ZoniColors.primary;
    switch (widget.variant) {
      case ZoniDatePickerVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
      case ZoniDatePickerVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
      case ZoniDatePickerVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
    }
  }

  InputBorder get _errorBorder {
    final Color borderColor = widget.errorBorderColor ?? ZoniColors.error;
    switch (widget.variant) {
      case ZoniDatePickerVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniDatePickerVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniDatePickerVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
    }
  }

  Color? get _fillColor {
    if (widget.backgroundColor != null) return widget.backgroundColor;
    return widget.variant == ZoniDatePickerVariant.filled
        ? ZoniColors.surfaceVariant
        : null;
  }

  void _updateFieldText() {
    if (_selectedDate != null) {
      _controller.text = _formatDate(_selectedDate!);
    } else if (_selectedRange != null) {
      _controller.text = '${_formatDate(_selectedRange!.start)} - ${_formatDate(_selectedRange!.end)}';
    } else {
      _controller.text = '';
    }
  }

  String _formatDate(DateTime date) {
    // Simple date formatting - in a real implementation, you'd use intl package
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _showDatePicker() async {
    if (!widget.enabled) return;

    switch (widget.mode) {
      case ZoniDatePickerMode.date:
        await _showSingleDatePicker();
        break;
      case ZoniDatePickerMode.dateTime:
        await _showDateTimePicker();
        break;
      case ZoniDatePickerMode.dateRange:
        await _showDateRangePicker();
        break;
    }
  }

  Future<void> _showSingleDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
      locale: widget.locale,
      selectableDayPredicate: widget.selectableDayPredicate,
      initialDatePickerMode: widget.initialDatePickerMode,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: ZoniColors.primary,
              onPrimary: ZoniColors.onPrimary,
              surface: ZoniColors.surface,
              onSurface: ZoniColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateFieldText();
      });
      widget.onDateSelected?.call(picked);
    }
  }

  Future<void> _showDateTimePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
      locale: widget.locale,
      selectableDayPredicate: widget.selectableDayPredicate,
      initialDatePickerMode: widget.initialDatePickerMode,
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
      );

      if (pickedTime != null) {
        final DateTime combined = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDate = combined;
          _updateFieldText();
        });
        widget.onDateSelected?.call(combined);
      }
    }
  }

  Future<void> _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: _firstDate,
      lastDate: _lastDate,
      initialDateRange: _selectedRange,
      locale: widget.locale,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: ZoniColors.primary,
              onPrimary: ZoniColors.onPrimary,
              surface: ZoniColors.surface,
              onSurface: ZoniColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedRange) {
      setState(() {
        _selectedRange = picked;
        _updateFieldText();
      });
      widget.onDateRangeSelected?.call(picked);
    }
  }

  void _clearSelection() {
    setState(() {
      _selectedDate = null;
      _selectedRange = null;
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
          _showDatePicker();
        },
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: widget.textStyle ??
            ZoniTextStyles.bodyMedium.copyWith(
              color: widget.enabled ? ZoniColors.onSurface : ZoniColors.onSurface.withValues(alpha: 0.6),
            ),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText ?? 'Select date',
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon ??
              Icon(
                Icons.calendar_today,
                color: widget.enabled ? ZoniColors.onSurfaceVariant : ZoniColors.onSurface.withValues(alpha: 0.4),
              ),
          suffixIcon: widget.showClearButton && (_selectedDate != null || _selectedRange != null)
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: widget.enabled ? _clearSelection : null,
                  color: ZoniColors.onSurfaceVariant,
                )
              : widget.suffixIcon,
          filled: widget.variant == ZoniDatePickerVariant.filled,
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
