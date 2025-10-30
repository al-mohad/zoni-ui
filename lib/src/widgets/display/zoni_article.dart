import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../theme/zoni_colors.dart';
import '../../constants/zoni_constants.dart';

/// An article content component for displaying blog posts and articles.
class ZoniArticle extends StatelessWidget {
  /// Creates a [ZoniArticle].
  const ZoniArticle({
    required this.title,
    required this.content,
    super.key,
    this.author,
    this.publishDate,
    this.readTime,
    this.tags = const <String>[],
    this.featuredImage,
    this.excerpt,
    this.showMetadata = true,
    this.onTagTap,
    this.onAuthorTap,
    this.actions = const <Widget>[],
  });

  /// The article title.
  final String title;

  /// The article content.
  final String content;

  /// Optional author information.
  final ZoniAuthor? author;

  /// Publication date.
  final DateTime? publishDate;

  /// Estimated read time.
  final String? readTime;

  /// Article tags.
  final List<String> tags;

  /// Optional featured image.
  final String? featuredImage;

  /// Optional article excerpt.
  final String? excerpt;

  /// Whether to show metadata (author, date, read time).
  final bool showMetadata;

  /// Callback when a tag is tapped.
  final void Function(String tag)? onTagTap;

  /// Callback when the author is tapped.
  final VoidCallback? onAuthorTap;

  /// Action buttons for the article.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (featuredImage != null) ...<Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(ZoniBorderRadius.lg),
            child: Image.network(
              featuredImage!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) =>
                  Container(
                width: double.infinity,
                height: 200,
                color: ZoniColors.surface,
                child: Icon(
                  Icons.image_not_supported,
                  size: 48,
                  color: ZoniColors.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: ZoniSpacing.lg),
        ],

        // Title
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        if (showMetadata) ...<Widget>[
          const SizedBox(height: ZoniSpacing.md),
          _buildMetadata(theme),
        ],

        if (excerpt != null) ...<Widget>[
          const SizedBox(height: ZoniSpacing.md),
          Text(
            excerpt!,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],

        const SizedBox(height: ZoniSpacing.lg),

        // Content
        Text(
          content,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        ),

        if (tags.isNotEmpty) ...<Widget>[
          const SizedBox(height: ZoniSpacing.lg),
          _buildTags(theme),
        ],

        if (actions.isNotEmpty) ...<Widget>[
          const SizedBox(height: ZoniSpacing.lg),
          Row(
            children: actions,
          ),
        ],
      ],
    );
  }

  Widget _buildMetadata(ThemeData theme) {
    final List<Widget> metadataItems = <Widget>[];

    if (author != null) {
      metadataItems.add(
        InkWell(
          onTap: onAuthorTap,
          borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (author!.avatar != null) ...<Widget>[
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(author!.avatar!),
                ),
                const SizedBox(width: ZoniSpacing.xs),
              ],
              Text(
                author!.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ZoniColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (publishDate != null) {
      metadataItems.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              size: 14,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            const SizedBox(width: ZoniSpacing.xs),
            Text(
              _formatDate(publishDate!),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    if (readTime != null) {
      metadataItems.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.access_time,
              size: 14,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            const SizedBox(width: ZoniSpacing.xs),
            Text(
              readTime!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: ZoniSpacing.md,
      runSpacing: ZoniSpacing.xs,
      children: metadataItems,
    );
  }

  Widget _buildTags(ThemeData theme) => Wrap(
        spacing: ZoniSpacing.xs,
        runSpacing: ZoniSpacing.xs,
        children: tags
            .map(
              (String tag) => InkWell(
                onTap: () => onTagTap?.call(tag),
                borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ZoniSpacing.sm,
                    vertical: ZoniSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: ZoniColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
                    border: Border.all(
                      color: ZoniColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    '#$tag',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: ZoniColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );

  String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('content', content));
    properties.add(StringProperty('excerpt', excerpt));
    properties.add(StringProperty('featuredImage', featuredImage));
    properties.add(StringProperty('readTime', readTime));
    properties.add(IterableProperty<String>('tags', tags));
    properties.add(FlagProperty('showMetadata',
        value: showMetadata, ifTrue: 'showMetadata'));
    properties.add(DiagnosticsProperty<ZoniAuthor?>('author', author));
    properties.add(DiagnosticsProperty<DateTime?>('publishDate', publishDate));
    properties.add(ObjectFlagProperty<void Function(String tag)?>.has(
        'onTagTap', onTagTap));
    properties
        .add(ObjectFlagProperty<VoidCallback?>.has('onAuthorTap', onAuthorTap));
  }
}

/// Author information for articles.
class ZoniAuthor {
  /// Creates a [ZoniAuthor].
  const ZoniAuthor({
    required this.name,
    this.bio,
    this.avatar,
    this.email,
    this.website,
    this.socialLinks = const <String, String>{},
  });

  /// The author's name.
  final String name;

  /// Optional bio.
  final String? bio;

  /// Optional avatar URL.
  final String? avatar;

  /// Optional email.
  final String? email;

  /// Optional website URL.
  final String? website;

  /// Social media links.
  final Map<String, String> socialLinks;
}

/// A compact article card for article lists.
class ZoniArticleCard extends StatelessWidget {
  /// Creates a [ZoniArticleCard].
  const ZoniArticleCard({
    required this.title,
    required this.excerpt,
    super.key,
    this.author,
    this.publishDate,
    this.readTime,
    this.featuredImage,
    this.tags = const <String>[],
    this.onTap,
    this.onTagTap,
  });

  /// The article title.
  final String title;

  /// The article excerpt.
  final String excerpt;

  /// Optional author information.
  final ZoniAuthor? author;

  /// Publication date.
  final DateTime? publishDate;

  /// Estimated read time.
  final String? readTime;

  /// Optional featured image.
  final String? featuredImage;

  /// Article tags.
  final List<String> tags;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  /// Callback when a tag is tapped.
  final void Function(String tag)? onTagTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(ZoniSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (featuredImage != null) ...<Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(ZoniBorderRadius.sm),
                  child: Image.network(
                    featuredImage!,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) =>
                        Container(
                      width: double.infinity,
                      height: 120,
                      color: ZoniColors.surface,
                      child: Icon(
                        Icons.image_not_supported,
                        color: ZoniColors.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: ZoniSpacing.sm),
              ],
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: ZoniSpacing.xs),
              Text(
                excerpt,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: ZoniSpacing.sm),
              Row(
                children: <Widget>[
                  if (author != null) ...<Widget>[
                    Text(
                      author!.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ZoniColors.primary,
                      ),
                    ),
                    const SizedBox(width: ZoniSpacing.sm),
                  ],
                  if (publishDate != null) ...<Widget>[
                    Text(
                      _formatDate(publishDate!),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(width: ZoniSpacing.sm),
                  ],
                  if (readTime != null)
                    Text(
                      readTime!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
              if (tags.isNotEmpty) ...<Widget>[
                const SizedBox(height: ZoniSpacing.sm),
                Wrap(
                  spacing: ZoniSpacing.xs,
                  children: tags
                      .take(3)
                      .map(
                        (String tag) => InkWell(
                          onTap: () => onTagTap?.call(tag),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: ZoniSpacing.xs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: ZoniColors.primary.withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(ZoniBorderRadius.sm),
                            ),
                            child: Text(
                              tag,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: ZoniColors.primary,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('excerpt', excerpt));
    properties.add(StringProperty('featuredImage', featuredImage));
    properties.add(StringProperty('readTime', readTime));
    properties.add(IterableProperty<String>('tags', tags));
    properties.add(DiagnosticsProperty<ZoniAuthor?>('author', author));
    properties.add(DiagnosticsProperty<DateTime?>('publishDate', publishDate));
    properties.add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
    properties.add(ObjectFlagProperty<void Function(String tag)?>.has(
        'onTagTap', onTagTap));
  }
}
