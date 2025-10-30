import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Empty state component for displaying when there's no data.
class ZoniEmptyState extends StatelessWidget {
  /// Creates an empty state widget.
  const ZoniEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.illustration,
    this.action,
    this.padding = const EdgeInsets.all(32.0),
  });

  /// The main title text.
  final String title;

  /// Optional description text.
  final String? description;

  /// Optional icon to display.
  final IconData? icon;

  /// Optional illustration widget.
  final Widget? illustration;

  /// Optional action button.
  final Widget? action;

  /// Padding around the content.
  final EdgeInsets padding;

  /// Creates an empty state for no data.
  const ZoniEmptyState.noData({
    super.key,
    this.title = 'No data available',
    this.description = 'There is no data to display at the moment.',
    this.icon = Icons.inbox_outlined,
    this.illustration,
    this.action,
    this.padding = const EdgeInsets.all(32.0),
  });

  /// Creates an empty state for no results.
  const ZoniEmptyState.noResults({
    super.key,
    this.title = 'No results found',
    this.description = 'Try adjusting your search or filter criteria.',
    this.icon = Icons.search_off,
    this.illustration,
    this.action,
    this.padding = const EdgeInsets.all(32.0),
  });

  /// Creates an empty state for errors.
  const ZoniEmptyState.error({
    super.key,
    this.title = 'Something went wrong',
    this.description = 'We encountered an error while loading your data.',
    this.icon = Icons.error_outline,
    this.illustration,
    this.action,
    this.padding = const EdgeInsets.all(32.0),
  });

  /// Creates an empty state for offline.
  const ZoniEmptyState.offline({
    super.key,
    this.title = 'You\'re offline',
    this.description = 'Check your internet connection and try again.',
    this.icon = Icons.wifi_off,
    this.illustration,
    this.action,
    this.padding = const EdgeInsets.all(32.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (illustration != null) ...[
            illustration!,
            const SizedBox(height: 24.0),
          ] else if (icon != null) ...[
            Icon(
              icon,
              size: 64.0,
              color: ZoniColors.neutralGray.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24.0),
          ],
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(height: 8.0),
            Text(
              description!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 24.0),
            action!,
          ],
        ],
      ),
    );
  }
}

/// Empty state for lists and grids.
class ZoniEmptyList extends StatelessWidget {
  /// Creates an empty list widget.
  const ZoniEmptyList({
    super.key,
    this.title = 'No items',
    this.description = 'There are no items to display.',
    this.icon = Icons.list_alt,
    this.action,
  });

  /// The main title text.
  final String title;

  /// Optional description text.
  final String? description;

  /// Icon to display.
  final IconData icon;

  /// Optional action button.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZoniEmptyState(
        title: title,
        description: description,
        icon: icon,
        action: action,
        padding: const EdgeInsets.all(24.0),
      ),
    );
  }
}

/// Empty state for search results.
class ZoniEmptySearch extends StatelessWidget {
  /// Creates an empty search widget.
  const ZoniEmptySearch({
    super.key,
    this.query,
    this.onClear,
  });

  /// The search query that returned no results.
  final String? query;

  /// Callback to clear the search.
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final String title = query != null 
        ? 'No results for "$query"'
        : 'No results found';

    return Center(
      child: ZoniEmptyState.noResults(
        title: title,
        description: 'Try searching for something else or check your spelling.',
        action: onClear != null
            ? TextButton(
                onPressed: onClear,
                child: const Text('Clear search'),
              )
            : null,
      ),
    );
  }
}
