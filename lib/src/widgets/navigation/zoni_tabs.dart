import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// Enum for tab bar variants.
enum ZoniTabBarVariant {
  /// Primary tab bar variant.
  primary,

  /// Secondary tab bar variant.
  secondary,

  /// Underlined tab bar variant.
  underlined,

  /// Pills tab bar variant.
  pills,
}

/// Enum for tab bar sizes.
enum ZoniTabBarSize {
  /// Small tab bar size.
  small,

  /// Medium tab bar size.
  medium,

  /// Large tab bar size.
  large,
}

/// A tab bar widget that follows Zoni design system principles.
class ZoniTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a ZoniTabBar.
  const ZoniTabBar({
    required this.tabs,
    super.key,
    this.controller,
    this.variant = ZoniTabBarVariant.primary,
    this.size = ZoniTabBarSize.medium,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.indicatorWeight,
    this.indicatorPadding,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment,
    this.textScaler,
  });

  /// Creates a primary tab bar.
  const ZoniTabBar.primary({
    required this.tabs,
    super.key,
    this.controller,
    this.size = ZoniTabBarSize.medium,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.indicatorWeight,
    this.indicatorPadding,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment,
    this.textScaler,
  }) : variant = ZoniTabBarVariant.primary;

  /// Creates a secondary tab bar.
  const ZoniTabBar.secondary({
    required this.tabs,
    super.key,
    this.controller,
    this.size = ZoniTabBarSize.medium,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.indicatorWeight,
    this.indicatorPadding,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment,
    this.textScaler,
  }) : variant = ZoniTabBarVariant.secondary;

  /// Creates an underlined tab bar.
  const ZoniTabBar.underlined({
    required this.tabs,
    super.key,
    this.controller,
    this.size = ZoniTabBarSize.medium,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.indicatorWeight,
    this.indicatorPadding,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment,
    this.textScaler,
  }) : variant = ZoniTabBarVariant.underlined;

  /// Creates a pills tab bar.
  const ZoniTabBar.pills({
    required this.tabs,
    super.key,
    this.controller,
    this.size = ZoniTabBarSize.medium,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.indicatorWeight,
    this.indicatorPadding,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment,
    this.textScaler,
  }) : variant = ZoniTabBarVariant.pills;

  /// The list of tabs.
  final List<Widget> tabs;

  /// The tab controller.
  final TabController? controller;

  /// The tab bar variant.
  final ZoniTabBarVariant variant;

  /// The tab bar size.
  final ZoniTabBarSize size;

  /// Whether the tab bar is scrollable.
  final bool isScrollable;

  /// Padding around the tab bar.
  final EdgeInsetsGeometry? padding;

  /// Color of the selection indicator.
  final Color? indicatorColor;

  /// Weight of the selection indicator.
  final double? indicatorWeight;

  /// Padding of the selection indicator.
  final EdgeInsetsGeometry? indicatorPadding;

  /// Custom indicator decoration.
  final Decoration? indicator;

  /// Size of the selection indicator.
  final TabBarIndicatorSize? indicatorSize;

  /// Color of the selected tab label.
  final Color? labelColor;

  /// Style of the selected tab label.
  final TextStyle? labelStyle;

  /// Padding of the tab labels.
  final EdgeInsetsGeometry? labelPadding;

  /// Color of the unselected tab labels.
  final Color? unselectedLabelColor;

  /// Style of the unselected tab labels.
  final TextStyle? unselectedLabelStyle;

  /// Drag start behavior.
  final DragStartBehavior dragStartBehavior;

  /// Overlay color for tab interactions.
  final WidgetStateProperty<Color?>? overlayColor;

  /// Mouse cursor for tabs.
  final MouseCursor? mouseCursor;

  /// Whether to enable feedback.
  final bool? enableFeedback;

  /// Callback when a tab is tapped.
  final ValueChanged<int>? onTap;

  /// Physics for scrollable tab bars.
  final ScrollPhysics? physics;

  /// Splash factory for tab interactions.
  final InteractiveInkFeatureFactory? splashFactory;

  /// Border radius for splash effects.
  final BorderRadius? splashBorderRadius;

  /// Alignment of tabs.
  final TabAlignment? tabAlignment;

  /// Text scaler.
  final TextScaler? textScaler;

  @override
  Size get preferredSize => Size.fromHeight(_getTabBarHeight());

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: _getContainerDecoration() ?? const BoxDecoration(),
        child: TabBar(
          tabs: tabs,
          controller: controller,
          isScrollable: isScrollable,
          padding: padding,
          indicatorColor: indicatorColor ?? _getIndicatorColor(),
          indicatorWeight: indicatorWeight ?? _getIndicatorWeight(),
          indicatorPadding: indicatorPadding ?? _getIndicatorPadding(),
          indicator: indicator ?? _getIndicator(),
          indicatorSize: indicatorSize ?? _getIndicatorSize(),
          labelColor: labelColor ?? _getLabelColor(),
          labelStyle: labelStyle ?? _getLabelStyle(),
          labelPadding: labelPadding ?? _getLabelPadding(),
          unselectedLabelColor:
              unselectedLabelColor ?? _getUnselectedLabelColor(),
          unselectedLabelStyle:
              unselectedLabelStyle ?? _getUnselectedLabelStyle(),
          dragStartBehavior: dragStartBehavior,
          overlayColor: overlayColor,
          mouseCursor: mouseCursor,
          enableFeedback: enableFeedback,
          onTap: onTap,
          physics: physics,
          splashFactory: splashFactory,
          splashBorderRadius: splashBorderRadius,
          tabAlignment: tabAlignment,
          textScaler: textScaler,
        ),
      );

  double _getTabBarHeight() {
    switch (size) {
      case ZoniTabBarSize.small:
        return 36;
      case ZoniTabBarSize.medium:
        return 48;
      case ZoniTabBarSize.large:
        return 56;
    }
  }

  Decoration? _getContainerDecoration() {
    switch (variant) {
      case ZoniTabBarVariant.primary:
        return const BoxDecoration(
          color: ZoniColors.primary,
          border: Border(
            bottom: BorderSide(
              color: ZoniColors.outline,
            ),
          ),
        );
      case ZoniTabBarVariant.secondary:
        return const BoxDecoration(
          color: ZoniColors.surface,
          border: Border(
            bottom: BorderSide(
              color: ZoniColors.outline,
            ),
          ),
        );
      case ZoniTabBarVariant.underlined:
        return const BoxDecoration(
          color: ZoniColors.surface,
          border: Border(
            bottom: BorderSide(
              color: ZoniColors.outline,
            ),
          ),
        );
      case ZoniTabBarVariant.pills:
        return const BoxDecoration(
          color: ZoniColors.surface,
        );
    }
  }

  Color _getIndicatorColor() {
    switch (variant) {
      case ZoniTabBarVariant.primary:
        return ZoniColors.onPrimary;
      case ZoniTabBarVariant.secondary:
      case ZoniTabBarVariant.underlined:
        return ZoniColors.primary;
      case ZoniTabBarVariant.pills:
        return Colors.transparent;
    }
  }

  double _getIndicatorWeight() {
    switch (variant) {
      case ZoniTabBarVariant.primary:
      case ZoniTabBarVariant.secondary:
      case ZoniTabBarVariant.underlined:
        return 2;
      case ZoniTabBarVariant.pills:
        return 0;
    }
  }

  EdgeInsetsGeometry _getIndicatorPadding() {
    switch (variant) {
      case ZoniTabBarVariant.pills:
        return const EdgeInsets.all(ZoniSpacing.xs);
      default:
        return EdgeInsets.zero;
    }
  }

  Decoration? _getIndicator() {
    switch (variant) {
      case ZoniTabBarVariant.pills:
        return BoxDecoration(
          color: ZoniColors.primary,
          borderRadius: BorderRadius.circular(ZoniBorderRadius.full),
        );
      default:
        return null;
    }
  }

  TabBarIndicatorSize _getIndicatorSize() {
    switch (variant) {
      case ZoniTabBarVariant.pills:
        return TabBarIndicatorSize.tab;
      default:
        return TabBarIndicatorSize.label;
    }
  }

  Color _getLabelColor() {
    switch (variant) {
      case ZoniTabBarVariant.primary:
        return ZoniColors.onPrimary;
      case ZoniTabBarVariant.secondary:
      case ZoniTabBarVariant.underlined:
        return ZoniColors.primary;
      case ZoniTabBarVariant.pills:
        return ZoniColors.onPrimary;
    }
  }

  TextStyle _getLabelStyle() {
    switch (size) {
      case ZoniTabBarSize.small:
        return ZoniTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600);
      case ZoniTabBarSize.medium:
        return ZoniTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600);
      case ZoniTabBarSize.large:
        return ZoniTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w600);
    }
  }

  EdgeInsetsGeometry _getLabelPadding() {
    switch (size) {
      case ZoniTabBarSize.small:
        return const EdgeInsets.symmetric(horizontal: ZoniSpacing.sm);
      case ZoniTabBarSize.medium:
        return const EdgeInsets.symmetric(horizontal: ZoniSpacing.md);
      case ZoniTabBarSize.large:
        return const EdgeInsets.symmetric(horizontal: ZoniSpacing.lg);
    }
  }

  Color _getUnselectedLabelColor() {
    switch (variant) {
      case ZoniTabBarVariant.primary:
        return ZoniColors.onPrimary.withOpacity(0.7);
      case ZoniTabBarVariant.secondary:
      case ZoniTabBarVariant.underlined:
      case ZoniTabBarVariant.pills:
        return ZoniColors.onSurface.withOpacity(0.7);
    }
  }

  TextStyle _getUnselectedLabelStyle() {
    switch (size) {
      case ZoniTabBarSize.small:
        return ZoniTextStyles.labelSmall;
      case ZoniTabBarSize.medium:
        return ZoniTextStyles.labelMedium;
      case ZoniTabBarSize.large:
        return ZoniTextStyles.labelLarge;
    }
  }

}

/// A tab view widget that works with ZoniTabBar.
class ZoniTabBarView extends StatelessWidget {
  /// Creates a ZoniTabBarView.
  const ZoniTabBarView({
    required this.children,
    super.key,
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  });

  /// The list of tab view children.
  final List<Widget> children;

  /// The tab controller.
  final TabController? controller;

  /// Physics for the tab view.
  final ScrollPhysics? physics;

  /// Drag start behavior.
  final DragStartBehavior dragStartBehavior;

  /// Viewport fraction.
  final double viewportFraction;

  /// Clip behavior.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) => TabBarView(
        controller: controller,
        physics: physics,
        dragStartBehavior: dragStartBehavior,
        viewportFraction: viewportFraction,
        clipBehavior: clipBehavior,
        children: children,
      );

}

/// A complete tab widget that combines tab bar and tab view.
class ZoniTabs extends StatefulWidget {
  /// Creates a ZoniTabs.
  const ZoniTabs({
    required this.tabs,
    required this.children,
    super.key,
    this.initialIndex = 0,
    this.variant = ZoniTabBarVariant.primary,
    this.size = ZoniTabBarSize.medium,
    this.isScrollable = false,
    this.onTap,
    this.physics,
    this.length,
    this.animationDuration,
  });

  /// The list of tab labels.
  final List<Widget> tabs;

  /// The list of tab view children.
  final List<Widget> children;

  /// Initial tab index.
  final int initialIndex;

  /// The tab bar variant.
  final ZoniTabBarVariant variant;

  /// The tab bar size.
  final ZoniTabBarSize size;

  /// Whether the tab bar is scrollable.
  final bool isScrollable;

  /// Callback when a tab is tapped.
  final ValueChanged<int>? onTap;

  /// Physics for the tab view.
  final ScrollPhysics? physics;

  /// Length of tabs (if different from tabs.length).
  final int? length;

  /// Animation duration for tab changes.
  final Duration? animationDuration;

  @override
  State<ZoniTabs> createState() => _ZoniTabsState();

}

class _ZoniTabsState extends State<ZoniTabs> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: widget.length ?? widget.tabs.length,
      initialIndex: widget.initialIndex,
      animationDuration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ZoniTabBar(
            tabs: widget.tabs,
            controller: _controller,
            variant: widget.variant,
            size: widget.size,
            isScrollable: widget.isScrollable,
            onTap: widget.onTap,
          ),
          Expanded(
            child: ZoniTabBarView(
              controller: _controller,
              physics: widget.physics,
              children: widget.children,
            ),
          ),
        ],
      );
}
