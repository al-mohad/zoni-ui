import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Toggle group component for selecting one or multiple options.
class ZoniToggleGroup<T> extends StatelessWidget {
  /// Creates a toggle group.
  const ZoniToggleGroup({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.multiSelect = false,
    this.direction = Axis.horizontal,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.borderRadius = 8.0,
  });

  /// Available options.
  final List<ZoniToggleOption<T>> options;

  /// Currently selected values.
  final List<T> selectedValues;

  /// Called when selection changes.
  final ValueChanged<List<T>> onChanged;

  /// Whether multiple selection is allowed.
  final bool multiSelect;

  /// Direction to arrange toggles.
  final Axis direction;

  /// Spacing between toggles.
  final double spacing;

  /// Run spacing for wrapped layout.
  final double runSpacing;

  /// Border radius of toggles.
  final double borderRadius;

  void _handleToggle(T value) {
    final newSelection = List<T>.from(selectedValues);
    
    if (newSelection.contains(value)) {
      newSelection.remove(value);
    } else {
      if (multiSelect) {
        newSelection.add(value);
      } else {
        newSelection.clear();
        newSelection.add(value);
      }
    }
    
    onChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final toggles = options.map((option) {
      final isSelected = selectedValues.contains(option.value);
      
      return ZoniToggleButton(
        isSelected: isSelected,
        onPressed: () => _handleToggle(option.value),
        borderRadius: borderRadius,
        child: option.child,
      );
    }).toList();

    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: toggles,
      );
    } else {
      return Column(
        children: toggles.map((toggle) => Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: toggle,
        )).toList(),
      );
    }
  }
}

/// Toggle option data class.
class ZoniToggleOption<T> {
  /// Creates a toggle option.
  const ZoniToggleOption({
    required this.value,
    required this.child,
  });

  /// The value of this option.
  final T value;

  /// The widget to display.
  final Widget child;
}

/// Individual toggle button.
class ZoniToggleButton extends StatelessWidget {
  /// Creates a toggle button.
  const ZoniToggleButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.child,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  });

  /// Whether this toggle is selected.
  final bool isSelected;

  /// Called when pressed.
  final VoidCallback onPressed;

  /// The child widget.
  final Widget child;

  /// Border radius.
  final double borderRadius;

  /// Padding inside the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      color: isSelected 
          ? ZoniColors.primary
          : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isSelected 
                  ? ZoniColors.primary
                  : theme.colorScheme.outline.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: DefaultTextStyle(
            style: theme.textTheme.bodyMedium!.copyWith(
              color: isSelected 
                  ? Colors.white
                  : theme.textTheme.bodyMedium?.color,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Rating component for star ratings.
class ZoniRating extends StatelessWidget {
  /// Creates a rating component.
  const ZoniRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.onRatingChanged,
    this.size = 24.0,
    this.color,
    this.unratedColor,
    this.allowHalfRating = false,
    this.itemSpacing = 4.0,
    this.readonly = false,
  });

  /// Current rating value.
  final double rating;

  /// Maximum rating value.
  final int maxRating;

  /// Called when rating changes.
  final ValueChanged<double>? onRatingChanged;

  /// Size of each star.
  final double size;

  /// Color of filled stars.
  final Color? color;

  /// Color of unfilled stars.
  final Color? unratedColor;

  /// Whether to allow half ratings.
  final bool allowHalfRating;

  /// Spacing between stars.
  final double itemSpacing;

  /// Whether the rating is readonly.
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = color ?? ZoniColors.warning;
    final inactiveColor = unratedColor ?? 
        theme.colorScheme.outline.withValues(alpha: 0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starValue = index + 1.0;
        final isActive = rating >= starValue;
        final isHalfActive = allowHalfRating && 
            rating >= starValue - 0.5 && rating < starValue;

        return Padding(
          padding: EdgeInsets.only(
            right: index < maxRating - 1 ? itemSpacing : 0,
          ),
          child: GestureDetector(
            onTap: readonly ? null : () {
              if (allowHalfRating) {
                // Handle half rating logic
                final newRating = rating == starValue ? starValue - 0.5 : starValue;
                onRatingChanged?.call(newRating);
              } else {
                onRatingChanged?.call(starValue);
              }
            },
            child: Icon(
              isActive || isHalfActive ? Icons.star : Icons.star_border,
              size: size,
              color: isActive || isHalfActive ? activeColor : inactiveColor,
            ),
          ),
        );
      }),
    );
  }
}

/// Tag input component for adding/removing tags.
class ZoniTagInput extends StatefulWidget {
  /// Creates a tag input.
  const ZoniTagInput({
    super.key,
    required this.tags,
    required this.onTagsChanged,
    this.hintText = 'Add tag...',
    this.maxTags,
    this.tagSpacing = 8.0,
    this.runSpacing = 8.0,
  });

  /// Current tags.
  final List<String> tags;

  /// Called when tags change.
  final ValueChanged<List<String>> onTagsChanged;

  /// Hint text for input.
  final String hintText;

  /// Maximum number of tags.
  final int? maxTags;

  /// Spacing between tags.
  final double tagSpacing;

  /// Run spacing for wrapped tags.
  final double runSpacing;

  @override
  State<ZoniTagInput> createState() => _ZoniTagInputState();
}

class _ZoniTagInputState extends State<ZoniTagInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _addTag(String tag) {
    final trimmedTag = tag.trim();
    if (trimmedTag.isNotEmpty && 
        !widget.tags.contains(trimmedTag) &&
        (widget.maxTags == null || widget.tags.length < widget.maxTags!)) {
      final newTags = List<String>.from(widget.tags)..add(trimmedTag);
      widget.onTagsChanged(newTags);
      _controller.clear();
    }
  }

  void _removeTag(String tag) {
    final newTags = List<String>.from(widget.tags)..remove(tag);
    widget.onTagsChanged(newTags);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.tags.isNotEmpty) ...[
          Wrap(
            spacing: widget.tagSpacing,
            runSpacing: widget.runSpacing,
            children: widget.tags.map((tag) => Chip(
              label: Text(tag),
              onDeleted: () => _removeTag(tag),
              deleteIcon: const Icon(Icons.close, size: 16),
            )).toList(),
          ),
          const SizedBox(height: 8.0),
        ],
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: _addTag,
        ),
      ],
    );
  }
}
