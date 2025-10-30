import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Skeleton loader component for loading states.
class ZoniSkeleton extends StatefulWidget {
  /// Creates a skeleton loader.
  const ZoniSkeleton({
    super.key,
    this.width,
    this.height = 16.0,
    this.borderRadius = 4.0,
    this.animated = true,
    this.baseColor,
    this.highlightColor,
  });

  /// Width of the skeleton.
  final double? width;

  /// Height of the skeleton.
  final double height;

  /// Border radius of the skeleton.
  final double borderRadius;

  /// Whether to animate the skeleton.
  final bool animated;

  /// Base color of the skeleton.
  final Color? baseColor;

  /// Highlight color for animation.
  final Color? highlightColor;

  /// Creates a circular skeleton (for avatars).
  const ZoniSkeleton.circle({
    super.key,
    required double size,
    this.animated = true,
    this.baseColor,
    this.highlightColor,
  })  : width = size,
        height = size,
        borderRadius = size / 2;

  /// Creates a rectangular skeleton.
  const ZoniSkeleton.rectangle({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 4.0,
    this.animated = true,
    this.baseColor,
    this.highlightColor,
  });

  /// Creates a text line skeleton.
  const ZoniSkeleton.text({
    super.key,
    this.width,
    this.height = 16.0,
    this.borderRadius = 4.0,
    this.animated = true,
    this.baseColor,
    this.highlightColor,
  });

  @override
  State<ZoniSkeleton> createState() => _ZoniSkeletonState();
}

class _ZoniSkeletonState extends State<ZoniSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.animated) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor =
        widget.baseColor ?? ZoniColors.neutralGray.withValues(alpha: 0.1);
    final highlightColor =
        widget.highlightColor ?? ZoniColors.neutralGray.withValues(alpha: 0.2);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: widget.animated
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      baseColor,
                      highlightColor,
                      baseColor,
                    ],
                    stops: [
                      _animation.value - 0.3,
                      _animation.value,
                      _animation.value + 0.3,
                    ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
                  )
                : null,
            color: widget.animated ? null : baseColor,
          ),
        );
      },
    );
  }
}

/// Skeleton loader for list items.
class ZoniSkeletonListItem extends StatelessWidget {
  /// Creates a skeleton list item.
  const ZoniSkeletonListItem({
    super.key,
    this.hasAvatar = true,
    this.hasSubtitle = true,
    this.hasTrailing = false,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// Whether to show avatar skeleton.
  final bool hasAvatar;

  /// Whether to show subtitle skeleton.
  final bool hasSubtitle;

  /// Whether to show trailing skeleton.
  final bool hasTrailing;

  /// Padding around the item.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          if (hasAvatar) ...[
            const ZoniSkeleton.circle(size: 40.0),
            const SizedBox(width: 16.0),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ZoniSkeleton.text(width: 120.0, height: 16.0),
                if (hasSubtitle) ...[
                  const SizedBox(height: 8.0),
                  const ZoniSkeleton.text(width: 80.0, height: 14.0),
                ],
              ],
            ),
          ),
          if (hasTrailing) ...[
            const SizedBox(width: 16.0),
            const ZoniSkeleton.rectangle(width: 24.0, height: 24.0),
          ],
        ],
      ),
    );
  }
}

/// Skeleton loader for cards.
class ZoniSkeletonCard extends StatelessWidget {
  /// Creates a skeleton card.
  const ZoniSkeletonCard({
    super.key,
    this.hasImage = true,
    this.hasTitle = true,
    this.hasSubtitle = true,
    this.hasActions = false,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// Whether to show image skeleton.
  final bool hasImage;

  /// Whether to show title skeleton.
  final bool hasTitle;

  /// Whether to show subtitle skeleton.
  final bool hasSubtitle;

  /// Whether to show actions skeleton.
  final bool hasActions;

  /// Padding inside the card.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              const ZoniSkeleton.rectangle(
                width: double.infinity,
                height: 120.0,
                borderRadius: 8.0,
              ),
              const SizedBox(height: 16.0),
            ],
            if (hasTitle) ...[
              const ZoniSkeleton.text(width: 150.0, height: 18.0),
              const SizedBox(height: 8.0),
            ],
            if (hasSubtitle) ...[
              const ZoniSkeleton.text(width: 200.0, height: 14.0),
              const SizedBox(height: 4.0),
              const ZoniSkeleton.text(width: 180.0, height: 14.0),
            ],
            if (hasActions) ...[
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const ZoniSkeleton.rectangle(width: 80.0, height: 32.0),
                  const SizedBox(width: 8.0),
                  const ZoniSkeleton.rectangle(width: 80.0, height: 32.0),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Skeleton loader for text paragraphs.
class ZoniSkeletonParagraph extends StatelessWidget {
  /// Creates a skeleton paragraph.
  const ZoniSkeletonParagraph({
    super.key,
    this.lines = 3,
    this.lineHeight = 16.0,
    this.spacing = 8.0,
  });

  /// Number of lines to show.
  final int lines;

  /// Height of each line.
  final double lineHeight;

  /// Spacing between lines.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (index) {
        final isLast = index == lines - 1;
        final width = isLast ? 0.7 : 1.0;

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : spacing),
          child: ZoniSkeleton.text(
            width: MediaQuery.of(context).size.width * width,
            height: lineHeight,
          ),
        );
      }),
    );
  }
}
