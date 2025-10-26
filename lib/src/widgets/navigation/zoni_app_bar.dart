import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/zoni_constants.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';

/// A customizable app bar that follows Zoni design system principles.
class ZoniAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a ZoniAppBar.
  const ZoniAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.shadowColor,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.shape,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
    this.scrolledUnderElevation,
  });

  /// Creates a ZoniAppBar with primary styling.
  const ZoniAppBar.primary({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.elevation,
    this.shadowColor,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.shape,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
    this.scrolledUnderElevation,
  })  : backgroundColor = ZoniColors.primary,
        foregroundColor = ZoniColors.onPrimary;

  /// Creates a ZoniAppBar with surface styling.
  const ZoniAppBar.surface({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.elevation,
    this.shadowColor,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.shape,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
    this.scrolledUnderElevation,
  })  : backgroundColor = ZoniColors.surface,
        foregroundColor = ZoniColors.onSurface;

  /// Creates a ZoniAppBar with transparent styling.
  const ZoniAppBar.transparent({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.shadowColor,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.shape,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
    this.scrolledUnderElevation,
  })  : backgroundColor = Colors.transparent,
        foregroundColor = ZoniColors.onSurface,
        elevation = 0;

  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// A widget to display before the title.
  final Widget? leading;

  /// A list of widgets to display in a row after the title widget.
  final List<Widget>? actions;

  /// The fill color to use for an app bar's Material.
  final Color? backgroundColor;

  /// The default color for Text and Icons within the app bar.
  final Color? foregroundColor;

  /// The z-coordinate at which to place this app bar relative to its parent.
  final double? elevation;

  /// The color of the shadow below the app bar.
  final Color? shadowColor;

  /// Whether the title should be centered.
  final bool? centerTitle;

  /// The spacing around title content on the horizontal axis.
  final double? titleSpacing;

  /// Defines the height of the toolbar component of an AppBar.
  final double? toolbarHeight;

  /// Defines the width of leading widget.
  final double? leadingWidth;

  /// Controls whether we should try to imply the leading widget if null.
  final bool automaticallyImplyLeading;

  /// This widget is stacked behind the toolbar and the tab bar.
  final Widget? flexibleSpace;

  /// This widget appears across the bottom of the app bar.
  final PreferredSizeWidget? bottom;

  /// The shape of the app bar's Material.
  final ShapeBorder? shape;

  /// The color, opacity, and size to use for app bar icons.
  final IconThemeData? iconTheme;

  /// The color, opacity, and size to use for the icons that appear in the app bar's actions.
  final IconThemeData? actionsIconTheme;

  /// Whether this app bar is being displayed at the top of the screen.
  final bool primary;

  /// Whether the title should be wrapped with header Semantics.
  final bool excludeHeaderSemantics;

  /// The default text style for the AppBar's title widget.
  final TextStyle? titleTextStyle;

  /// The default text style for the AppBar's leading, and actions widgets.
  final TextStyle? toolbarTextStyle;

  /// Specifies the style to use for the system overlays.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Forces the AppBar's Material to be transparent.
  final bool forceMaterialTransparency;

  /// The content will be clipped (or not) according to this option.
  final Clip? clipBehavior;

  /// The elevation that will be used if this app bar has something scrolled underneath it.
  final double? scrolledUnderElevation;

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight ?? kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) => AppBar(
        title: title,
        leading: leading,
        actions: actions,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
        shadowColor: shadowColor,
        centerTitle: centerTitle,
        titleSpacing: titleSpacing,
        toolbarHeight: toolbarHeight,
        leadingWidth: leadingWidth,
        automaticallyImplyLeading: automaticallyImplyLeading,
        flexibleSpace: flexibleSpace,
        bottom: bottom,
        shape: shape,
        iconTheme: iconTheme,
        actionsIconTheme: actionsIconTheme,
        primary: primary,
        excludeHeaderSemantics: excludeHeaderSemantics,
        titleTextStyle: titleTextStyle ?? ZoniTextStyles.titleLarge,
        toolbarTextStyle: toolbarTextStyle ?? ZoniTextStyles.bodyMedium,
        systemOverlayStyle: systemOverlayStyle,
        forceMaterialTransparency: forceMaterialTransparency,
        clipBehavior: clipBehavior,
        scrolledUnderElevation: scrolledUnderElevation,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('foregroundColor', foregroundColor));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(ColorProperty('shadowColor', shadowColor));
    properties.add(DiagnosticsProperty<bool?>('centerTitle', centerTitle));
    properties.add(DoubleProperty('titleSpacing', titleSpacing));
    properties.add(DoubleProperty('toolbarHeight', toolbarHeight));
    properties.add(DoubleProperty('leadingWidth', leadingWidth));
    properties.add(
      DiagnosticsProperty<bool>(
        'automaticallyImplyLeading',
        automaticallyImplyLeading,
      ),
    );
    properties.add(DiagnosticsProperty<ShapeBorder?>('shape', shape));
    properties.add(DiagnosticsProperty<IconThemeData?>('iconTheme', iconTheme));
    properties.add(
      DiagnosticsProperty<IconThemeData?>(
        'actionsIconTheme',
        actionsIconTheme,
      ),
    );
    properties.add(DiagnosticsProperty<bool>('primary', primary));
    properties.add(
      DiagnosticsProperty<bool>(
        'excludeHeaderSemantics',
        excludeHeaderSemantics,
      ),
    );
    properties
        .add(DiagnosticsProperty<TextStyle?>('titleTextStyle', titleTextStyle));
    properties.add(
      DiagnosticsProperty<TextStyle?>('toolbarTextStyle', toolbarTextStyle),
    );
    properties.add(
      DiagnosticsProperty<SystemUiOverlayStyle?>(
        'systemOverlayStyle',
        systemOverlayStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'forceMaterialTransparency',
        forceMaterialTransparency,
      ),
    );
    properties.add(EnumProperty<Clip?>('clipBehavior', clipBehavior));
    properties
        .add(DoubleProperty('scrolledUnderElevation', scrolledUnderElevation));
  }
}

/// A bottom navigation bar that follows Zoni design system principles.
class ZoniBottomNavigationBar extends StatelessWidget {
  /// Creates a ZoniBottomNavigationBar.
  const ZoniBottomNavigationBar({
    required this.items,
    super.key,
    this.onTap,
    this.currentIndex = 0,
    this.elevation,
    this.type,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.mouseCursor,
    this.enableFeedback,
    this.landscapeLayout,
    this.useLegacyColorScheme = true,
  });

  /// Defines the appearance of the button items.
  final List<BottomNavigationBarItem> items;

  /// Called when one of the items is tapped.
  final ValueChanged<int>? onTap;

  /// The index into items for the current active BottomNavigationBarItem.
  final int currentIndex;

  /// The z-coordinate of this BottomNavigationBar.
  final double? elevation;

  /// Defines the layout and behavior of a BottomNavigationBar.
  final BottomNavigationBarType? type;

  /// The color of the BottomNavigationBar itself.
  final Color? backgroundColor;

  /// The color of the selected BottomNavigationBarItem.icon and BottomNavigationBarItem.label.
  final Color? selectedItemColor;

  /// The color of the unselected BottomNavigationBarItem.icon and BottomNavigationBarItem.label.
  final Color? unselectedItemColor;

  /// The size and color of the icon in the currently selected BottomNavigationBarItem.icon.
  final IconThemeData? selectedIconTheme;

  /// The size and color of the icon in the currently unselected BottomNavigationBarItem.icon.
  final IconThemeData? unselectedIconTheme;

  /// The font size of the BottomNavigationBarItem labels when they are selected.
  final double selectedFontSize;

  /// The font size of the BottomNavigationBarItem labels when they are not selected.
  final double unselectedFontSize;

  /// The TextStyle of the BottomNavigationBarItem labels when they are selected.
  final TextStyle? selectedLabelStyle;

  /// The TextStyle of the BottomNavigationBarItem labels when they are not selected.
  final TextStyle? unselectedLabelStyle;

  /// Whether the labels are shown for the selected BottomNavigationBarItem.
  final bool? showSelectedLabels;

  /// Whether the labels are shown for the unselected BottomNavigationBarItems.
  final bool? showUnselectedLabels;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  final bool? enableFeedback;

  /// Defines the layout of BottomNavigationBar labels in landscape mode.
  final BottomNavigationBarLandscapeLayout? landscapeLayout;

  /// Whether to use the legacy color scheme.
  final bool useLegacyColorScheme;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        items: items,
        onTap: onTap,
        currentIndex: currentIndex,
        elevation: elevation ?? ZoniElevation.sm,
        type: type,
        backgroundColor: backgroundColor ?? ZoniColors.surface,
        selectedItemColor: selectedItemColor ?? ZoniColors.primary,
        unselectedItemColor:
            unselectedItemColor ?? ZoniColors.onSurface.withOpacity(0.6),
        selectedIconTheme: selectedIconTheme,
        unselectedIconTheme: unselectedIconTheme,
        selectedFontSize: selectedFontSize,
        unselectedFontSize: unselectedFontSize,
        selectedLabelStyle: selectedLabelStyle ?? ZoniTextStyles.labelMedium,
        unselectedLabelStyle: unselectedLabelStyle ?? ZoniTextStyles.labelSmall,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        mouseCursor: mouseCursor,
        enableFeedback: enableFeedback,
        landscapeLayout: landscapeLayout,
        useLegacyColorScheme: useLegacyColorScheme,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<BottomNavigationBarItem>('items', items));
    properties.add(ObjectFlagProperty<ValueChanged<int>?>.has('onTap', onTap));
    properties.add(IntProperty('currentIndex', currentIndex));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(EnumProperty<BottomNavigationBarType?>('type', type));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('selectedItemColor', selectedItemColor));
    properties.add(ColorProperty('unselectedItemColor', unselectedItemColor));
    properties.add(
      DiagnosticsProperty<IconThemeData?>(
        'selectedIconTheme',
        selectedIconTheme,
      ),
    );
    properties.add(
      DiagnosticsProperty<IconThemeData?>(
        'unselectedIconTheme',
        unselectedIconTheme,
      ),
    );
    properties.add(DoubleProperty('selectedFontSize', selectedFontSize));
    properties.add(DoubleProperty('unselectedFontSize', unselectedFontSize));
    properties.add(
      DiagnosticsProperty<TextStyle?>(
        'selectedLabelStyle',
        selectedLabelStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<TextStyle?>(
        'unselectedLabelStyle',
        unselectedLabelStyle,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool?>('showSelectedLabels', showSelectedLabels),
    );
    properties.add(
      DiagnosticsProperty<bool?>(
        'showUnselectedLabels',
        showUnselectedLabels,
      ),
    );
    properties
        .add(DiagnosticsProperty<MouseCursor?>('mouseCursor', mouseCursor));
    properties
        .add(DiagnosticsProperty<bool?>('enableFeedback', enableFeedback));
    properties.add(
      EnumProperty<BottomNavigationBarLandscapeLayout?>(
        'landscapeLayout',
        landscapeLayout,
      ),
    );
    properties.add(
      DiagnosticsProperty<bool>(
        'useLegacyColorScheme',
        useLegacyColorScheme,
      ),
    );
  }
}
