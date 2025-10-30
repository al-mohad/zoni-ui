import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// Media types supported by ZoniMedia components.
enum ZoniMediaType {
  image,
  video,
  audio,
  document,
}

/// A media display component with support for images, videos, and other media types.
class ZoniMedia extends StatelessWidget {
  /// Creates a [ZoniMedia].
  const ZoniMedia({
    required this.src,
    super.key,
    this.type = ZoniMediaType.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.showControls = true,
    this.autoPlay = false,
    this.loop = false,
  });

  /// The source URL or path for the media.
  final String src;

  /// The type of media.
  final ZoniMediaType type;

  /// Width of the media container.
  final double? width;

  /// Height of the media container.
  final double? height;

  /// How the media should fit within its container.
  final BoxFit fit;

  /// Border radius for the media container.
  final BorderRadius? borderRadius;

  /// Placeholder widget while loading.
  final Widget? placeholder;

  /// Widget to show on error.
  final Widget? errorWidget;

  /// Callback when the media is tapped.
  final VoidCallback? onTap;

  /// Whether to show media controls (for video/audio).
  final bool showControls;

  /// Whether to auto-play media (for video/audio).
  final bool autoPlay;

  /// Whether to loop media (for video/audio).
  final bool loop;

  @override
  Widget build(BuildContext context) {
    Widget media;

    switch (type) {
      case ZoniMediaType.image:
        media = _buildImage();
        break;
      case ZoniMediaType.video:
        media = _buildVideo();
        break;
      case ZoniMediaType.audio:
        media = _buildAudio();
        break;
      case ZoniMediaType.document:
        media = _buildDocument();
        break;
    }

    if (onTap != null) {
      media = InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: media,
      );
    }

    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:
            borderRadius ?? BorderRadius.circular(ZoniBorderRadius.md),
      ),
      child: media,
    );
  }

  Widget _buildImage() {
    if (src.startsWith('http')) {
      return Image.network(
        src,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ?? _buildPlaceholder(ZoniMediaType.image);
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) =>
                errorWidget ?? _buildErrorWidget(ZoniMediaType.image),
      );
    } else {
      return Image.asset(
        src,
        width: width,
        height: height,
        fit: fit,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) =>
                errorWidget ?? _buildErrorWidget(ZoniMediaType.image),
      );
    }
  }

  Widget _buildVideo() {
    // Placeholder for video player implementation
    return Container(
      width: width,
      height: height,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Icon(
            Icons.play_circle_outline,
            size: 64,
            color: Colors.white,
          ),
          if (showControls)
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.3, // Progress placeholder
                  child: Container(
                    decoration: BoxDecoration(
                      color: ZoniColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAudio() => Container(
        width: width,
        height: height ?? 80,
        decoration: BoxDecoration(
          color: ZoniColors.surface,
          borderRadius:
              borderRadius ?? BorderRadius.circular(ZoniBorderRadius.md),
          border: Border.all(color: ZoniColors.outline),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(ZoniSpacing.sm),
              decoration: BoxDecoration(
                color: ZoniColors.primary,
                borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
              ),
              child: const Icon(
                Icons.audiotrack,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Audio File',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ZoniColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: ZoniSpacing.xs),
                  Text(
                    src.split('/').last,
                    style: TextStyle(
                      fontSize: 12,
                      color: ZoniColors.onSurface.withValues(alpha: 0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (showControls)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
              ),
          ],
        ),
      );

  Widget _buildDocument() {
    final String extension = src.split('.').last.toLowerCase();
    IconData icon;
    Color iconColor;

    switch (extension) {
      case 'pdf':
        icon = Icons.picture_as_pdf;
        iconColor = ZoniColors.error;
        break;
      case 'doc':
      case 'docx':
        icon = Icons.description;
        iconColor = ZoniColors.primary;
        break;
      case 'xls':
      case 'xlsx':
        icon = Icons.table_chart;
        iconColor = ZoniColors.freshGreen;
        break;
      case 'ppt':
      case 'pptx':
        icon = Icons.slideshow;
        iconColor = ZoniColors.warning;
        break;
      default:
        icon = Icons.insert_drive_file;
        iconColor = ZoniColors.primary;
    }

    return Container(
      width: width,
      height: height ?? 100,
      decoration: BoxDecoration(
        color: ZoniColors.surface,
        borderRadius:
            borderRadius ?? BorderRadius.circular(ZoniBorderRadius.md),
        border: Border.all(color: ZoniColors.outline),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 48,
            color: iconColor,
          ),
          const SizedBox(height: ZoniSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZoniSpacing.sm),
            child: Text(
              src.split('/').last,
              style: const TextStyle(
                fontSize: 12,
                color: ZoniColors.onSurface,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(ZoniMediaType type) {
    IconData icon;
    switch (type) {
      case ZoniMediaType.image:
        icon = Icons.image;
        break;
      case ZoniMediaType.video:
        icon = Icons.videocam;
        break;
      case ZoniMediaType.audio:
        icon = Icons.audiotrack;
        break;
      case ZoniMediaType.document:
        icon = Icons.insert_drive_file;
        break;
    }

    return Container(
      width: width,
      height: height,
      color: ZoniColors.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 48,
            color: ZoniColors.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: ZoniSpacing.sm),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(ZoniMediaType type) => Container(
        width: width,
        height: height,
        color: ZoniColors.error,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.error_outline,
              size: 48,
              color: ZoniColors.error,
            ),
            const SizedBox(height: ZoniSpacing.sm),
            Text(
              'Failed to load ${type.name}',
              style: const TextStyle(
                color: ZoniColors.error,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('src', src));
    properties.add(EnumProperty<ZoniMediaType>('type', type));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('height', height));
    properties.add(EnumProperty<BoxFit>('fit', fit));
    properties.add(FlagProperty('showControls',
        value: showControls, ifTrue: 'showControls'));
    properties
        .add(FlagProperty('autoPlay', value: autoPlay, ifTrue: 'autoPlay'));
    properties.add(FlagProperty('loop', value: loop, ifTrue: 'loop'));
    properties
        .add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius));
    properties.add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
  }
}

/// A media gallery component for displaying multiple media items.
class ZoniMediaGallery extends StatefulWidget {
  /// Creates a [ZoniMediaGallery].
  const ZoniMediaGallery({
    required this.items,
    super.key,
    this.crossAxisCount = 2,
    this.spacing = 8.0,
    this.aspectRatio = 1.0,
    this.onItemTap,
  });

  /// List of media items to display.
  final List<ZoniMediaItem> items;

  /// Number of items per row.
  final int crossAxisCount;

  /// Spacing between items.
  final double spacing;

  /// Aspect ratio of each item.
  final double aspectRatio;

  /// Callback when an item is tapped.
  final void Function(ZoniMediaItem item, int index)? onItemTap;

  @override
  State<ZoniMediaGallery> createState() => _ZoniMediaGalleryState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<ZoniMediaItem>('items', items));
    properties.add(IntProperty('crossAxisCount', crossAxisCount));
    properties.add(DoubleProperty('spacing', spacing));
    properties.add(DoubleProperty('aspectRatio', aspectRatio));
    properties.add(
        ObjectFlagProperty<void Function(ZoniMediaItem item, int index)?>.has(
            'onItemTap', onItemTap));
  }
}

class _ZoniMediaGalleryState extends State<ZoniMediaGallery> {
  @override
  Widget build(BuildContext context) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: widget.spacing,
          mainAxisSpacing: widget.spacing,
          childAspectRatio: widget.aspectRatio,
        ),
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final ZoniMediaItem item = widget.items[index];
          return ZoniMedia(
            src: item.src,
            type: item.type,
            onTap: () => widget.onItemTap?.call(item, index),
          );
        },
      );
}

/// A media item data model for use with [ZoniMediaGallery].
class ZoniMediaItem {
  /// Creates a [ZoniMediaItem].
  const ZoniMediaItem({
    required this.src,
    required this.type,
    this.title,
    this.description,
    this.thumbnail,
  });

  /// The source URL or path for the media.
  final String src;

  /// The type of media.
  final ZoniMediaType type;

  /// Optional title for the media.
  final String? title;

  /// Optional description for the media.
  final String? description;

  /// Optional thumbnail URL for videos.
  final String? thumbnail;
}
