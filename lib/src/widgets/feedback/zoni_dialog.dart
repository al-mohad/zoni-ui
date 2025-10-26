import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';
import '../buttons/zoni_button.dart';

/// A dialog widget that follows Zoni design system principles.
class ZoniDialog extends StatelessWidget {
  /// Creates a ZoniDialog.
  const ZoniDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.insetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.scrollable = false,
    this.semanticLabel,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.titlePadding,
    this.contentPadding,
    this.titleTextStyle,
    this.contentTextStyle,
    this.icon,
    this.iconPadding,
    this.iconColor,
  });

  /// The (optional) title of the dialog is displayed in a large font at the top of the dialog.
  final Widget? title;

  /// The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.
  final Widget? content;

  /// The (optional) set of actions that are displayed at the bottom of the dialog.
  final List<Widget>? actions;

  /// The background color of the surface of this Dialog.
  final Color? backgroundColor;

  /// The z-coordinate of this Dialog.
  final double? elevation;

  /// The color of the shadow below the dialog.
  final Color? shadowColor;

  /// The color used as an overlay on backgroundColor to indicate elevation.
  final Color? surfaceTintColor;

  /// The amount of padding added to MediaQueryData.viewInsets on the outside of the dialog.
  final EdgeInsets? insetPadding;

  /// Controls how the contents of the dialog are clipped (or not) to the given shape.
  final Clip clipBehavior;

  /// The shape of this dialog's border.
  final ShapeBorder? shape;

  /// How to align the Dialog.
  final AlignmentGeometry? alignment;

  /// Determines whether the title and content widgets are wrapped in a scrollable.
  final bool scrollable;

  /// The semantic label of the dialog used by accessibility frameworks.
  final String? semanticLabel;

  /// The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is placed in.
  final Curve insetAnimationCurve;

  /// Padding around the set of actions at the bottom of the dialog.
  final EdgeInsetsGeometry? actionsPadding;

  /// Defines the horizontal layout of the actions.
  final MainAxisAlignment? actionsAlignment;

  /// The horizontal alignment of actions within the vertical "overflow" layout.
  final OverflowBarAlignment? actionsOverflowAlignment;

  /// The vertical direction of actions if the children overflow horizontally.
  final VerticalDirection? actionsOverflowDirection;

  /// The spacing between actions when the overflow layout is used.
  final double? actionsOverflowButtonSpacing;

  /// The padding that surrounds each button in actions.
  final EdgeInsetsGeometry? buttonPadding;

  /// Padding around the title.
  final EdgeInsetsGeometry? titlePadding;

  /// Padding around the content.
  final EdgeInsetsGeometry? contentPadding;

  /// The style for the text in the title of this AlertDialog.
  final TextStyle? titleTextStyle;

  /// The style for the text in the content of this AlertDialog.
  final TextStyle? contentTextStyle;

  /// An optional icon to display at the top of the dialog.
  final Widget? icon;

  /// Padding around the icon.
  final EdgeInsetsGeometry? iconPadding;

  /// Color for the Icon in the icon of this AlertDialog.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      backgroundColor: backgroundColor ?? ZoniColors.surface,
      elevation: elevation ?? ZoniElevation.lg,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      insetPadding: insetPadding ??
          const EdgeInsets.symmetric(
            horizontal: ZoniSpacing.xl,
            vertical: ZoniSpacing.xxl,
          ),
      clipBehavior: clipBehavior,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ZoniBorderRadius.lg)),
          ),
      alignment: alignment,
      scrollable: scrollable,
      semanticLabel: semanticLabel,
      actionsPadding: actionsPadding ?? const EdgeInsets.all(ZoniSpacing.md),
      actionsAlignment: actionsAlignment,
      actionsOverflowAlignment: actionsOverflowAlignment,
      actionsOverflowDirection: actionsOverflowDirection,
      actionsOverflowButtonSpacing: actionsOverflowButtonSpacing,
      buttonPadding: buttonPadding,
      titlePadding: titlePadding ?? const EdgeInsets.all(ZoniSpacing.lg),
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: ZoniSpacing.lg,
            vertical: ZoniSpacing.md,
          ),
      titleTextStyle: titleTextStyle ?? ZoniTextStyles.headlineSmall,
      contentTextStyle: contentTextStyle ?? ZoniTextStyles.bodyMedium,
      icon: icon,
      iconPadding: iconPadding,
      iconColor: iconColor,
    );
  }
}

/// Utility class for showing ZoniDialogs.
class ZoniDialogHelper {
  /// Shows a confirmation dialog.
  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDangerous = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ZoniDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ZoniButton.text(
              onPressed: () {
                Navigator.of(context).pop(false);
                onCancel?.call();
              },
              child: Text(cancelText),
            ),
            ZoniButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirm?.call();
              },
              variant: isDangerous
                  ? ZoniButtonVariant.danger
                  : ZoniButtonVariant.primary,
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  /// Shows an information dialog.
  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ZoniDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ZoniButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed?.call();
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  /// Shows an error dialog.
  static Future<void> showError(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ZoniDialog(
          icon: const Icon(
            Icons.error_outline,
            size: 48,
          ),
          iconColor: ZoniColors.error,
          title: Text(title),
          content: Text(message),
          actions: [
            ZoniButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed?.call();
              },
              variant: ZoniButtonVariant.danger,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  /// Shows a success dialog.
  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ZoniDialog(
          icon: const Icon(
            Icons.check_circle_outline,
            size: 48,
          ),
          iconColor: ZoniColors.success,
          title: Text(title),
          content: Text(message),
          actions: [
            ZoniButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed?.call();
              },
              variant: ZoniButtonVariant.success,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  /// Shows a custom dialog.
  static Future<T?> show<T>(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      builder: (BuildContext context) {
        return ZoniDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }
}
