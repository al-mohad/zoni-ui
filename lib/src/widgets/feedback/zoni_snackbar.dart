import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';
import '../../constants/zoni_constants.dart';

/// A snackbar widget that follows Zoni design system principles.
class ZoniSnackBar extends SnackBar {
  /// Creates a ZoniSnackBar.
  ZoniSnackBar({
    super.key,
    required Widget content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    HitTestBehavior? hitTestBehavior,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    double? actionOverflowThreshold,
    bool? showCloseIcon,
    Color? closeIconColor,
    Duration duration = const Duration(milliseconds: 4000),
    Animation<double>? animation,
    VoidCallback? onVisible,
    DismissDirection dismissDirection = DismissDirection.down,
    Clip clipBehavior = Clip.hardEdge,
  }) : super(
          content: content,
          backgroundColor: backgroundColor ?? ZoniColors.surface,
          elevation: elevation ?? ZoniElevation.md,
          margin: margin,
          padding: padding ?? const EdgeInsets.all(ZoniSpacing.md),
          width: width,
          shape: shape ??
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(ZoniBorderRadius.sm)),
              ),
          hitTestBehavior: hitTestBehavior,
          behavior: behavior ?? SnackBarBehavior.floating,
          action: action,
          actionOverflowThreshold: actionOverflowThreshold,
          showCloseIcon: showCloseIcon,
          closeIconColor: closeIconColor,
          duration: duration,
          animation: animation,
          onVisible: onVisible,
          dismissDirection: dismissDirection,
          clipBehavior: clipBehavior,
        );

  /// Creates a success ZoniSnackBar.
  ZoniSnackBar.success({
    super.key,
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 4000),
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) : super(
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: ZoniColors.onSuccess,
                size: 20,
              ),
              const SizedBox(width: ZoniSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: ZoniTextStyles.bodyMedium.copyWith(
                    color: ZoniColors.onSuccess,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: ZoniColors.success,
          elevation: ZoniElevation.md,
          padding: const EdgeInsets.all(ZoniSpacing.md),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(ZoniBorderRadius.sm)),
          ),
          behavior: SnackBarBehavior.floating,
          action: action,
          showCloseIcon: showCloseIcon,
          closeIconColor: ZoniColors.onSuccess,
          duration: duration,
          onVisible: onVisible,
        );

  /// Creates an error ZoniSnackBar.
  ZoniSnackBar.error({
    super.key,
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 6000),
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) : super(
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: ZoniColors.onError,
                size: 20,
              ),
              const SizedBox(width: ZoniSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: ZoniTextStyles.bodyMedium.copyWith(
                    color: ZoniColors.onError,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: ZoniColors.error,
          elevation: ZoniElevation.md,
          padding: const EdgeInsets.all(ZoniSpacing.md),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(ZoniBorderRadius.sm)),
          ),
          behavior: SnackBarBehavior.floating,
          action: action,
          showCloseIcon: showCloseIcon,
          closeIconColor: ZoniColors.onError,
          duration: duration,
          onVisible: onVisible,
        );

  /// Creates a warning ZoniSnackBar.
  ZoniSnackBar.warning({
    super.key,
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 5000),
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) : super(
          content: Row(
            children: [
              Icon(
                Icons.warning,
                color: ZoniColors.onWarning,
                size: 20,
              ),
              const SizedBox(width: ZoniSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: ZoniTextStyles.bodyMedium.copyWith(
                    color: ZoniColors.onWarning,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: ZoniColors.warning,
          elevation: ZoniElevation.md,
          padding: const EdgeInsets.all(ZoniSpacing.md),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(ZoniBorderRadius.sm)),
          ),
          behavior: SnackBarBehavior.floating,
          action: action,
          showCloseIcon: showCloseIcon,
          closeIconColor: ZoniColors.onWarning,
          duration: duration,
          onVisible: onVisible,
        );

  /// Creates an info ZoniSnackBar.
  ZoniSnackBar.info({
    super.key,
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(milliseconds: 4000),
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) : super(
          content: Row(
            children: [
              Icon(
                Icons.info,
                color: ZoniColors.onInfo,
                size: 20,
              ),
              const SizedBox(width: ZoniSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: ZoniTextStyles.bodyMedium.copyWith(
                    color: ZoniColors.onInfo,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: ZoniColors.info,
          elevation: ZoniElevation.md,
          padding: const EdgeInsets.all(ZoniSpacing.md),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(ZoniBorderRadius.sm)),
          ),
          behavior: SnackBarBehavior.floating,
          action: action,
          showCloseIcon: showCloseIcon,
          closeIconColor: ZoniColors.onInfo,
          duration: duration,
          onVisible: onVisible,
        );
}

/// Utility class for showing ZoniSnackBars.
class ZoniSnackBarHelper {
  /// Shows a success snackbar.
  static void showSuccess(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      ZoniSnackBar.success(
        message: message,
        action: action,
        duration: duration ?? const Duration(milliseconds: 4000),
        showCloseIcon: showCloseIcon,
        onVisible: onVisible,
      ),
    );
  }

  /// Shows an error snackbar.
  static void showError(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      ZoniSnackBar.error(
        message: message,
        action: action,
        duration: duration ?? const Duration(milliseconds: 6000),
        showCloseIcon: showCloseIcon,
        onVisible: onVisible,
      ),
    );
  }

  /// Shows a warning snackbar.
  static void showWarning(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      ZoniSnackBar.warning(
        message: message,
        action: action,
        duration: duration ?? const Duration(milliseconds: 5000),
        showCloseIcon: showCloseIcon,
        onVisible: onVisible,
      ),
    );
  }

  /// Shows an info snackbar.
  static void showInfo(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration? duration,
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      ZoniSnackBar.info(
        message: message,
        action: action,
        duration: duration ?? const Duration(milliseconds: 4000),
        showCloseIcon: showCloseIcon,
        onVisible: onVisible,
      ),
    );
  }

  /// Shows a custom snackbar.
  static void show(
    BuildContext context,
    Widget content, {
    Color? backgroundColor,
    SnackBarAction? action,
    Duration? duration,
    bool? showCloseIcon,
    VoidCallback? onVisible,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      ZoniSnackBar(
        content: content,
        backgroundColor: backgroundColor,
        action: action,
        duration: duration ?? const Duration(milliseconds: 4000),
        showCloseIcon: showCloseIcon,
        onVisible: onVisible,
      ),
    );
  }
}
