import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// A header component for displaying page titles, descriptions, and actions.
///
/// The [ZoniHeader] provides a consistent way to display page headers with
/// optional background images, gradients, and action buttons.
class ZoniHeader extends StatelessWidget {
  /// Creates a [ZoniHeader].
  const ZoniHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.backgroundImage,
    this.backgroundColor,
    this.gradient,
    this.actions = const [],
    this.height,
    this.padding = const EdgeInsets.all(24.0),
    this.textAlign = TextAlign.start,
    this.showDivider = false,
    this.onTap,
  });

  /// The main title text.
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional description text.
  final String? description;

  /// Optional background image.
  final ImageProvider? backgroundImage;

  /// Background color for the header.
  final Color? backgroundColor;

  /// Optional gradient background.
  final Gradient? gradient;

  /// Action buttons to display in the header.
  final List<Widget> actions;

  /// Height of the header.
  final double? height;

  /// Padding around the header content.
  final EdgeInsetsGeometry padding;

  /// Text alignment for the header content.
  final TextAlign textAlign;

  /// Whether to show a divider at the bottom.
  final bool showDivider;

  /// Callback when the header is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget content = Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        gradient: gradient,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Container(
        padding: padding,
        decoration: backgroundImage != null
            ? BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: textAlign == TextAlign.center
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (actions.isNotEmpty && textAlign != TextAlign.center)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTitleSection(theme)),
                  Row(children: actions),
                ],
              )
            else ...[
              _buildTitleSection(theme),
              if (actions.isNotEmpty && textAlign == TextAlign.center) ...[
                SizedBox(height: ZoniSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: actions,
                ),
              ],
            ],
          ],
        ),
      ),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        child: content,
      );
    }

    return Column(
      children: [
        content,
        if (showDivider) const Divider(height: 1),
      ],
    );
  }

  Widget _buildTitleSection(ThemeData theme) {
    final titleColor = backgroundImage != null
        ? Colors.white
        : theme.colorScheme.onSurface;
    final subtitleColor = backgroundImage != null
        ? Colors.white.withValues(alpha: 0.9)
        : theme.colorScheme.onSurface.withValues(alpha: 0.7);

    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          SizedBox(height: ZoniSpacing.xs),
          Text(
            subtitle!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: subtitleColor,
            ),
            textAlign: textAlign,
          ),
        ],
        if (description != null) ...[
          SizedBox(height: ZoniSpacing.sm),
          Text(
            description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: subtitleColor,
            ),
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('subtitle', subtitle));
    properties.add(StringProperty('description', description));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(DoubleProperty('height', height));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign));
    properties.add(FlagProperty('showDivider', value: showDivider, ifTrue: 'showDivider'));
  }
}

/// A hero header component with large background and centered content.
class ZoniHeroHeader extends StatelessWidget {
  /// Creates a [ZoniHeroHeader].
  const ZoniHeroHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.backgroundImage,
    this.gradient,
    this.actions = const [],
    this.height = 400.0,
    this.onTap,
  });

  /// The main title text.
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional description text.
  final String? description;

  /// Optional background image.
  final ImageProvider? backgroundImage;

  /// Optional gradient background.
  final Gradient? gradient;

  /// Action buttons to display in the header.
  final List<Widget> actions;

  /// Height of the hero header.
  final double height;

  /// Callback when the header is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ZoniHeader(
      title: title,
      subtitle: subtitle,
      description: description,
      backgroundImage: backgroundImage,
      gradient: gradient ?? _defaultGradient,
      actions: actions,
      height: height,
      textAlign: TextAlign.center,
      padding: const EdgeInsets.all(48.0),
      onTap: onTap,
    );
  }

  static const Gradient _defaultGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ZoniColors.primary,
      ZoniColors.secondary,
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('subtitle', subtitle));
    properties.add(StringProperty('description', description));
    properties.add(DoubleProperty('height', height));
  }
}
