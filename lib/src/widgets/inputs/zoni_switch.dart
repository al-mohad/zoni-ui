import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../theme/zoni_colors.dart';

/// Enum for switch sizes
enum ZoniSwitchSize {
  small,
  medium,
  large,
}

/// Enum for switch variants
enum ZoniSwitchVariant {
  primary,
  secondary,
  success,
  warning,
  error,
}

/// A customizable switch component following Zoni design system.
///
/// The [ZoniSwitch] widget provides a switch with consistent styling
/// and behavior across the application. It supports different sizes,
/// variants, and states.
///
/// Example usage:
/// ```dart
/// ZoniSwitch(
///   value: isEnabled,
///   onChanged: (value) => setState(() => isEnabled = value),
///   title: Text('Enable notifications'),
/// )
/// ```
class ZoniSwitch extends StatelessWidget {
  /// Creates a Zoni switch.
  const ZoniSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.title,
    this.subtitle,
    this.size = ZoniSwitchSize.medium,
    this.variant = ZoniSwitchVariant.primary,
    this.isEnabled = true,
    this.autofocus = false,
    this.focusNode,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.thumbColor,
    this.trackColor,
    this.trackOutlineColor,
    this.thumbIcon,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
  });

  /// Whether this switch is on or off.
  final bool value;

  /// Called when the user toggles the switch on or off.
  final ValueChanged<bool>? onChanged;

  /// The primary content of the switch.
  final Widget? title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// The size of the switch.
  final ZoniSwitchSize size;

  /// The visual variant of the switch.
  final ZoniSwitchVariant variant;

  /// Whether the switch is enabled.
  final bool isEnabled;

  /// Whether this switch should focus itself if nothing else is already focused.
  final bool autofocus;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// The color to use when this switch is on.
  final Color? activeColor;

  /// The color to use on the track when this switch is on.
  final Color? activeTrackColor;

  /// The color to use on the thumb when this switch is off.
  final Color? inactiveThumbColor;

  /// The color to use on the track when this switch is off.
  final Color? inactiveTrackColor;

  /// An image to use on the thumb of this switch when the switch is on.
  final ImageProvider? activeThumbImage;

  /// An image to use on the thumb of this switch when the switch is off.
  final ImageProvider? inactiveThumbImage;

  /// The color of this switch's thumb.
  final WidgetStateProperty<Color?>? thumbColor;

  /// The color of this switch's track.
  final WidgetStateProperty<Color?>? trackColor;

  /// The outline color of this switch's track.
  final WidgetStateProperty<Color?>? trackOutlineColor;

  /// The icon to use on the thumb of this switch.
  final WidgetStateProperty<Icon?>? thumbIcon;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Determines the way that drag start behavior is handled.
  final DragStartBehavior dragStartBehavior;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// The color for the switch's focus state.
  final Color? focusColor;

  /// The color for the switch's hover state.
  final Color? hoverColor;

  /// The color for the switch's overlay.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The splash radius of the circular Material ink response.
  final double? splashRadius;

  @override
  Widget build(BuildContext context) {
    final Color effectiveActiveColor = activeColor ?? _getActiveColor();
    final Color effectiveActiveTrackColor =
        activeTrackColor ?? _getActiveTrackColor();
    final Color effectiveInactiveThumbColor =
        inactiveThumbColor ?? _getInactiveThumbColor();
    final Color effectiveInactiveTrackColor =
        inactiveTrackColor ?? _getInactiveTrackColor();
    final WidgetStateProperty<Color?> effectiveThumbColor =
        thumbColor ?? _getThumbColor();
    final WidgetStateProperty<Color?> effectiveTrackColor =
        trackColor ?? _getTrackColor();
    final WidgetStateProperty<Color?> effectiveOverlayColor =
        overlayColor ?? _getOverlayColor();

    final Transform switchWidget = Transform.scale(
      scale: _getScale(),
      child: Switch(
        value: value,
        onChanged: isEnabled ? onChanged : null,
        autofocus: autofocus,
        focusNode: focusNode,
        activeThumbColor: effectiveActiveColor,
        activeTrackColor: effectiveActiveTrackColor,
        inactiveThumbColor: effectiveInactiveThumbColor,
        inactiveTrackColor: effectiveInactiveTrackColor,
        activeThumbImage: activeThumbImage,
        inactiveThumbImage: inactiveThumbImage,
        thumbColor: effectiveThumbColor,
        trackColor: effectiveTrackColor,
        trackOutlineColor: trackOutlineColor,
        thumbIcon: thumbIcon,
        materialTapTargetSize: materialTapTargetSize,
        dragStartBehavior: dragStartBehavior,
        mouseCursor: mouseCursor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        overlayColor: effectiveOverlayColor,
        splashRadius: splashRadius ?? _getSplashRadius(),
      ),
    );

    if (title == null && subtitle == null) {
      return switchWidget;
    }

    return SwitchListTile(
      value: value,
      onChanged: isEnabled ? onChanged : null,
      title: title,
      subtitle: subtitle,
      autofocus: autofocus,
      focusNode: focusNode,
      activeThumbColor: effectiveActiveColor,
      activeTrackColor: effectiveActiveTrackColor,
      inactiveThumbColor: effectiveInactiveThumbColor,
      inactiveTrackColor: effectiveInactiveTrackColor,
      activeThumbImage: activeThumbImage,
      inactiveThumbImage: inactiveThumbImage,
      thumbColor: effectiveThumbColor,
      trackColor: effectiveTrackColor,
      trackOutlineColor: trackOutlineColor,
      thumbIcon: thumbIcon,
      materialTapTargetSize: materialTapTargetSize,
      dragStartBehavior: dragStartBehavior,
      mouseCursor: mouseCursor,
      hoverColor: hoverColor,
      overlayColor: effectiveOverlayColor,
      splashRadius: splashRadius ?? _getSplashRadius(),
      dense: size == ZoniSwitchSize.small,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }

  Color _getActiveColor() {
    switch (variant) {
      case ZoniSwitchVariant.primary:
        return ZoniColors.primary;
      case ZoniSwitchVariant.secondary:
        return ZoniColors.secondary;
      case ZoniSwitchVariant.success:
        return ZoniColors.success;
      case ZoniSwitchVariant.warning:
        return ZoniColors.warning;
      case ZoniSwitchVariant.error:
        return ZoniColors.error;
    }
  }

  Color _getActiveTrackColor() => _getActiveColor().withOpacity(0.5);

  Color _getInactiveThumbColor() => ZoniColors.onSurface.withOpacity(0.38);

  Color _getInactiveTrackColor() => ZoniColors.onSurface.withOpacity(0.12);

  WidgetStateProperty<Color?> _getThumbColor() {
    final Color activeColor = _getActiveColor();
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return ZoniColors.onSurface.withOpacity(0.38);
      }
      if (states.contains(WidgetState.selected)) {
        return activeColor;
      }
      return ZoniColors.onSurface;
    });
  }

  WidgetStateProperty<Color?> _getTrackColor() {
    final Color activeColor = _getActiveColor();
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return ZoniColors.onSurface.withOpacity(0.12);
      }
      if (states.contains(WidgetState.selected)) {
        return activeColor.withOpacity(0.5);
      }
      return ZoniColors.onSurface.withOpacity(0.38);
    });
  }

  WidgetStateProperty<Color?> _getOverlayColor() {
    final Color activeColor = _getActiveColor();
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return activeColor.withOpacity(0.12);
      }
      if (states.contains(WidgetState.hovered)) {
        return activeColor.withOpacity(0.08);
      }
      if (states.contains(WidgetState.focused)) {
        return activeColor.withOpacity(0.12);
      }
      return null;
    });
  }

  double _getScale() {
    switch (size) {
      case ZoniSwitchSize.small:
        return 0.8;
      case ZoniSwitchSize.medium:
        return 1;
      case ZoniSwitchSize.large:
        return 1.2;
    }
  }

  double _getSplashRadius() {
    switch (size) {
      case ZoniSwitchSize.small:
        return 16;
      case ZoniSwitchSize.medium:
        return 20;
      case ZoniSwitchSize.large:
        return 24;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('value', value));
    properties.add(
      ObjectFlagProperty<ValueChanged<bool>?>.has('onChanged', onChanged),
    );
    properties.add(EnumProperty<ZoniSwitchSize>('size', size));
    properties.add(EnumProperty<ZoniSwitchVariant>('variant', variant));
    properties.add(DiagnosticsProperty<bool>('isEnabled', isEnabled));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus));
    properties.add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode));
    properties.add(ColorProperty('activeColor', activeColor));
    properties.add(ColorProperty('activeTrackColor', activeTrackColor));
    properties.add(ColorProperty('inactiveThumbColor', inactiveThumbColor));
    properties.add(ColorProperty('inactiveTrackColor', inactiveTrackColor));
    properties.add(
      DiagnosticsProperty<ImageProvider<Object>?>(
        'activeThumbImage',
        activeThumbImage,
      ),
    );
    properties.add(
      DiagnosticsProperty<ImageProvider<Object>?>(
        'inactiveThumbImage',
        inactiveThumbImage,
      ),
    );
    properties.add(
      DiagnosticsProperty<WidgetStateProperty<Color?>?>(
        'thumbColor',
        thumbColor,
      ),
    );
    properties.add(
      DiagnosticsProperty<WidgetStateProperty<Color?>?>(
        'trackColor',
        trackColor,
      ),
    );
    properties.add(
      DiagnosticsProperty<WidgetStateProperty<Color?>?>(
        'trackOutlineColor',
        trackOutlineColor,
      ),
    );
    properties.add(
      DiagnosticsProperty<WidgetStateProperty<Icon?>?>(
        'thumbIcon',
        thumbIcon,
      ),
    );
    properties.add(
      EnumProperty<MaterialTapTargetSize?>(
        'materialTapTargetSize',
        materialTapTargetSize,
      ),
    );
    properties.add(
      EnumProperty<DragStartBehavior>(
        'dragStartBehavior',
        dragStartBehavior,
      ),
    );
    properties
        .add(DiagnosticsProperty<MouseCursor?>('mouseCursor', mouseCursor));
    properties.add(ColorProperty('focusColor', focusColor));
    properties.add(ColorProperty('hoverColor', hoverColor));
    properties.add(
      DiagnosticsProperty<WidgetStateProperty<Color?>?>(
        'overlayColor',
        overlayColor,
      ),
    );
    properties.add(DoubleProperty('splashRadius', splashRadius));
  }
}
