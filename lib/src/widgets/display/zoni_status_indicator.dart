import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Status types for the status indicator.
enum ZoniStatusType {
  /// Success status (green).
  success,
  /// Warning status (orange).
  warning,
  /// Error status (red).
  error,
  /// Info status (blue).
  info,
  /// Neutral status (gray).
  neutral,
  /// Processing status (animated).
  processing,
}

/// Size variants for the status indicator.
enum ZoniStatusSize {
  /// Small size (8px).
  small,
  /// Medium size (12px).
  medium,
  /// Large size (16px).
  large,
}

/// A status indicator component for showing different states.
class ZoniStatusIndicator extends StatefulWidget {
  /// Creates a status indicator.
  const ZoniStatusIndicator({
    super.key,
    required this.type,
    this.size = ZoniStatusSize.medium,
    this.label,
    this.showLabel = true,
    this.animated = false,
    this.customColor,
  });

  /// The status type to display.
  final ZoniStatusType type;

  /// Size of the status indicator.
  final ZoniStatusSize size;

  /// Optional label text.
  final String? label;

  /// Whether to show the label.
  final bool showLabel;

  /// Whether to animate the indicator.
  final bool animated;

  /// Custom color override.
  final Color? customColor;

  /// Creates a success status indicator.
  const ZoniStatusIndicator.success({
    super.key,
    this.size = ZoniStatusSize.medium,
    this.label = 'Success',
    this.showLabel = true,
    this.animated = false,
    this.customColor,
  }) : type = ZoniStatusType.success;

  /// Creates a warning status indicator.
  const ZoniStatusIndicator.warning({
    super.key,
    this.size = ZoniStatusSize.medium,
    this.label = 'Warning',
    this.showLabel = true,
    this.animated = false,
    this.customColor,
  }) : type = ZoniStatusType.warning;

  /// Creates an error status indicator.
  const ZoniStatusIndicator.error({
    super.key,
    this.size = ZoniStatusSize.medium,
    this.label = 'Error',
    this.showLabel = true,
    this.animated = false,
    this.customColor,
  }) : type = ZoniStatusType.error;

  /// Creates an info status indicator.
  const ZoniStatusIndicator.info({
    super.key,
    this.size = ZoniStatusSize.medium,
    this.label = 'Info',
    this.showLabel = true,
    this.animated = false,
    this.customColor,
  }) : type = ZoniStatusType.info;

  /// Creates a processing status indicator.
  const ZoniStatusIndicator.processing({
    super.key,
    this.size = ZoniStatusSize.medium,
    this.label = 'Processing',
    this.showLabel = true,
    this.customColor,
  })  : type = ZoniStatusType.processing,
        animated = true;

  @override
  State<ZoniStatusIndicator> createState() => _ZoniStatusIndicatorState();
}

class _ZoniStatusIndicatorState extends State<ZoniStatusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.animated || widget.type == ZoniStatusType.processing) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(ZoniStatusIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.animated || widget.type == ZoniStatusType.processing) &&
        !_animationController.isAnimating) {
      _animationController.repeat(reverse: true);
    } else if (!widget.animated &&
        widget.type != ZoniStatusType.processing &&
        _animationController.isAnimating) {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get _statusColor {
    if (widget.customColor != null) return widget.customColor!;

    switch (widget.type) {
      case ZoniStatusType.success:
        return ZoniColors.success;
      case ZoniStatusType.warning:
        return ZoniColors.warning;
      case ZoniStatusType.error:
        return ZoniColors.error;
      case ZoniStatusType.info:
        return ZoniColors.info;
      case ZoniStatusType.neutral:
        return ZoniColors.neutralGray;
      case ZoniStatusType.processing:
        return ZoniColors.primary;
    }
  }

  double get _indicatorSize {
    switch (widget.size) {
      case ZoniStatusSize.small:
        return 8.0;
      case ZoniStatusSize.medium:
        return 12.0;
      case ZoniStatusSize.large:
        return 16.0;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case ZoniStatusSize.small:
        return 12.0;
      case ZoniStatusSize.medium:
        return 14.0;
      case ZoniStatusSize.large:
        return 16.0;
    }
  }

  Widget _buildIndicator() {
    final indicator = Container(
      width: _indicatorSize,
      height: _indicatorSize,
      decoration: BoxDecoration(
        color: _statusColor,
        shape: BoxShape.circle,
      ),
    );

    if (widget.animated || widget.type == ZoniStatusType.processing) {
      return AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: indicator,
          );
        },
      );
    }

    return indicator;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showLabel || widget.label == null) {
      return _buildIndicator();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIndicator(),
        const SizedBox(width: 8.0),
        Text(
          widget.label!,
          style: TextStyle(
            fontSize: _fontSize,
            color: _statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// A status card component for displaying status with additional context.
class ZoniStatusCard extends StatelessWidget {
  /// Creates a status card.
  const ZoniStatusCard({
    super.key,
    required this.type,
    required this.title,
    this.description,
    this.action,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// The status type.
  final ZoniStatusType type;

  /// Title text.
  final String title;

  /// Optional description text.
  final String? description;

  /// Optional action widget.
  final Widget? action;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Padding inside the card.
  final EdgeInsets padding;

  Color get _statusColor {
    switch (type) {
      case ZoniStatusType.success:
        return ZoniColors.success;
      case ZoniStatusType.warning:
        return ZoniColors.warning;
      case ZoniStatusType.error:
        return ZoniColors.error;
      case ZoniStatusType.info:
        return ZoniColors.info;
      case ZoniStatusType.neutral:
        return ZoniColors.neutralGray;
      case ZoniStatusType.processing:
        return ZoniColors.primary;
    }
  }

  Color get _backgroundColor {
    return _statusColor.withValues(alpha: 0.1);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _backgroundColor,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: _statusColor.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              ZoniStatusIndicator(
                type: type,
                showLabel: false,
                size: ZoniStatusSize.medium,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        description!,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: _statusColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (action != null) ...[
                const SizedBox(width: 12.0),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
