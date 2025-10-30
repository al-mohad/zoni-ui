import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Testimonial data model.
class ZoniTestimonialData {
  /// Creates a testimonial.
  const ZoniTestimonialData({
    required this.content,
    required this.author,
    this.authorTitle,
    this.authorCompany,
    this.avatar,
    this.rating,
    this.date,
  });

  /// The testimonial content/quote.
  final String content;

  /// Author's name.
  final String author;

  /// Author's title or position.
  final String? authorTitle;

  /// Author's company.
  final String? authorCompany;

  /// Author's avatar.
  final Widget? avatar;

  /// Rating given (1-5 stars).
  final int? rating;

  /// Date of the testimonial.
  final DateTime? date;
}

/// A testimonial component for displaying customer reviews and quotes.
class ZoniTestimonial extends StatelessWidget {
  /// Creates a testimonial widget.
  const ZoniTestimonial({
    super.key,
    required this.testimonial,
    this.variant = ZoniTestimonialVariant.card,
    this.showQuotes = true,
    this.showRating = true,
    this.showDate = false,
    this.maxLines,
    this.onTap,
  });

  /// The testimonial data to display.
  final ZoniTestimonialData testimonial;

  /// Display variant of the testimonial.
  final ZoniTestimonialVariant variant;

  /// Whether to show quote marks.
  final bool showQuotes;

  /// Whether to show the rating.
  final bool showRating;

  /// Whether to show the date.
  final bool showDate;

  /// Maximum lines for the content.
  final int? maxLines;

  /// Callback when the testimonial is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ZoniTestimonialVariant.card:
        return _buildCardVariant(context);
      case ZoniTestimonialVariant.compact:
        return _buildCompactVariant(context);
      case ZoniTestimonialVariant.featured:
        return _buildFeaturedVariant(context);
    }
  }

  Widget _buildCardVariant(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showRating && testimonial.rating != null) ...[
                _buildRating(context, theme),
                const SizedBox(height: 12.0),
              ],
              _buildContent(context, theme),
              const SizedBox(height: 16.0),
              _buildAuthorInfo(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactVariant(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(context, theme, size: 40.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showRating && testimonial.rating != null) ...[
                    _buildRating(context, theme, size: 14.0),
                    const SizedBox(height: 4.0),
                  ],
                  _buildContent(context, theme, compact: true),
                  const SizedBox(height: 8.0),
                  _buildAuthorInfo(context, theme, compact: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedVariant(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ZoniColors.primary.withOpacity(0.05),
            ZoniColors.primary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: ZoniColors.primary.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          children: [
            if (showQuotes)
              Icon(
                Icons.format_quote,
                size: 48.0,
                color: ZoniColors.primary.withOpacity(0.3),
              ),
            const SizedBox(height: 16.0),
            _buildContent(context, theme, featured: true),
            const SizedBox(height: 24.0),
            if (showRating && testimonial.rating != null) ...[
              _buildRating(context, theme, size: 20.0),
              const SizedBox(height: 16.0),
            ],
            _buildAuthorInfo(context, theme, featured: true),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ThemeData theme, {
    bool compact = false,
    bool featured = false,
  }) {
    TextStyle? textStyle;
    if (featured) {
      textStyle = theme.textTheme.headlineSmall?.copyWith(
        fontStyle: FontStyle.italic,
        height: 1.4,
      );
    } else if (compact) {
      textStyle = theme.textTheme.bodyMedium;
    } else {
      textStyle = theme.textTheme.bodyLarge?.copyWith(
        height: 1.5,
      );
    }

    String content = testimonial.content;
    if (showQuotes && !featured) {
      content = '"$content"';
    }

    return Text(
      content,
      style: textStyle,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  Widget _buildRating(BuildContext context, ThemeData theme, {double size = 16.0}) {
    if (testimonial.rating == null) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < testimonial.rating! ? Icons.star : Icons.star_border,
          size: size,
          color: ZoniColors.warning,
        );
      }),
    );
  }

  Widget _buildAuthorInfo(
    BuildContext context,
    ThemeData theme, {
    bool compact = false,
    bool featured = false,
  }) {
    return Row(
      children: [
        if (!compact) ...[
          _buildAvatar(context, theme),
          const SizedBox(width: 12.0),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                testimonial.author,
                style: (featured 
                    ? theme.textTheme.titleMedium 
                    : theme.textTheme.bodyLarge)?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (testimonial.authorTitle != null || testimonial.authorCompany != null) ...[
                const SizedBox(height: 2.0),
                Text(
                  [
                    if (testimonial.authorTitle != null) testimonial.authorTitle!,
                    if (testimonial.authorCompany != null) testimonial.authorCompany!,
                  ].join(' at '),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
              if (showDate && testimonial.date != null) ...[
                const SizedBox(height: 2.0),
                Text(
                  _formatDate(testimonial.date!),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, ThemeData theme, {double size = 48.0}) {
    if (testimonial.avatar != null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: testimonial.avatar!,
        ),
      );
    }

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: ZoniColors.primary.withOpacity(0.1),
      child: Text(
        testimonial.author.isNotEmpty ? testimonial.author[0].toUpperCase() : '?',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: ZoniColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

/// Testimonial display variants.
enum ZoniTestimonialVariant {
  /// Card variant with full layout.
  card,
  /// Compact variant for lists.
  compact,
  /// Featured variant with emphasis.
  featured,
}

/// A carousel widget for displaying multiple testimonials.
class ZoniTestimonialCarousel extends StatefulWidget {
  /// Creates a testimonial carousel.
  const ZoniTestimonialCarousel({
    super.key,
    required this.testimonials,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.showIndicators = true,
    this.height = 300.0,
  });

  /// List of testimonials to display.
  final List<ZoniTestimonialData> testimonials;

  /// Whether to auto-play the carousel.
  final bool autoPlay;

  /// Auto-play interval.
  final Duration autoPlayInterval;

  /// Whether to show page indicators.
  final bool showIndicators;

  /// Height of the carousel.
  final double height;

  @override
  State<ZoniTestimonialCarousel> createState() => _ZoniTestimonialCarouselState();
}

class _ZoniTestimonialCarouselState extends State<ZoniTestimonialCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    if (widget.autoPlay && widget.testimonials.length > 1) {
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    Future.delayed(widget.autoPlayInterval, () {
      if (mounted) {
        final nextIndex = (_currentIndex + 1) % widget.testimonials.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startAutoPlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.testimonials.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.testimonials.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ZoniTestimonial(
                  testimonial: widget.testimonials[index],
                  variant: ZoniTestimonialVariant.featured,
                ),
              );
            },
          ),
        ),
        if (widget.showIndicators && widget.testimonials.length > 1) ...[
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.testimonials.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentIndex
                      ? ZoniColors.primary
                      : ZoniColors.primary.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
