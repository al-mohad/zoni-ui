import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';
import '../../utils/zoni_animations.dart';
import '../../utils/zoni_haptics.dart';
import '../../utils/zoni_input_utils.dart';

/// Search field variants for the Zoni design system.
///
/// This is an alias for [ZoniInputVariant] to maintain backward compatibility.
typedef ZoniSearchFieldVariant = ZoniInputVariant;

/// Search field size variants for the Zoni design system.
///
/// This is an alias for [ZoniInputSize] to maintain backward compatibility.
typedef ZoniSearchFieldSize = ZoniInputSize;

/// Represents a search suggestion.
class ZoniSearchSuggestion {
  /// Creates a search suggestion.
  const ZoniSearchSuggestion({
    required this.value,
    this.label,
    this.subtitle,
    this.icon,
    this.data,
  });

  /// The value of the suggestion.
  final String value;

  /// Display label for the suggestion (defaults to value).
  final String? label;

  /// Optional subtitle for the suggestion.
  final String? subtitle;

  /// Optional icon for the suggestion.
  final Widget? icon;

  /// Additional data associated with the suggestion.
  final dynamic data;

  /// Gets the display label.
  String get displayLabel => label ?? value;
}

/// A specialized search input following Zoni design system.
///
/// The [ZoniSearchField] widget provides a search input with autocomplete
/// and filtering capabilities.
///
/// Example usage:
/// ```dart
/// ZoniSearchField(
///   hintText: 'Search users...',
///   suggestions: [
///     ZoniSearchSuggestion(value: 'John Doe'),
///     ZoniSearchSuggestion(value: 'Jane Smith'),
///   ],
///   onSearch: (query) {
///     print('Searching for: $query');
///   },
/// )
/// ```
class ZoniSearchField extends StatefulWidget {
  /// Creates a Zoni search field.
  const ZoniSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.variant = ZoniSearchFieldVariant.outlined,
    this.size = ZoniSearchFieldSize.medium,
    // Backward compatibility parameters
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.showClearButton = true,
    this.showSearchIcon = true,
    this.suggestions = const <ZoniSearchSuggestion>[],
    this.maxSuggestions = 5,
    this.suggestionBuilder,
    this.onSearch,
    this.onSuggestionSelected,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onFocusChanged,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.debounceDelay = const Duration(milliseconds: 300),
  });

  /// Text editing controller for the field.
  final TextEditingController? controller;

  /// Focus node for the field.
  final FocusNode? focusNode;

  /// The decoration configuration for the search field.
  ///
  /// If null, a default decoration will be created based on the variant and size.
  final ZoniInputDecoration? decoration;

  /// Initial value for the field.
  final String? initialValue;

  /// Hint text for the field.
  final String? hintText;

  /// Label text for the field.
  final String? labelText;

  /// Helper text for the field.
  final String? helperText;

  /// Error text for the field.
  final String? errorText;

  /// Prefix icon for the field.
  final Widget? prefixIcon;

  /// Suffix icon for the field.
  final Widget? suffixIcon;

  /// Visual variant of the search field.
  final ZoniSearchFieldVariant variant;

  /// Size of the search field.
  final ZoniSearchFieldSize size;

  /// Whether the field is enabled.
  final bool enabled;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether the field should autofocus.
  final bool autofocus;

  /// Whether autocorrect is enabled.
  final bool autocorrect;

  /// Whether to enable suggestions.
  final bool enableSuggestions;

  /// Whether to show the clear button.
  final bool showClearButton;

  /// Whether to show the search icon.
  final bool showSearchIcon;

  /// List of search suggestions.
  final List<ZoniSearchSuggestion> suggestions;

  /// Maximum number of suggestions to show.
  final int maxSuggestions;

  /// Builder for custom suggestion items.
  final Widget Function(BuildContext context, ZoniSearchSuggestion suggestion)?
      suggestionBuilder;

  /// Callback when search is performed.
  final void Function(String query)? onSearch;

  /// Callback when a suggestion is selected.
  final void Function(ZoniSearchSuggestion suggestion)? onSuggestionSelected;

  /// Callback when the field value changes.
  final void Function(String value)? onChanged;

  /// Callback when the field is submitted.
  final void Function(String value)? onSubmitted;

  /// Callback when the field is tapped.
  final VoidCallback? onTap;

  /// Callback when focus changes.
  final void Function(bool hasFocus)? onFocusChanged;

  /// Validator function for the field.
  final String? Function(String?)? validator;

  /// Input formatters for the field.
  final List<TextInputFormatter>? inputFormatters;

  /// Text input action for the field.
  final TextInputAction? textInputAction;

  /// Keyboard type for the field.
  final TextInputType? keyboardType;

  /// Text capitalization for the field.
  final TextCapitalization textCapitalization;

  /// Text alignment for the field.
  final TextAlign textAlign;

  /// Text direction for the field.
  final TextDirection? textDirection;

  /// Maximum length of the field.
  final int? maxLength;

  /// Maximum lines for the field.
  final int? maxLines;

  /// Minimum lines for the field.
  final int? minLines;

  /// Whether the field expands.
  final bool expands;

  /// Width of the field.
  final double? width;

  /// Height of the field.
  final double? height;

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

  /// Hint style for the field.
  final TextStyle? hintStyle;

  /// Label style for the field.
  final TextStyle? labelStyle;

  /// Helper style for the field.
  final TextStyle? helperStyle;

  /// Error style for the field.
  final TextStyle? errorStyle;

  /// Debounce delay for search queries.
  final Duration debounceDelay;

  @override
  State<ZoniSearchField> createState() => _ZoniSearchFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TextEditingController?>('controller', controller));
    properties.add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode));
    properties.add(
        DiagnosticsProperty<ZoniInputDecoration?>('decoration', decoration));
    properties.add(StringProperty('initialValue', initialValue));
    properties.add(StringProperty('hintText', hintText));
    properties.add(StringProperty('labelText', labelText));
    properties.add(StringProperty('helperText', helperText));
    properties.add(StringProperty('errorText', errorText));
    properties.add(EnumProperty<ZoniSearchFieldVariant>('variant', variant));
    properties.add(EnumProperty<ZoniSearchFieldSize>('size', size));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled));
    properties.add(DiagnosticsProperty<bool>('readOnly', readOnly));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect));
    properties
        .add(DiagnosticsProperty<bool>('enableSuggestions', enableSuggestions));
    properties
        .add(DiagnosticsProperty<bool>('showClearButton', showClearButton));
    properties.add(DiagnosticsProperty<bool>('showSearchIcon', showSearchIcon));
    properties.add(
        IterableProperty<ZoniSearchSuggestion>('suggestions', suggestions));
    properties.add(IntProperty('maxSuggestions', maxSuggestions));
    properties.add(ObjectFlagProperty<
            Widget Function(
                BuildContext context, ZoniSearchSuggestion suggestion)?>.has(
        'suggestionBuilder', suggestionBuilder));
    properties.add(ObjectFlagProperty<void Function(String query)?>.has(
        'onSearch', onSearch));
    properties.add(
        ObjectFlagProperty<void Function(ZoniSearchSuggestion suggestion)?>.has(
            'onSuggestionSelected', onSuggestionSelected));
    properties.add(ObjectFlagProperty<void Function(String value)?>.has(
        'onChanged', onChanged));
    properties.add(ObjectFlagProperty<void Function(String value)?>.has(
        'onSubmitted', onSubmitted));
    properties.add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
    properties.add(ObjectFlagProperty<void Function(bool hasFocus)?>.has(
        'onFocusChanged', onFocusChanged));
    properties.add(ObjectFlagProperty<String? Function(String? p1)?>.has(
        'validator', validator));
    properties.add(IterableProperty<TextInputFormatter>(
        'inputFormatters', inputFormatters));
    properties.add(
        EnumProperty<TextInputAction?>('textInputAction', textInputAction));
    properties
        .add(DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType));
    properties.add(EnumProperty<TextCapitalization>(
        'textCapitalization', textCapitalization));
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign));
    properties
        .add(EnumProperty<TextDirection?>('textDirection', textDirection));
    properties.add(IntProperty('maxLength', maxLength));
    properties.add(IntProperty('maxLines', maxLines));
    properties.add(IntProperty('minLines', minLines));
    properties.add(DiagnosticsProperty<bool>('expands', expands));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties
        .add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('borderColor', borderColor));
    properties.add(ColorProperty('focusedBorderColor', focusedBorderColor));
    properties.add(ColorProperty('errorBorderColor', errorBorderColor));
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
    properties.add(DiagnosticsProperty<TextStyle?>('hintStyle', hintStyle));
    properties.add(DiagnosticsProperty<TextStyle?>('labelStyle', labelStyle));
    properties.add(DiagnosticsProperty<TextStyle?>('helperStyle', helperStyle));
    properties.add(DiagnosticsProperty<TextStyle?>('errorStyle', errorStyle));
    properties
        .add(DiagnosticsProperty<Duration>('debounceDelay', debounceDelay));
  }

  // Note: debugFillProperties temporarily removed due to import issues
  // Will be restored in a future update with proper diagnostic imports
}

class _ZoniSearchFieldState extends State<ZoniSearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<ZoniSearchSuggestion> _filteredSuggestions = <ZoniSearchSuggestion>[];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(ZoniSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.suggestions != oldWidget.suggestions) {
      _filterSuggestions(_controller.text);
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.removeListener(_onFocusChanged);
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  double get _fieldHeight {
    if (widget.height != null) return widget.height!;
    switch (widget.size) {
      case ZoniSearchFieldSize.small:
        return 40;
      case ZoniSearchFieldSize.medium:
        return 48;
      case ZoniSearchFieldSize.large:
        return 56;
    }
  }

  EdgeInsets get _contentPadding {
    switch (widget.size) {
      case ZoniSearchFieldSize.small:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.sm,
          vertical: ZoniSpacing.xs,
        );
      case ZoniSearchFieldSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.md,
          vertical: ZoniSpacing.sm,
        );
      case ZoniSearchFieldSize.large:
        return const EdgeInsets.symmetric(
          horizontal: ZoniSpacing.lg,
          vertical: ZoniSpacing.md,
        );
    }
  }

  BorderRadius get _borderRadius =>
      widget.borderRadius ??
      const BorderRadius.all(Radius.circular(ZoniBorderRadius.sm));

  InputBorder get _border {
    final Color borderColor = widget.borderColor ?? ZoniColors.outline;
    switch (widget.variant) {
      case ZoniSearchFieldVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniSearchFieldVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniSearchFieldVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: _borderRadius,
        );
    }
  }

  InputBorder get _focusedBorder {
    final Color borderColor = widget.focusedBorderColor ?? ZoniColors.primary;
    switch (widget.variant) {
      case ZoniSearchFieldVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
      case ZoniSearchFieldVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
      case ZoniSearchFieldVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: _borderRadius,
        );
    }
  }

  InputBorder get _errorBorder {
    final Color borderColor = widget.errorBorderColor ?? ZoniColors.error;
    switch (widget.variant) {
      case ZoniSearchFieldVariant.standard:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniSearchFieldVariant.outlined:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
      case ZoniSearchFieldVariant.filled:
        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: _borderRadius,
        );
    }
  }

  Color? get _fillColor {
    if (widget.backgroundColor != null) return widget.backgroundColor;
    return widget.variant == ZoniSearchFieldVariant.filled
        ? ZoniColors.surfaceVariant
        : null;
  }

  void _onFocusChanged() {
    final bool hasFocus = _focusNode.hasFocus;
    widget.onFocusChanged?.call(hasFocus);

    if (hasFocus && _filteredSuggestions.isNotEmpty) {
      _showSuggestionsOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _onTextChanged() {
    final String text = _controller.text;
    widget.onChanged?.call(text);
    _filterSuggestions(text);
  }

  void _filterSuggestions(String query) {
    if (!widget.enableSuggestions || query.isEmpty) {
      setState(() {
        _filteredSuggestions = <ZoniSearchSuggestion>[];
        _showSuggestions = false;
      });
      _removeOverlay();
      return;
    }

    final List<ZoniSearchSuggestion> filtered = widget.suggestions
        .where(
          (ZoniSearchSuggestion suggestion) =>
              suggestion.displayLabel
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (suggestion.subtitle
                      ?.toLowerCase()
                      .contains(query.toLowerCase()) ??
                  false),
        )
        .take(widget.maxSuggestions)
        .toList();

    setState(() {
      _filteredSuggestions = filtered;
      _showSuggestions = filtered.isNotEmpty && _focusNode.hasFocus;
    });

    if (_showSuggestions) {
      _showSuggestionsOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showSuggestionsOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        width: context.size?.width ?? 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, _fieldHeight + 4),
          child: Material(
            elevation: 4,
            borderRadius: _borderRadius,
            color: ZoniColors.surface,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                border: Border.all(color: ZoniColors.outline),
                borderRadius: _borderRadius,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredSuggestions.length,
                itemBuilder: (BuildContext context, int index) {
                  final ZoniSearchSuggestion suggestion =
                      _filteredSuggestions[index];
                  return _buildSuggestionItem(suggestion);
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildSuggestionItem(ZoniSearchSuggestion suggestion) {
    if (widget.suggestionBuilder != null) {
      return InkWell(
        onTap: () => _selectSuggestion(suggestion),
        child: widget.suggestionBuilder!(context, suggestion),
      );
    }

    return ListTile(
      dense: true,
      leading: suggestion.icon,
      title: Text(
        suggestion.displayLabel,
        style: ZoniTextStyles.bodyMedium.copyWith(
          color: ZoniColors.onSurface,
        ),
      ),
      subtitle: suggestion.subtitle != null
          ? Text(
              suggestion.subtitle!,
              style: ZoniTextStyles.bodySmall.copyWith(
                color: ZoniColors.onSurfaceVariant,
              ),
            )
          : null,
      onTap: () => _selectSuggestion(suggestion),
    );
  }

  void _selectSuggestion(ZoniSearchSuggestion suggestion) {
    _controller.text = suggestion.value;
    _removeOverlay();
    _focusNode.unfocus();
    widget.onSuggestionSelected?.call(suggestion);
    widget.onSearch?.call(suggestion.value);
  }

  void _performSearch() {
    final String query = _controller.text.trim();
    if (query.isNotEmpty) {
      _removeOverlay();
      _focusNode.unfocus();
      widget.onSearch?.call(query);
    }
  }

  void _clearField() {
    _controller.clear();
    _removeOverlay();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: _layerLink,
        child: SizedBox(
          width: widget.width,
          height: _fieldHeight,
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            autocorrect: widget.autocorrect,
            enableSuggestions: false, // We handle suggestions manually
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction ?? TextInputAction.search,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textCapitalization: widget.textCapitalization,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            expands: widget.expands,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onFieldSubmitted: (String value) {
              widget.onSubmitted?.call(value);
              _performSearch();
            },
            style: widget.textStyle ??
                ZoniTextStyles.bodyMedium.copyWith(
                  color: widget.enabled
                      ? ZoniColors.onSurface
                      : ZoniColors.onSurface.withValues(alpha: 0.6),
                ),
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText ?? 'Search...',
              helperText: widget.helperText,
              errorText: widget.errorText,
              prefixIcon: widget.prefixIcon ??
                  (widget.showSearchIcon
                      ? Icon(
                          Icons.search,
                          color: widget.enabled
                              ? ZoniColors.onSurfaceVariant
                              : ZoniColors.onSurface.withValues(alpha: 0.4),
                        )
                      : null),
              suffixIcon: widget.showClearButton && _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: widget.enabled ? _clearField : null,
                      color: ZoniColors.onSurfaceVariant,
                    )
                  : widget.suffixIcon,
              filled: widget.variant == ZoniSearchFieldVariant.filled,
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
        ),
      );
}
