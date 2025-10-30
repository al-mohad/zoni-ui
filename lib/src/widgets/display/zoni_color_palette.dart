import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/zoni_colors.dart';

/// A color palette display component for showcasing design system colors.
class ZoniColorPalette extends StatelessWidget {
  /// Creates a color palette component.
  const ZoniColorPalette({
    super.key,
    this.colors = const [],
    this.title,
    this.showHexValues = true,
    this.showColorNames = true,
    this.onColorTap,
    this.itemHeight = 80.0,
    this.itemSpacing = 8.0,
    this.crossAxisCount = 2,
  });

  /// List of colors to display in the palette.
  final List<ZoniColorInfo> colors;

  /// Title for the color palette section.
  final String? title;

  /// Whether to show hex color values.
  final bool showHexValues;

  /// Whether to show color names.
  final bool showColorNames;

  /// Callback when a color is tapped.
  final void Function(ZoniColorInfo color)? onColorTap;

  /// Height of each color item.
  final double itemHeight;

  /// Spacing between color items.
  final double itemSpacing;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Creates a palette with primary colors.
  const ZoniColorPalette.primary({
    super.key,
    this.title = 'Primary Colors',
    this.showHexValues = true,
    this.showColorNames = true,
    this.onColorTap,
    this.itemHeight = 80.0,
    this.itemSpacing = 8.0,
    this.crossAxisCount = 2,
  }) : colors = const [
          ZoniColorInfo('Zoni Blue', ZoniColors.zoniBlue),
          ZoniColorInfo('Zoni Blue Tint', ZoniColors.zoniBlueTint),
          ZoniColorInfo('Fresh Green', ZoniColors.freshGreen),
          ZoniColorInfo('Fresh Green Dark', ZoniColors.freshGreenDark),
        ];

  /// Creates a palette with semantic colors.
  const ZoniColorPalette.semantic({
    super.key,
    this.title = 'Semantic Colors',
    this.showHexValues = true,
    this.showColorNames = true,
    this.onColorTap,
    this.itemHeight = 80.0,
    this.itemSpacing = 8.0,
    this.crossAxisCount = 2,
  }) : colors = const [
          ZoniColorInfo('Success', ZoniColors.success),
          ZoniColorInfo('Warning', ZoniColors.warning),
          ZoniColorInfo('Error', ZoniColors.error),
          ZoniColorInfo('Info', ZoniColors.info),
        ];

  /// Creates a palette with neutral colors.
  const ZoniColorPalette.neutral({
    super.key,
    this.title = 'Neutral Colors',
    this.showHexValues = true,
    this.showColorNames = true,
    this.onColorTap,
    this.itemHeight = 80.0,
    this.itemSpacing = 8.0,
    this.crossAxisCount = 2,
  }) : colors = const [
          ZoniColorInfo('Neutral Gray', ZoniColors.neutralGray),
          ZoniColorInfo('Soft White', ZoniColors.softWhite),
          ZoniColorInfo('Deep Black', ZoniColors.deepBlack),
          ZoniColorInfo('Surface', ZoniColors.surface),
        ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
        ],
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 2.0,
            crossAxisSpacing: itemSpacing,
            mainAxisSpacing: itemSpacing,
          ),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final colorInfo = colors[index];
            return _ColorItem(
              colorInfo: colorInfo,
              showHexValues: showHexValues,
              showColorNames: showColorNames,
              onTap: onColorTap != null ? () => onColorTap!(colorInfo) : null,
              height: itemHeight,
            );
          },
        ),
      ],
    );
  }
}

/// Information about a color in the palette.
class ZoniColorInfo {
  /// Creates color information.
  const ZoniColorInfo(this.name, this.color, {this.description});

  /// Name of the color.
  final String name;

  /// The color value.
  final Color color;

  /// Optional description of the color.
  final String? description;

  /// Gets the hex string representation of the color.
  String get hexString {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}

class _ColorItem extends StatefulWidget {
  const _ColorItem({
    required this.colorInfo,
    required this.showHexValues,
    required this.showColorNames,
    required this.height,
    this.onTap,
  });

  final ZoniColorInfo colorInfo;
  final bool showHexValues;
  final bool showColorNames;
  final double height;
  final VoidCallback? onTap;

  @override
  State<_ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<_ColorItem> {
  bool _isHovered = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.colorInfo.hexString));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied ${widget.colorInfo.hexString} to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.colorInfo.color.computeLuminance() < 0.5;
    final textColor = isDark ? Colors.white : Colors.black;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap ?? _copyToClipboard,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.colorInfo.color,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.3),
              width: 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8.0,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.showColorNames)
                  Text(
                    widget.colorInfo.name,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (widget.showHexValues)
                  Text(
                    widget.colorInfo.hexString,
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.8),
                      fontSize: 12.0,
                      fontFamily: 'monospace',
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
