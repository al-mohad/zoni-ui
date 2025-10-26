import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for chip variants.
enum ZoniChipVariant {
  /// Filled chip variant.
  filled,

  /// Outlined chip variant.
  outlined,

  /// Input chip variant.
  input,

  /// Choice chip variant.
  choice,

  /// Filter chip variant.
  filter,

  /// Action chip variant.
  action,
}

/// Enum for chip sizes.
enum ZoniChipSize {
  /// Small chip size.
  small,

  /// Medium chip size.
  medium,

  /// Large chip size.
  large,
}

/// A chip widget that follows Zoni design system principles.
class ZoniChip extends StatelessWidget {
  /// Creates a ZoniChip.
  const ZoniChip({
    required this.label,
    super.key,
    this.variant = ZoniChipVariant.filled,
    this.size = ZoniChipSize.medium,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onPressed,
    this.onSelected,
    this.selected = false,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.selectedColor,
    this.disabledColor,
    this.labelStyle,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.selectedShadowColor,
    this.showCheckmark,
    this.checkmarkColor,
    this.avatarBorder = const CircleBorder(),
    this.padding,
    this.visualDensity,
    this.labelPadding,
    this.pressElevation,
  });

  /// Creates a small chip.
  const ZoniChip.small({
    required this.label,
    super.key,
    this.variant = ZoniChipVariant.filled,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onPressed,
    this.onSelected,
    this.selected = false,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.selectedColor,
    this.disabledColor,
    this.labelStyle,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.selectedShadowColor,
    this.showCheckmark,
    this.checkmarkColor,
    this.avatarBorder = const CircleBorder(),
    this.padding,
    this.visualDensity,
    this.labelPadding,
    this.pressElevation,
  }) : size = ZoniChipSize.small;

  /// Creates a large chip.
  const ZoniChip.large({
    required this.label,
    super.key,
    this.variant = ZoniChipVariant.filled,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onPressed,
    this.onSelected,
    this.selected = false,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.selectedColor,
    this.disabledColor,
    this.labelStyle,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.selectedShadowColor,
    this.showCheckmark,
    this.checkmarkColor,
    this.avatarBorder = const CircleBorder(),
    this.padding,
    this.visualDensity,
    this.labelPadding,
    this.pressElevation,
  }) : size = ZoniChipSize.large;

  /// Creates an input chip.
  const ZoniChip.input({
    required this.label,
    super.key,
    this.size = ZoniChipSize.medium,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onPressed,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.disabledColor,
    this.labelStyle,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.avatarBorder = const CircleBorder(),
    this.padding,
    this.visualDensity,
    this.labelPadding,
    this.pressElevation,
  })  : variant = ZoniChipVariant.input,
        onSelected = null,
        selected = false,
        selectedColor = null,
        selectedShadowColor = null,
        showCheckmark = null,
        checkmarkColor = null;

  /// Creates a choice chip.
  const ZoniChip.choice({
    required this.label,
    super.key,
    this.size = ZoniChipSize.medium,
    this.avatar,
    this.onSelected,
    this.selected = false,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.selectedColor,
    this.disabledColor,
    this.labelStyle,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.selectedShadowColor,
    this.avatarBorder = const CircleBorder(),
    this.padding,
    this.visualDensity,
    this.labelPadding,
    this.pressElevation,
  })  : variant = ZoniChipVariant.choice,
        deleteIcon = null,
        onDeleted = null,
        onPressed = null,
        showCheckmark = null,
        checkmarkColor = null;

  /// Creates a filter chip.
  const ZoniChip.filter({
    required this.label,
    super.key,
    this.size = ZoniChipSize.medium,
    this.avatar,
    this.onSelected,
    this.selected = false,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.selectedColor,
    this.disabledColor,
    this.labelStyle,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.selectedShadowColor,
    this.showCheckmark,
    this.checkmarkColor,
    this.avatarBorder = const CircleBorder(),
    this.padding,
    this.visualDensity,
    this.labelPadding,
    this.pressElevation,
  })  : variant = ZoniChipVariant.filter,
        deleteIcon = null,
        onDeleted = null,
        onPressed = null;

  /// Creates an action chip.
  const ZoniChip.action({
    required this.label,
    super.key,
    this.size = ZoniChipSize.medium,
    this.avatar,
    this.onPressed,
    this.enabled = true,
    this.tooltip,
    this.backgroundColor,
    this.disabledColor,
    this.labelStyle,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.iconTheme,
    this.avatarBorder = const CircleBorder(),
    this.padding,
    this.visualDensity,
    this.labelPadding,
    this.pressElevation,
  })  : variant = ZoniChipVariant.action,
        deleteIcon = null,
        onDeleted = null,
        onSelected = null,
        selected = false,
        selectedColor = null,
        selectedShadowColor = null,
        showCheckmark = null,
        checkmarkColor = null;

  /// The text to display in the chip.
  final Widget label;

  /// The chip variant.
  final ZoniChipVariant variant;

  /// The chip size.
  final ZoniChipSize size;

  /// Optional avatar to display.
  final Widget? avatar;

  /// Optional delete icon.
  final Widget? deleteIcon;

  /// Callback when the delete button is pressed.
  final VoidCallback? onDeleted;

  /// Callback when the chip is pressed.
  final VoidCallback? onPressed;

  /// Callback when the chip selection changes.
  final ValueChanged<bool>? onSelected;

  /// Whether the chip is selected.
  final bool selected;

  /// Whether the chip is enabled.
  final bool enabled;

  /// Tooltip text.
  final String? tooltip;

  /// Background color.
  final Color? backgroundColor;

  /// Selected color.
  final Color? selectedColor;

  /// Disabled color.
  final Color? disabledColor;

  /// Label text style.
  final TextStyle? labelStyle;

  /// Border side.
  final BorderSide? side;

  /// Shape.
  final OutlinedBorder? shape;

  /// Clip behavior.
  final Clip clipBehavior;

  /// Focus node.
  final FocusNode? focusNode;

  /// Auto focus.
  final bool autofocus;

  /// Material tap target size.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Elevation.
  final double? elevation;

  /// Shadow color.
  final Color? shadowColor;

  /// Surface tint color.
  final Color? surfaceTintColor;

  /// Icon theme.
  final IconThemeData? iconTheme;

  /// Selected shadow color.
  final Color? selectedShadowColor;

  /// Whether to show checkmark.
  final bool? showCheckmark;

  /// Checkmark color.
  final Color? checkmarkColor;

  /// Avatar border.
  final ShapeBorder avatarBorder;

  /// Padding.
  final EdgeInsetsGeometry? padding;

  /// Visual density.
  final VisualDensity? visualDensity;

  /// Label padding.
  final EdgeInsetsGeometry? labelPadding;

  /// Press elevation.
  final double? pressElevation;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveLabelStyle = _getEffectiveLabelStyle();
    final EdgeInsetsGeometry effectivePadding = _getEffectivePadding();

    Widget chip;

    switch (variant) {
      case ZoniChipVariant.filled:
      case ZoniChipVariant.outlined:
        chip = RawChip(
          label: label,
          avatar: avatar,
          deleteIcon: deleteIcon,
          onDeleted: onDeleted,
          onPressed: onPressed,
          onSelected: onSelected,
          selected: selected,
          isEnabled: enabled,
          tooltip: tooltip,
          backgroundColor: backgroundColor ?? _getBackgroundColor(),
          selectedColor: selectedColor ?? _getSelectedColor(),
          disabledColor: disabledColor,
          labelStyle: effectiveLabelStyle,
          side: side ?? _getSide(),
          shape: shape ?? _getShape(),
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          elevation: elevation ?? _getElevation(),
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          iconTheme: iconTheme,
          selectedShadowColor: selectedShadowColor,
          showCheckmark: showCheckmark,
          checkmarkColor: checkmarkColor,
          avatarBorder: avatarBorder,
          padding: effectivePadding,
          visualDensity: visualDensity,
          labelPadding: labelPadding,
          pressElevation: pressElevation,
        );
        break;
      case ZoniChipVariant.input:
        chip = InputChip(
          label: label,
          avatar: avatar,
          deleteIcon: deleteIcon,
          onDeleted: onDeleted,
          onPressed: onPressed,
          isEnabled: enabled,
          tooltip: tooltip,
          backgroundColor: backgroundColor ?? _getBackgroundColor(),
          disabledColor: disabledColor,
          labelStyle: effectiveLabelStyle,
          side: side ?? _getSide(),
          shape: shape ?? _getShape(),
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          elevation: elevation ?? _getElevation(),
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          iconTheme: iconTheme,
          avatarBorder: avatarBorder,
          padding: effectivePadding,
          visualDensity: visualDensity,
          labelPadding: labelPadding,
          pressElevation: pressElevation,
        );
        break;
      case ZoniChipVariant.choice:
        chip = ChoiceChip(
          label: label,
          avatar: avatar,
          selected: selected,
          onSelected: onSelected,
          tooltip: tooltip,
          backgroundColor: backgroundColor ?? _getBackgroundColor(),
          selectedColor: selectedColor ?? _getSelectedColor(),
          disabledColor: disabledColor,
          labelStyle: effectiveLabelStyle,
          side: side ?? _getSide(),
          shape: shape ?? _getShape(),
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          elevation: elevation ?? _getElevation(),
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          iconTheme: iconTheme,
          selectedShadowColor: selectedShadowColor,
          avatarBorder: avatarBorder,
          padding: effectivePadding,
          visualDensity: visualDensity,
          labelPadding: labelPadding,
          pressElevation: pressElevation,
        );
        break;
      case ZoniChipVariant.filter:
        chip = FilterChip(
          label: label,
          avatar: avatar,
          selected: selected,
          onSelected: onSelected,
          tooltip: tooltip,
          backgroundColor: backgroundColor ?? _getBackgroundColor(),
          selectedColor: selectedColor ?? _getSelectedColor(),
          disabledColor: disabledColor,
          labelStyle: effectiveLabelStyle,
          side: side ?? _getSide(),
          shape: shape ?? _getShape(),
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          elevation: elevation ?? _getElevation(),
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          iconTheme: iconTheme,
          selectedShadowColor: selectedShadowColor,
          showCheckmark: showCheckmark,
          checkmarkColor: checkmarkColor,
          avatarBorder: avatarBorder,
          padding: effectivePadding,
          visualDensity: visualDensity,
          labelPadding: labelPadding,
          pressElevation: pressElevation,
        );
        break;
      case ZoniChipVariant.action:
        chip = ActionChip(
          label: label,
          avatar: avatar,
          onPressed: onPressed,
          tooltip: tooltip,
          backgroundColor: backgroundColor ?? _getBackgroundColor(),
          disabledColor: disabledColor,
          labelStyle: effectiveLabelStyle,
          side: side ?? _getSide(),
          shape: shape ?? _getShape(),
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          elevation: elevation ?? _getElevation(),
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          iconTheme: iconTheme,
          padding: effectivePadding,
          visualDensity: visualDensity,
          labelPadding: labelPadding,
          pressElevation: pressElevation,
        );
        break;
    }

    return chip;
  }

  TextStyle _getEffectiveLabelStyle() {
    final TextStyle baseStyle = switch (size) {
      ZoniChipSize.small => ZoniTextStyles.labelSmall,
      ZoniChipSize.medium => ZoniTextStyles.labelMedium,
      ZoniChipSize.large => ZoniTextStyles.labelLarge,
    };

    return labelStyle ?? baseStyle;
  }

  EdgeInsetsGeometry _getEffectivePadding() {
    if (padding != null) return padding!;

    return switch (size) {
      ZoniChipSize.small =>
        const EdgeInsets.symmetric(horizontal: ZoniSpacing.xs),
      ZoniChipSize.medium =>
        const EdgeInsets.symmetric(horizontal: ZoniSpacing.sm),
      ZoniChipSize.large =>
        const EdgeInsets.symmetric(horizontal: ZoniSpacing.md),
    };
  }

  Color _getBackgroundColor() => switch (variant) {
        ZoniChipVariant.filled => ZoniColors.primary,
        ZoniChipVariant.outlined => Colors.transparent,
        ZoniChipVariant.input => ZoniColors.surface,
        ZoniChipVariant.choice => ZoniColors.surface,
        ZoniChipVariant.filter => ZoniColors.surface,
        ZoniChipVariant.action => ZoniColors.surface,
      };

  Color _getSelectedColor() => ZoniColors.primary;

  BorderSide _getSide() => switch (variant) {
        ZoniChipVariant.filled => BorderSide.none,
        ZoniChipVariant.outlined => const BorderSide(color: ZoniColors.outline),
        ZoniChipVariant.input => const BorderSide(color: ZoniColors.outline),
        ZoniChipVariant.choice => const BorderSide(color: ZoniColors.outline),
        ZoniChipVariant.filter => const BorderSide(color: ZoniColors.outline),
        ZoniChipVariant.action => const BorderSide(color: ZoniColors.outline),
      };

  OutlinedBorder _getShape() {
    final double radius = switch (size) {
      ZoniChipSize.small => ZoniSpacing.sm,
      ZoniChipSize.medium => ZoniSpacing.md,
      ZoniChipSize.large => ZoniSpacing.lg,
    };

    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  double _getElevation() => switch (variant) {
        ZoniChipVariant.filled => ZoniElevation.xs,
        ZoniChipVariant.outlined => 0,
        ZoniChipVariant.input => ZoniElevation.xs,
        ZoniChipVariant.choice => 0,
        ZoniChipVariant.filter => 0,
        ZoniChipVariant.action => ZoniElevation.xs,
      };

}
