import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Option for multi-select component.
class ZoniMultiSelectOption<T> {
  /// Creates a multi-select option.
  const ZoniMultiSelectOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
    this.avatar,
    this.enabled = true,
    this.group,
  });

  /// Value of the option.
  final T value;

  /// Label to display.
  final String label;

  /// Optional subtitle.
  final String? subtitle;

  /// Optional icon.
  final IconData? icon;

  /// Optional avatar widget.
  final Widget? avatar;

  /// Whether the option is enabled.
  final bool enabled;

  /// Optional group for the option.
  final String? group;
}

/// Multi-select component variants.
enum ZoniMultiSelectVariant {
  /// Dropdown style multi-select.
  dropdown,

  /// List style multi-select.
  list,

  /// Chip style multi-select.
  chips,

  /// Modal style multi-select.
  modal,
}

/// Comprehensive multi-select component.
class ZoniMultiSelect<T> extends StatefulWidget {
  /// Creates a multi-select component.
  const ZoniMultiSelect({
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    super.key,
    this.variant = ZoniMultiSelectVariant.dropdown,
    this.title,
    this.hint = 'Select options',
    this.searchHint = 'Search options',
    this.emptyMessage = 'No options available',
    this.noResultsMessage = 'No results found',
    this.maxHeight = 300.0,
    this.searchable = true,
    this.clearable = true,
    this.showSelectAll = true,
    this.groupBy,
    this.itemBuilder,
    this.chipBuilder,
    this.separatorBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.validator,
    this.enabled = true,
    this.dense = false,
    this.showCounter = false,
    this.maxSelections,
    this.minSelections,
    this.decoration,
    this.style,
    this.dropdownColor,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
  });

  /// Available options to select from.
  final List<ZoniMultiSelectOption<T>> options;

  /// Currently selected values.
  final List<T> selectedValues;

  /// Callback when selection changes.
  final void Function(List<T> selectedValues) onChanged;

  /// Variant of the multi-select.
  final ZoniMultiSelectVariant variant;

  /// Title for the multi-select.
  final String? title;

  /// Hint text when no selection is made.
  final String hint;

  /// Hint text for search field.
  final String searchHint;

  /// Message when no options are available.
  final String emptyMessage;

  /// Message when search returns no results.
  final String noResultsMessage;

  /// Maximum height of the dropdown/list.
  final double maxHeight;

  /// Whether search is enabled.
  final bool searchable;

  /// Whether clear all button is shown.
  final bool clearable;

  /// Whether select all button is shown.
  final bool showSelectAll;

  /// Function to group options.
  final String Function(ZoniMultiSelectOption<T> option)? groupBy;

  /// Custom item builder.
  final Widget Function(
    BuildContext context,
    ZoniMultiSelectOption<T> option,
    bool isSelected,
  )? itemBuilder;

  /// Custom chip builder for selected items.
  final Widget Function(
    BuildContext context,
    ZoniMultiSelectOption<T> option,
    VoidCallback onRemove,
  )? chipBuilder;

  /// Custom separator builder between items.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// Custom header builder.
  final Widget Function(BuildContext context)? headerBuilder;

  /// Custom footer builder.
  final Widget Function(BuildContext context)? footerBuilder;

  /// Validator function.
  final String? Function(List<T>? values)? validator;

  /// Whether the multi-select is enabled.
  final bool enabled;

  /// Whether to use dense layout.
  final bool dense;

  /// Whether to show selection counter.
  final bool showCounter;

  /// Maximum number of selections allowed.
  final int? maxSelections;

  /// Minimum number of selections required.
  final int? minSelections;

  /// Input decoration.
  final InputDecoration? decoration;

  /// Text style.
  final TextStyle? style;

  /// Background color of dropdown.
  final Color? dropdownColor;

  /// Border radius.
  final double borderRadius;

  /// Elevation of dropdown.
  final double elevation;

  @override
  State<ZoniMultiSelect<T>> createState() => _ZoniMultiSelectState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<ZoniMultiSelectOption<T>>('options', options));
    properties.add(IterableProperty<T>('selectedValues', selectedValues));
    properties.add(
      ObjectFlagProperty<void Function(List<T> selectedValues)>.has(
        'onChanged',
        onChanged,
      ),
    );
    properties.add(EnumProperty<ZoniMultiSelectVariant>('variant', variant));
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('hint', hint));
    properties.add(StringProperty('searchHint', searchHint));
    properties.add(StringProperty('emptyMessage', emptyMessage));
    properties.add(StringProperty('noResultsMessage', noResultsMessage));
    properties.add(DoubleProperty('maxHeight', maxHeight));
    properties.add(DiagnosticsProperty<bool>('searchable', searchable));
    properties.add(DiagnosticsProperty<bool>('clearable', clearable));
    properties.add(DiagnosticsProperty<bool>('showSelectAll', showSelectAll));
    properties.add(
      ObjectFlagProperty<
          String Function(
            ZoniMultiSelectOption<T> option,
          )?>.has('groupBy', groupBy),
    );
    properties.add(
      ObjectFlagProperty<
          Widget Function(
            BuildContext context,
            ZoniMultiSelectOption<T> option,
            bool isSelected,
          )?>.has('itemBuilder', itemBuilder),
    );
    properties.add(
      ObjectFlagProperty<
          Widget Function(
            BuildContext context,
            ZoniMultiSelectOption<T> option,
            VoidCallback onRemove,
          )?>.has('chipBuilder', chipBuilder),
    );
    properties.add(
      ObjectFlagProperty<Widget Function(BuildContext context, int index)?>.has(
        'separatorBuilder',
        separatorBuilder,
      ),
    );
    properties.add(
      ObjectFlagProperty<Widget Function(BuildContext context)?>.has(
        'headerBuilder',
        headerBuilder,
      ),
    );
    properties.add(
      ObjectFlagProperty<Widget Function(BuildContext context)?>.has(
        'footerBuilder',
        footerBuilder,
      ),
    );
    properties.add(
      ObjectFlagProperty<String? Function(List<T>? values)?>.has(
        'validator',
        validator,
      ),
    );
    properties.add(DiagnosticsProperty<bool>('enabled', enabled));
    properties.add(DiagnosticsProperty<bool>('dense', dense));
    properties.add(DiagnosticsProperty<bool>('showCounter', showCounter));
    properties.add(IntProperty('maxSelections', maxSelections));
    properties.add(IntProperty('minSelections', minSelections));
    properties
        .add(DiagnosticsProperty<InputDecoration?>('decoration', decoration));
    properties.add(DiagnosticsProperty<TextStyle?>('style', style));
    properties.add(ColorProperty('dropdownColor', dropdownColor));
    properties.add(DoubleProperty('borderRadius', borderRadius));
    properties.add(DoubleProperty('elevation', elevation));
  }
}

class _ZoniMultiSelectState<T> extends State<ZoniMultiSelect<T>> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<ZoniMultiSelectOption<T>> _filteredOptions =
      <ZoniMultiSelectOption<T>>[];
  bool _isOpen = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(ZoniMultiSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options != oldWidget.options) {
      _filteredOptions = widget.options;
      _onSearchChanged();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = widget.options
          .where(
            (ZoniMultiSelectOption<T> option) =>
                option.label.toLowerCase().contains(query) ||
                (option.subtitle?.toLowerCase().contains(query) ?? false),
          )
          .toList();
    });
  }

  void _toggleSelection(T value) {
    final List<T> newSelection = List<T>.from(widget.selectedValues);

    if (newSelection.contains(value)) {
      newSelection.remove(value);
    } else {
      if (widget.maxSelections == null ||
          newSelection.length < widget.maxSelections!) {
        newSelection.add(value);
      }
    }

    _validate(newSelection);
    widget.onChanged(newSelection);
  }

  void _selectAll() {
    final List<T> allValues = _filteredOptions
        .where((ZoniMultiSelectOption<T> option) => option.enabled)
        .map((ZoniMultiSelectOption<T> option) => option.value)
        .toList();
    final List<T> limitedValues = widget.maxSelections != null
        ? allValues.take(widget.maxSelections!).toList()
        : allValues;

    _validate(limitedValues);
    widget.onChanged(limitedValues);
  }

  void _clearAll() {
    _validate(<T>[]);
    widget.onChanged(<T>[]);
  }

  void _validate(List<T> values) {
    String? error;

    if (widget.validator != null) {
      error = widget.validator!(values);
    } else {
      if (widget.minSelections != null &&
          values.length < widget.minSelections!) {
        error = 'Select at least ${widget.minSelections} options';
      } else if (widget.maxSelections != null &&
          values.length > widget.maxSelections!) {
        error = 'Select at most ${widget.maxSelections} options';
      }
    }

    setState(() {
      _errorText = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.variant) {
      case ZoniMultiSelectVariant.dropdown:
        return _buildDropdown();
      case ZoniMultiSelectVariant.list:
        return _buildList();
      case ZoniMultiSelectVariant.chips:
        return _buildChips();
      case ZoniMultiSelectVariant.modal:
        return _buildModal();
    }
  }

  Widget _buildDropdown() {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.title!,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        GestureDetector(
          onTap:
              widget.enabled ? () => setState(() => _isOpen = !_isOpen) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    _errorText != null ? ZoniColors.error : theme.dividerColor,
                width: _errorText != null ? 2.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: widget.enabled
                  ? theme.cardColor
                  : theme.disabledColor.withValues(alpha: 0.1),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildSelectedDisplay(),
                ),
                Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: widget.enabled
                      ? theme.iconTheme.color
                      : theme.disabledColor,
                ),
              ],
            ),
          ),
        ),
        if (_isOpen && widget.enabled) _buildDropdownContent(),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: ZoniColors.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSelectedDisplay() {
    final ThemeData theme = Theme.of(context);

    if (widget.selectedValues.isEmpty) {
      return Text(
        widget.hint,
        style: widget.style?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
            ) ??
            theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
            ),
      );
    }

    final List<ZoniMultiSelectOption<T>> selectedOptions = widget.options
        .where(
          (ZoniMultiSelectOption<T> option) =>
              widget.selectedValues.contains(option.value),
        )
        .toList();

    if (selectedOptions.length == 1) {
      return Text(
        selectedOptions.first.label,
        style: widget.style ?? theme.textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      );
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            '${selectedOptions.length} selected',
            style: widget.style ?? theme.textTheme.bodyMedium,
          ),
        ),
        if (widget.showCounter)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: ZoniColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${selectedOptions.length}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownContent() {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 4),
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      decoration: BoxDecoration(
        color: widget.dropdownColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: widget.elevation,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.headerBuilder != null) widget.headerBuilder!(context),
          if (widget.searchable) _buildSearchField(),
          if (widget.showSelectAll || widget.clearable) _buildActionButtons(),
          Flexible(
            child: _buildOptionsList(),
          ),
          if (widget.footerBuilder != null) widget.footerBuilder!(context),
        ],
      ),
    );
  }

  Widget _buildSearchField() => Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: widget.searchHint,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      );

  Widget _buildActionButtons() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            if (widget.showSelectAll)
              TextButton(
                onPressed: _selectAll,
                child: const Text('Select All'),
              ),
            const Spacer(),
            if (widget.clearable)
              TextButton(
                onPressed: _clearAll,
                child: const Text('Clear All'),
              ),
          ],
        ),
      );

  Widget _buildOptionsList() {
    if (_filteredOptions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _filteredOptions.length,
      itemBuilder: (BuildContext context, int index) {
        final ZoniMultiSelectOption<T> option = _filteredOptions[index];
        final bool isSelected = widget.selectedValues.contains(option.value);

        return _buildOptionItem(option, isSelected);
      },
    );
  }

  Widget _buildOptionItem(ZoniMultiSelectOption<T> option, bool isSelected) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(context, option, isSelected);
    }

    final ThemeData theme = Theme.of(context);

    return CheckboxListTile(
      value: isSelected,
      onChanged: option.enabled
          ? (bool? value) => _toggleSelection(option.value)
          : null,
      title: Text(
        option.label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: option.enabled ? null : theme.disabledColor,
        ),
      ),
      subtitle: option.subtitle != null
          ? Text(
              option.subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: option.enabled
                    ? theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7)
                    : theme.disabledColor,
              ),
            )
          : null,
      secondary:
          option.avatar ?? (option.icon != null ? Icon(option.icon) : null),
      dense: widget.dense,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildEmptyState() {
    final ThemeData theme = Theme.of(context);
    final String message = _searchController.text.isNotEmpty
        ? widget.noResultsMessage
        : widget.emptyMessage;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    // Implementation for list variant
    return Container(); // Placeholder
  }

  Widget _buildChips() {
    // Implementation for chips variant
    return Container(); // Placeholder
  }

  Widget _buildModal() {
    // Implementation for modal variant
    return Container(); // Placeholder
  }
}
