import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';

/// Enum for modal sizes
enum ZoniModalSize {
  small,
  medium,
  large,
  fullscreen,
}

/// Enum for modal animations
enum ZoniModalAnimation {
  fade,
  slide,
  scale,
  none,
}

/// Enum for modal positions (for slide animation)
enum ZoniModalPosition {
  center,
  top,
  bottom,
  left,
  right,
}

/// A customizable modal dialog widget following Zoni design system
class ZoniModal extends StatelessWidget {
  /// Creates a ZoniModal
  const ZoniModal({
    super.key,
    required this.child,
    this.title,
    this.titleStyle,
    this.titlePadding,
    this.contentPadding,
    this.actionsPadding,
    this.actions,
    this.size = ZoniModalSize.medium,
    this.animation = ZoniModalAnimation.fade,
    this.position = ZoniModalPosition.center,
    this.backgroundColor,
    this.barrierColor,
    this.barrierDismissible = true,
    this.showCloseButton = true,
    this.closeButtonIcon = Icons.close,
    this.onClose,
    this.borderRadius,
    this.elevation,
    this.constraints,
    this.duration,
    this.curve,
  });

  /// The content of the modal
  final Widget child;

  /// Optional title widget
  final Widget? title;

  /// Style for the title text
  final TextStyle? titleStyle;

  /// Padding around the title
  final EdgeInsetsGeometry? titlePadding;

  /// Padding around the content
  final EdgeInsetsGeometry? contentPadding;

  /// Padding around the actions
  final EdgeInsetsGeometry? actionsPadding;

  /// Optional action buttons
  final List<Widget>? actions;

  /// Size of the modal
  final ZoniModalSize size;

  /// Animation type
  final ZoniModalAnimation animation;

  /// Position for slide animation
  final ZoniModalPosition position;

  /// Background color of the modal
  final Color? backgroundColor;

  /// Color of the barrier behind the modal
  final Color? barrierColor;

  /// Whether the modal can be dismissed by tapping the barrier
  final bool barrierDismissible;

  /// Whether to show the close button
  final bool showCloseButton;

  /// Icon for the close button
  final IconData closeButtonIcon;

  /// Callback when the modal is closed
  final VoidCallback? onClose;

  /// Border radius of the modal
  final BorderRadius? borderRadius;

  /// Elevation of the modal
  final double? elevation;

  /// Custom constraints for the modal
  final BoxConstraints? constraints;

  /// Animation duration
  final Duration? duration;

  /// Animation curve
  final Curve? curve;

  /// Shows the modal
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    Widget? title,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? actionsPadding,
    List<Widget>? actions,
    ZoniModalSize size = ZoniModalSize.medium,
    ZoniModalAnimation animation = ZoniModalAnimation.fade,
    ZoniModalPosition position = ZoniModalPosition.center,
    Color? backgroundColor,
    Color? barrierColor,
    bool barrierDismissible = true,
    bool showCloseButton = true,
    IconData closeButtonIcon = Icons.close,
    VoidCallback? onClose,
    BorderRadius? borderRadius,
    double? elevation,
    BoxConstraints? constraints,
    Duration? duration,
    Curve? curve,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black54,
      transitionDuration: duration ?? const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animationController,
          Animation<double> secondaryAnimation) {
        return ZoniModal(
          title: title,
          titleStyle: titleStyle,
          titlePadding: titlePadding,
          contentPadding: contentPadding,
          actionsPadding: actionsPadding,
          actions: actions,
          size: size,
          animation: animation,
          position: position,
          backgroundColor: backgroundColor,
          barrierColor: barrierColor,
          barrierDismissible: barrierDismissible,
          showCloseButton: showCloseButton,
          closeButtonIcon: closeButtonIcon,
          onClose: onClose,
          borderRadius: borderRadius,
          elevation: elevation,
          constraints: constraints,
          duration: duration,
          curve: curve,
          child: child,
        );
      },
      transitionBuilder: (BuildContext context,
          Animation<double> animationController,
          Animation<double> secondaryAnimation,
          Widget child) {
        return _buildTransition(
          animationController: animationController,
          animation: animation,
          position: position,
          curve: curve ?? Curves.easeInOut,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ZoniModalConstraints modalConstraints = _getConstraints();

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: constraints ??
              BoxConstraints(
                maxWidth: modalConstraints.maxWidth,
                maxHeight: modalConstraints.maxHeight,
                minWidth: modalConstraints.minWidth,
                minHeight: modalConstraints.minHeight,
              ),
          margin: const EdgeInsets.all(ZoniSpacing.lg),
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.dialogBackgroundColor,
            borderRadius:
                borderRadius ?? BorderRadius.circular(ZoniBorderRadius.lg),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: elevation ?? 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null || showCloseButton) _buildTitleSection(theme),
              Flexible(
                child: Container(
                  padding:
                      contentPadding ?? const EdgeInsets.all(ZoniSpacing.lg),
                  child: child,
                ),
              ),
              if (actions != null && actions!.isNotEmpty)
                _buildActionsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(ThemeData theme) => Builder(
        builder: (BuildContext context) => Container(
          padding: titlePadding ?? const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Row(
            children: <Widget>[
              if (title != null)
                Expanded(
                  child: DefaultTextStyle(
                    style: titleStyle ?? theme.textTheme.headlineSmall!,
                    child: title!,
                  ),
                ),
              if (showCloseButton)
                IconButton(
                  icon: Icon(closeButtonIcon),
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                  tooltip: 'Close',
                ),
            ],
          ),
        ),
      );

  Widget _buildActionsSection() {
    return Container(
      padding: actionsPadding ?? const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!
            .map((Widget action) => Padding(
                  padding: const EdgeInsets.only(left: ZoniSpacing.sm),
                  child: action,
                ))
            .toList(),
      ),
    );
  }

  ZoniModalConstraints _getConstraints() {
    switch (size) {
      case ZoniModalSize.small:
        return const ZoniModalConstraints(
          maxWidth: 400,
          maxHeight: 300,
          minWidth: 300,
          minHeight: 200,
        );
      case ZoniModalSize.medium:
        return const ZoniModalConstraints(
          maxWidth: 600,
          maxHeight: 500,
          minWidth: 400,
          minHeight: 300,
        );
      case ZoniModalSize.large:
        return const ZoniModalConstraints(
          maxWidth: 800,
          maxHeight: 700,
          minWidth: 600,
          minHeight: 400,
        );
      case ZoniModalSize.fullscreen:
        return const ZoniModalConstraints(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          minWidth: 0,
          minHeight: 0,
        );
    }
  }

  static Widget _buildTransition({
    required Animation<double> animationController,
    required ZoniModalAnimation animation,
    required ZoniModalPosition position,
    required Curve curve,
    required Widget child,
  }) {
    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: curve,
    );

    switch (animation) {
      case ZoniModalAnimation.fade:
        return FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );
      case ZoniModalAnimation.scale:
        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      case ZoniModalAnimation.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: _getSlideOffset(position),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
      case ZoniModalAnimation.none:
        return child;
    }
  }

  static Offset _getSlideOffset(ZoniModalPosition position) {
    switch (position) {
      case ZoniModalPosition.center:
        return const Offset(0, -1);
      case ZoniModalPosition.top:
        return const Offset(0, -1);
      case ZoniModalPosition.bottom:
        return const Offset(0, 1);
      case ZoniModalPosition.left:
        return const Offset(-1, 0);
      case ZoniModalPosition.right:
        return const Offset(1, 0);
    }
  }

  /// Named constructors for common modal types
  static Future<T?> alert<T>({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    return show<T>(
      context: context,
      title: Text(title),
      size: ZoniModalSize.small,
      child: Text(message),
      actions: [
        TextButton(
          onPressed: onConfirm ?? () => Navigator.of(context).pop(),
          child: Text(confirmText),
        ),
      ],
    );
  }

  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return show<bool>(
      context: context,
      title: Text(title),
      size: ZoniModalSize.small,
      child: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop(false);
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}

/// Constraints for modal sizing
class ZoniModalConstraints {
  const ZoniModalConstraints({
    required this.maxWidth,
    required this.maxHeight,
    required this.minWidth,
    required this.minHeight,
  });

  final double maxWidth;
  final double maxHeight;
  final double minWidth;
  final double minHeight;
}

/// Extension for easy modal access
extension ZoniModalExtension on BuildContext {
  Future<T?> showZoniModal<T>({
    required Widget child,
    Widget? title,
    ZoniModalSize size = ZoniModalSize.medium,
    ZoniModalAnimation animation = ZoniModalAnimation.fade,
    List<Widget>? actions,
  }) {
    return ZoniModal.show<T>(
      context: this,
      child: child,
      title: title,
      size: size,
      animation: animation,
      actions: actions,
    );
  }

  Future<T?> showZoniAlert<T>({
    required String title,
    required String message,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
  }) {
    return ZoniModal.alert<T>(
      context: this,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
    );
  }

  Future<bool?> showZoniConfirm({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return ZoniModal.confirm(
      context: this,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }
}

/// Custom modal with specific constraints
class ZoniCustomModal extends ZoniModal {
  const ZoniCustomModal({
    super.key,
    required super.child,
    super.title,
    super.actions,
    this.width,
    this.height,
    BoxConstraints? constraints,
  })  : constraints = constraints ?? const BoxConstraints(),
        super(
          constraints: constraints ?? const BoxConstraints(),
        );

  final double? width;
  final double? height;
  final BoxConstraints constraints;
}
