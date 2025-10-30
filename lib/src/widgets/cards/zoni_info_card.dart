import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Variants for info cards.
enum ZoniInfoCardVariant {
  /// Default card with neutral styling.
  neutral,
  /// Success card with green accent.
  success,
  /// Warning card with orange accent.
  warning,
  /// Error card with red accent.
  error,
  /// Info card with blue accent.
  info,
}

/// An enhanced card component for displaying information with icons and actions.
class ZoniInfoCard extends StatelessWidget {
  /// Creates an info card.
  const ZoniInfoCard({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.trailing,
    this.onTap,
    this.variant = ZoniInfoCardVariant.neutral,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 2.0,
  });

  /// Title text of the card.
  final String title;

  /// Optional description text.
  final String? description;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Visual variant of the card.
  final ZoniInfoCardVariant variant;

  /// Padding inside the card.
  final EdgeInsets padding;

  /// Border radius of the card.
  final double borderRadius;

  /// Whether to show a border.
  final bool showBorder;

  /// Elevation of the card.
  final double elevation;

  /// Creates a success info card.
  const ZoniInfoCard.success({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.check_circle,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 2.0,
  }) : variant = ZoniInfoCardVariant.success;

  /// Creates a warning info card.
  const ZoniInfoCard.warning({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.warning,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 2.0,
  }) : variant = ZoniInfoCardVariant.warning;

  /// Creates an error info card.
  const ZoniInfoCard.error({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.error,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 2.0,
  }) : variant = ZoniInfoCardVariant.error;

  /// Creates an info card.
  const ZoniInfoCard.info({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.info,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.showBorder = true,
    this.elevation = 2.0,
  }) : variant = ZoniInfoCardVariant.info;

  Color get _accentColor {
    switch (variant) {
      case ZoniInfoCardVariant.neutral:
        return ZoniColors.neutralGray;
      case ZoniInfoCardVariant.success:
        return ZoniColors.success;
      case ZoniInfoCardVariant.warning:
        return ZoniColors.warning;
      case ZoniInfoCardVariant.error:
        return ZoniColors.error;
      case ZoniInfoCardVariant.info:
        return ZoniColors.info;
    }
  }

  Color get _backgroundColor {
    return _accentColor.withValues(alpha: 0.05);
  }

  Color get _borderColor {
    return _accentColor.withValues(alpha: 0.2);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: _backgroundColor,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: showBorder
                ? Border.all(
                    color: _borderColor,
                    width: 1.0,
                  )
                : null,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: _accentColor,
                  size: 24.0,
                ),
                const SizedBox(width: 16.0),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _accentColor,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        description!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 16.0),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A feature card component for showcasing features or services.
class ZoniFeatureCard extends StatelessWidget {
  /// Creates a feature card.
  const ZoniFeatureCard({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.image,
    this.action,
    this.onTap,
    this.padding = const EdgeInsets.all(20.0),
    this.borderRadius = 16.0,
    this.elevation = 4.0,
    this.aspectRatio = 1.2,
  });

  /// Title of the feature.
  final String title;

  /// Description of the feature.
  final String description;

  /// Optional icon.
  final IconData? icon;

  /// Optional image widget.
  final Widget? image;

  /// Optional action button.
  final Widget? action;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Padding inside the card.
  final EdgeInsets padding;

  /// Border radius of the card.
  final double borderRadius;

  /// Elevation of the card.
  final double elevation;

  /// Aspect ratio of the card.
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Material(
        color: theme.cardColor,
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null) ...[
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: image!,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ] else if (icon != null) ...[
                  Icon(
                    icon,
                    size: 32.0,
                    color: ZoniColors.primary,
                  ),
                  const SizedBox(height: 16.0),
                ],
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: Text(
                          description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.7),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (action != null) ...[
                        const SizedBox(height: 16.0),
                        action!,
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
