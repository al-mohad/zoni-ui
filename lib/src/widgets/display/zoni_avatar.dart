import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for avatar sizes.
enum ZoniAvatarSize {
  /// Extra small avatar size.
  xs,

  /// Small avatar size.
  small,

  /// Medium avatar size.
  medium,

  /// Large avatar size.
  large,

  /// Extra large avatar size.
  xl,
}

/// Enum for avatar variants.
enum ZoniAvatarVariant {
  /// Circular avatar.
  circular,

  /// Square avatar.
  square,

  /// Rounded square avatar.
  rounded,
}

/// A customizable avatar widget that follows Zoni design system principles.
class ZoniAvatar extends StatelessWidget {
  /// Creates a ZoniAvatar.
  const ZoniAvatar({
    super.key,
    this.child,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    this.backgroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.size = ZoniAvatarSize.medium,
    this.variant = ZoniAvatarVariant.circular,
    this.initials,
    this.name,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
  });

  /// Creates a circular avatar.
  const ZoniAvatar.circular({
    super.key,
    this.child,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    this.backgroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.size = ZoniAvatarSize.medium,
    this.initials,
    this.name,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
  }) : variant = ZoniAvatarVariant.circular;

  /// Creates a square avatar.
  const ZoniAvatar.square({
    super.key,
    this.child,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    this.backgroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.size = ZoniAvatarSize.medium,
    this.initials,
    this.name,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
  }) : variant = ZoniAvatarVariant.square;

  /// Creates a rounded square avatar.
  const ZoniAvatar.rounded({
    super.key,
    this.child,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    this.backgroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.size = ZoniAvatarSize.medium,
    this.initials,
    this.name,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
  }) : variant = ZoniAvatarVariant.rounded;

  /// Creates a small avatar.
  const ZoniAvatar.small({
    super.key,
    this.child,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    this.backgroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.variant = ZoniAvatarVariant.circular,
    this.initials,
    this.name,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
  }) : size = ZoniAvatarSize.small;

  /// Creates a large avatar.
  const ZoniAvatar.large({
    super.key,
    this.child,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.foregroundColor,
    this.backgroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
    this.variant = ZoniAvatarVariant.circular,
    this.initials,
    this.name,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
  }) : size = ZoniAvatarSize.large;

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The background image of the avatar.
  final ImageProvider? backgroundImage;

  /// The foreground image of the avatar.
  final ImageProvider? foregroundImage;

  /// An optional error callback for errors emitted when loading [backgroundImage].
  final ImageErrorListener? onBackgroundImageError;

  /// An optional error callback for errors emitted when loading [foregroundImage].
  final ImageErrorListener? onForegroundImageError;

  /// The color with which to fill the avatar.
  final Color? foregroundColor;

  /// The color with which to fill the avatar background.
  final Color? backgroundColor;

  /// The size of the avatar, expressed as the radius.
  final double? radius;

  /// The minimum size of the avatar, expressed as the radius.
  final double? minRadius;

  /// The maximum size of the avatar, expressed as the radius.
  final double? maxRadius;

  /// The size of the avatar.
  final ZoniAvatarSize size;

  /// The variant of the avatar.
  final ZoniAvatarVariant variant;

  /// Initials to display when no image is provided.
  final String? initials;

  /// Full name to generate initials from.
  final String? name;

  /// Whether to show a border around the avatar.
  final bool showBorder;

  /// The color of the border.
  final Color? borderColor;

  /// The width of the border.
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final double effectiveRadius = radius ?? _getDefaultRadius();
    final Color effectiveBackgroundColor =
        backgroundColor ?? _getDefaultBackgroundColor();
    final Color effectiveForegroundColor =
        foregroundColor ?? _getDefaultForegroundColor();
    final Color effectiveBorderColor = borderColor ?? ZoniColors.outline;
    final double effectiveBorderWidth = borderWidth ?? 2.0;

    Widget? avatarChild = child;

    // Generate initials if no child is provided
    if (avatarChild == null && (initials != null || name != null)) {
      final String displayInitials = initials ?? _generateInitials(name!);
      avatarChild = Text(
        displayInitials,
        style: _getInitialsTextStyle().copyWith(
          color: effectiveForegroundColor,
        ),
      );
    }

    Widget avatar;

    switch (variant) {
      case ZoniAvatarVariant.circular:
        avatar = CircleAvatar(
          radius: effectiveRadius,
          minRadius: minRadius,
          maxRadius: maxRadius,
          backgroundImage: backgroundImage,
          foregroundImage: foregroundImage,
          onBackgroundImageError: onBackgroundImageError,
          onForegroundImageError: onForegroundImageError,
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          child: avatarChild,
        );
        break;
      case ZoniAvatarVariant.square:
      case ZoniAvatarVariant.rounded:
        final BorderRadius borderRadius = variant == ZoniAvatarVariant.rounded
            ? BorderRadius.circular(ZoniBorderRadius.md)
            : BorderRadius.zero;

        avatar = Container(
          width: effectiveRadius * 2,
          height: effectiveRadius * 2,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: borderRadius,
            image: backgroundImage != null
                ? DecorationImage(
                    image: backgroundImage!,
                    fit: BoxFit.cover,
                    onError: onBackgroundImageError,
                  )
                : null,
          ),
          child: foregroundImage != null
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    image: DecorationImage(
                      image: foregroundImage!,
                      fit: BoxFit.cover,
                      onError: onForegroundImageError,
                    ),
                  ),
                )
              : Center(child: avatarChild),
        );
        break;
    }

    if (showBorder) {
      switch (variant) {
        case ZoniAvatarVariant.circular:
          avatar = DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: effectiveBorderColor,
                width: effectiveBorderWidth,
              ),
            ),
            child: avatar,
          );
          break;
        case ZoniAvatarVariant.square:
        case ZoniAvatarVariant.rounded:
          final BorderRadius borderRadius = variant == ZoniAvatarVariant.rounded
              ? BorderRadius.circular(ZoniBorderRadius.md)
              : BorderRadius.zero;

          avatar = DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: effectiveBorderColor,
                width: effectiveBorderWidth,
              ),
            ),
            child: avatar,
          );
          break;
      }
    }

    return avatar;
  }

  double _getDefaultRadius() {
    switch (size) {
      case ZoniAvatarSize.xs:
        return 12;
      case ZoniAvatarSize.small:
        return 16;
      case ZoniAvatarSize.medium:
        return 20;
      case ZoniAvatarSize.large:
        return 24;
      case ZoniAvatarSize.xl:
        return 32;
    }
  }

  Color _getDefaultBackgroundColor() => ZoniColors.primary;

  Color _getDefaultForegroundColor() => ZoniColors.onPrimary;

  TextStyle _getInitialsTextStyle() {
    switch (size) {
      case ZoniAvatarSize.xs:
        return ZoniTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.small:
        return ZoniTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.medium:
        return ZoniTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.large:
        return ZoniTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.xl:
        return ZoniTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w600);
    }
  }

  String _generateInitials(String name) {
    final List<String> words = name.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return '${words[0].substring(0, 1)}${words[1].substring(0, 1)}'
        .toUpperCase();
  }

}

/// A group of avatars displayed in a stack.
class ZoniAvatarGroup extends StatelessWidget {
  /// Creates a ZoniAvatarGroup.
  const ZoniAvatarGroup({
    required this.avatars,
    super.key,
    this.size = ZoniAvatarSize.medium,
    this.variant = ZoniAvatarVariant.circular,
    this.maxVisible = 3,
    this.spacing = 8,
    this.showBorder = true,
    this.borderColor,
    this.borderWidth,
    this.backgroundColor,
    this.onMoreTap,
  });

  /// The list of avatars to display.
  final List<ZoniAvatar> avatars;

  /// The size of the avatars.
  final ZoniAvatarSize size;

  /// The variant of the avatars.
  final ZoniAvatarVariant variant;

  /// Maximum number of avatars to show before showing "+X" indicator.
  final int maxVisible;

  /// Spacing between avatars (negative for overlap).
  final double spacing;

  /// Whether to show borders around avatars.
  final bool showBorder;

  /// The color of the borders.
  final Color? borderColor;

  /// The width of the borders.
  final double? borderWidth;

  /// Background color for the "+X" indicator.
  final Color? backgroundColor;

  /// Callback when the "+X" indicator is tapped.
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    final List<ZoniAvatar> visibleAvatars = avatars.take(maxVisible).toList();
    final int remainingCount = avatars.length - maxVisible;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ...visibleAvatars
            .asMap()
            .entries
            .map((MapEntry<int, ZoniAvatar> entry) {
          final int index = entry.key;
          final ZoniAvatar avatar = entry.value;

          return Transform.translate(
            offset: Offset(-spacing * index, 0),
            child: ZoniAvatar(
              size: size,
              variant: variant,
              showBorder: showBorder,
              borderColor: borderColor ?? ZoniColors.surface,
              borderWidth: borderWidth,
              backgroundImage: avatar.backgroundImage,
              foregroundImage: avatar.foregroundImage,
              backgroundColor: avatar.backgroundColor,
              foregroundColor: avatar.foregroundColor,
              initials: avatar.initials,
              name: avatar.name,
              child: avatar.child,
            ),
          );
        }),
        if (remainingCount > 0)
          Transform.translate(
            offset: Offset(-spacing * maxVisible, 0),
            child: GestureDetector(
              onTap: onMoreTap,
              child: ZoniAvatar(
                size: size,
                variant: variant,
                showBorder: showBorder,
                borderColor: borderColor ?? ZoniColors.surface,
                borderWidth: borderWidth,
                backgroundColor: backgroundColor ?? ZoniColors.surface,
                foregroundColor: ZoniColors.onSurface,
                child: Text(
                  '+$remainingCount',
                  style: _getMoreTextStyle(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  TextStyle _getMoreTextStyle() {
    switch (size) {
      case ZoniAvatarSize.xs:
        return ZoniTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.small:
        return ZoniTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.medium:
        return ZoniTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.large:
        return ZoniTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600);
      case ZoniAvatarSize.xl:
        return ZoniTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w600);
    }
  }

}
