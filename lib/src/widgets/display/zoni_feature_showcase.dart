import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';

/// Feature data model.
class ZoniFeature {
  /// Creates a feature.
  const ZoniFeature({
    required this.title,
    required this.description,
    this.icon,
    this.image,
    this.color,
    this.onTap,
  });

  /// Feature title.
  final String title;

  /// Feature description.
  final String description;

  /// Feature icon.
  final IconData? icon;

  /// Feature image.
  final Widget? image;

  /// Feature color.
  final Color? color;

  /// Callback when the feature is tapped.
  final VoidCallback? onTap;
}

/// A feature showcase component for highlighting product features.
class ZoniFeatureShowcase extends StatelessWidget {
  /// Creates a feature showcase.
  const ZoniFeatureShowcase({
    required this.features,
    super.key,
    this.variant = ZoniFeatureShowcaseVariant.grid,
    this.crossAxisCount = 2,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.padding = const EdgeInsets.all(16),
  });

  /// List of features to display.
  final List<ZoniFeature> features;

  /// Display variant.
  final ZoniFeatureShowcaseVariant variant;

  /// Number of columns for grid variant.
  final int crossAxisCount;

  /// Horizontal spacing between items.
  final double spacing;

  /// Vertical spacing between items.
  final double runSpacing;

  /// Padding around the showcase.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (features.isEmpty) {
      return const SizedBox.shrink();
    }

    switch (variant) {
      case ZoniFeatureShowcaseVariant.grid:
        return _buildGridVariant(context);
      case ZoniFeatureShowcaseVariant.list:
        return _buildListVariant(context);
      case ZoniFeatureShowcaseVariant.carousel:
        return _buildCarouselVariant(context);
    }
  }

  Widget _buildGridVariant(BuildContext context) => Padding(
        padding: padding,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: runSpacing,
            childAspectRatio: 1.2,
          ),
          itemCount: features.length,
          itemBuilder: (BuildContext context, int index) =>
              _buildFeatureCard(context, features[index]),
        ),
      );

  Widget _buildListVariant(BuildContext context) => Padding(
        padding: padding,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: features.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: runSpacing),
          itemBuilder: (BuildContext context, int index) =>
              _buildFeatureListItem(context, features[index]),
        ),
      );

  Widget _buildCarouselVariant(BuildContext context) => SizedBox(
        height: 200,
        child: PageView.builder(
          padEnds: false,
          controller: PageController(viewportFraction: 0.85),
          itemCount: features.length,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? padding.left : spacing / 2,
              right: index == features.length - 1 ? padding.right : spacing / 2,
            ),
            child: _buildFeatureCard(context, features[index]),
          ),
        ),
      );

  Widget _buildFeatureCard(BuildContext context, ZoniFeature feature) {
    final ThemeData theme = Theme.of(context);
    final Color featureColor = feature.color ?? ZoniColors.primary;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: feature.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (feature.image != null) ...<Widget>[
                Expanded(
                  flex: 2,
                  child: Center(
                    child: feature.image,
                  ),
                ),
                const SizedBox(height: 16),
              ] else if (feature.icon != null) ...<Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: featureColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    feature.icon,
                    color: featureColor,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Text(
                feature.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  feature.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color
                        ?.withValues(alpha: 0.7),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureListItem(BuildContext context, ZoniFeature feature) {
    final ThemeData theme = Theme.of(context);
    final Color featureColor = feature.color ?? ZoniColors.primary;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: feature.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (feature.image != null) ...<Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: feature.image,
                  ),
                ),
                const SizedBox(width: 16),
              ] else if (feature.icon != null) ...<Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: featureColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    feature.icon,
                    color: featureColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      feature.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color
                            ?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              if (feature.onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: theme.disabledColor,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<ZoniFeature>('features', features));
    properties
        .add(EnumProperty<ZoniFeatureShowcaseVariant>('variant', variant));
    properties.add(IntProperty('crossAxisCount', crossAxisCount));
    properties.add(DoubleProperty('spacing', spacing));
    properties.add(DoubleProperty('runSpacing', runSpacing));
    properties.add(DiagnosticsProperty<EdgeInsets>('padding', padding));
  }
}

/// Feature showcase display variants.
enum ZoniFeatureShowcaseVariant {
  /// Grid layout.
  grid,

  /// List layout.
  list,

  /// Carousel layout.
  carousel,
}

/// A single feature showcase card component.
class ZoniFeatureShowcaseCard extends StatelessWidget {
  /// Creates a feature showcase card.
  const ZoniFeatureShowcaseCard({
    required this.feature,
    super.key,
    this.width,
    this.height,
    this.elevation = 2.0,
  });

  /// The feature to display.
  final ZoniFeature feature;

  /// Width of the card.
  final double? width;

  /// Height of the card.
  final double? height;

  /// Elevation of the card.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color featureColor = feature.color ?? ZoniColors.primary;

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: feature.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (feature.image != null) ...<Widget>[
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: feature.image,
                    ),
                  ),
                  const SizedBox(height: 16),
                ] else if (feature.icon != null) ...<Widget>[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: featureColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      feature.icon,
                      color: featureColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  feature.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    feature.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color
                          ?.withValues(alpha: 0.7),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZoniFeature>('feature', feature));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('elevation', elevation));
  }
}
