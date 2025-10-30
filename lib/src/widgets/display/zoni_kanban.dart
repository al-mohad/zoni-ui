import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Kanban card data model.
class ZoniKanbanCard {
  /// Creates a kanban card.
  const ZoniKanbanCard({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.tags = const [],
    this.assignee,
    this.priority,
    this.dueDate,
    this.color,
    this.avatar,
    this.customWidget,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  /// Unique identifier for the card.
  final String id;

  /// Title of the card.
  final String title;

  /// Optional subtitle.
  final String? subtitle;

  /// Optional description.
  final String? description;

  /// Tags associated with the card.
  final List<String> tags;

  /// Assignee name.
  final String? assignee;

  /// Priority level.
  final String? priority;

  /// Due date.
  final DateTime? dueDate;

  /// Card color.
  final Color? color;

  /// Avatar widget for assignee.
  final Widget? avatar;

  /// Custom widget to display in card.
  final Widget? customWidget;

  /// Callback when card is tapped.
  final VoidCallback? onTap;

  /// Callback when card is edited.
  final VoidCallback? onEdit;

  /// Callback when card is deleted.
  final VoidCallback? onDelete;
}

/// Kanban column data model.
class ZoniKanbanColumn {
  /// Creates a kanban column.
  const ZoniKanbanColumn({
    required this.id,
    required this.title,
    required this.cards,
    this.subtitle,
    this.color,
    this.maxCards,
    this.collapsed = false,
    this.onAddCard,
    this.onEditColumn,
    this.onDeleteColumn,
    this.headerWidget,
    this.footerWidget,
  });

  /// Unique identifier for the column.
  final String id;

  /// Title of the column.
  final String title;

  /// Cards in this column.
  final List<ZoniKanbanCard> cards;

  /// Optional subtitle.
  final String? subtitle;

  /// Column color.
  final Color? color;

  /// Maximum number of cards allowed.
  final int? maxCards;

  /// Whether the column is collapsed.
  final bool collapsed;

  /// Callback to add new card.
  final VoidCallback? onAddCard;

  /// Callback to edit column.
  final VoidCallback? onEditColumn;

  /// Callback to delete column.
  final VoidCallback? onDeleteColumn;

  /// Custom header widget.
  final Widget? headerWidget;

  /// Custom footer widget.
  final Widget? footerWidget;
}

/// Kanban board component for project management.
class ZoniKanban extends StatefulWidget {
  /// Creates a kanban board.
  const ZoniKanban({
    super.key,
    required this.columns,
    this.onCardMoved,
    this.onColumnReordered,
    this.cardBuilder,
    this.columnHeaderBuilder,
    this.emptyColumnBuilder,
    this.scrollable = true,
    this.physics,
    this.columnWidth = 300.0,
    this.columnSpacing = 16.0,
    this.cardSpacing = 8.0,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.columnBackgroundColor,
    this.cardBackgroundColor,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.showColumnCount = true,
    this.allowColumnReorder = false,
    this.allowCardDrag = true,
    this.maxColumnHeight,
  });

  /// Columns in the kanban board.
  final List<ZoniKanbanColumn> columns;

  /// Callback when card is moved between columns.
  final void Function(String cardId, String fromColumnId, String toColumnId, int newIndex)? onCardMoved;

  /// Callback when columns are reordered.
  final void Function(int oldIndex, int newIndex)? onColumnReordered;

  /// Custom card builder.
  final Widget Function(BuildContext context, ZoniKanbanCard card)? cardBuilder;

  /// Custom column header builder.
  final Widget Function(BuildContext context, ZoniKanbanColumn column)? columnHeaderBuilder;

  /// Custom empty column builder.
  final Widget Function(BuildContext context, ZoniKanbanColumn column)? emptyColumnBuilder;

  /// Whether the board is scrollable.
  final bool scrollable;

  /// Scroll physics.
  final ScrollPhysics? physics;

  /// Width of each column.
  final double columnWidth;

  /// Spacing between columns.
  final double columnSpacing;

  /// Spacing between cards.
  final double cardSpacing;

  /// Padding around the board.
  final EdgeInsets padding;

  /// Background color of the board.
  final Color? backgroundColor;

  /// Background color of columns.
  final Color? columnBackgroundColor;

  /// Background color of cards.
  final Color? cardBackgroundColor;

  /// Border radius for cards and columns.
  final double borderRadius;

  /// Elevation for cards and columns.
  final double elevation;

  /// Whether to show card count in column headers.
  final bool showColumnCount;

  /// Whether columns can be reordered.
  final bool allowColumnReorder;

  /// Whether cards can be dragged.
  final bool allowCardDrag;

  /// Maximum height for columns.
  final double? maxColumnHeight;

  @override
  State<ZoniKanban> createState() => _ZoniKanbanState();
}

class _ZoniKanbanState extends State<ZoniKanban> {
  late List<ZoniKanbanColumn> _columns;

  @override
  void initState() {
    super.initState();
    _columns = List.from(widget.columns);
  }

  @override
  void didUpdateWidget(ZoniKanban oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.columns != oldWidget.columns) {
      _columns = List.from(widget.columns);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      padding: widget.padding,
      child: widget.scrollable
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: widget.physics,
              child: _buildBoard(),
            )
          : _buildBoard(),
    );
  }

  Widget _buildBoard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _columns.asMap().entries.map((entry) {
        final index = entry.key;
        final column = entry.value;
        return Padding(
          padding: EdgeInsets.only(
            right: index < _columns.length - 1 ? widget.columnSpacing : 0,
          ),
          child: _buildColumn(column, index),
        );
      }).toList(),
    );
  }

  Widget _buildColumn(ZoniKanbanColumn column, int columnIndex) {
    final theme = Theme.of(context);

    return Container(
      width: widget.columnWidth,
      constraints: widget.maxColumnHeight != null
          ? BoxConstraints(maxHeight: widget.maxColumnHeight!)
          : null,
      decoration: BoxDecoration(
        color: widget.columnBackgroundColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: widget.elevation,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumnHeader(column),
          if (!column.collapsed) ...[
            Expanded(
              child: _buildColumnContent(column),
            ),
            if (column.footerWidget != null) column.footerWidget!,
          ],
        ],
      ),
    );
  }

  Widget _buildColumnHeader(ZoniKanbanColumn column) {
    if (widget.columnHeaderBuilder != null) {
      return widget.columnHeaderBuilder!(context, column);
    }

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: column.color?.withValues(alpha: 0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.borderRadius),
          topRight: Radius.circular(widget.borderRadius),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        column.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: column.color,
                        ),
                      ),
                    ),
                    if (widget.showColumnCount)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: column.color ?? ZoniColors.primary,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          '${column.cards.length}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                if (column.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      column.subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'add':
                  column.onAddCard?.call();
                  break;
                case 'edit':
                  column.onEditColumn?.call();
                  break;
                case 'delete':
                  column.onDeleteColumn?.call();
                  break;
              }
            },
            itemBuilder: (context) => [
              if (column.onAddCard != null)
                const PopupMenuItem(
                  value: 'add',
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8.0),
                      Text('Add Card'),
                    ],
                  ),
                ),
              if (column.onEditColumn != null)
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8.0),
                      Text('Edit Column'),
                    ],
                  ),
                ),
              if (column.onDeleteColumn != null)
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8.0),
                      Text('Delete Column'),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumnContent(ZoniKanbanColumn column) {
    if (column.cards.isEmpty) {
      return widget.emptyColumnBuilder?.call(context, column) ??
          _buildEmptyColumn(column);
    }

    return DragTarget<Map<String, dynamic>>(
      onAccept: (data) {
        final cardId = data['cardId'] as String;
        final fromColumnId = data['fromColumnId'] as String;
        
        if (fromColumnId != column.id) {
          widget.onCardMoved?.call(cardId, fromColumnId, column.id, column.cards.length);
        }
      },
      builder: (context, candidateData, rejectedData) {
        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: column.cards.length,
          separatorBuilder: (context, index) => SizedBox(height: widget.cardSpacing),
          itemBuilder: (context, index) {
            return _buildCard(column.cards[index], column.id);
          },
        );
      },
    );
  }

  Widget _buildEmptyColumn(ZoniKanbanColumn column) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48.0,
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16.0),
            Text(
              'No cards',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
              ),
            ),
            if (column.onAddCard != null) ...[
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: column.onAddCard,
                icon: const Icon(Icons.add),
                label: const Text('Add Card'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: column.color ?? ZoniColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCard(ZoniKanbanCard card, String columnId) {
    if (widget.cardBuilder != null) {
      return widget.cardBuilder!(context, card);
    }

    final theme = Theme.of(context);

    Widget cardContent = Material(
      color: widget.cardBackgroundColor ?? theme.cardColor,
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: InkWell(
        onTap: card.onTap,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (card.color != null)
                Container(
                  height: 4.0,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  decoration: BoxDecoration(
                    color: card.color,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              Text(
                card.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (card.subtitle != null) ...[
                const SizedBox(height: 4.0),
                Text(
                  card.subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ],
              if (card.description != null) ...[
                const SizedBox(height: 8.0),
                Text(
                  card.description!,
                  style: theme.textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (card.tags.isNotEmpty) ...[
                const SizedBox(height: 12.0),
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: card.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: ZoniColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        tag,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: ZoniColors.primary,
                          fontSize: 10.0,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (card.assignee != null || card.dueDate != null || card.priority != null) ...[
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    if (card.avatar != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: card.avatar,
                        ),
                      ),
                    if (card.assignee != null && card.avatar == null)
                      Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: ZoniColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            card.assignee!.substring(0, 1).toUpperCase(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    const Spacer(),
                    if (card.priority != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(card.priority!),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          card.priority!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 9.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (card.dueDate != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Icon(
                          Icons.schedule,
                          size: 16.0,
                          color: _getDueDateColor(card.dueDate!),
                        ),
                      ),
                  ],
                ),
              ],
              if (card.customWidget != null) ...[
                const SizedBox(height: 12.0),
                card.customWidget!,
              ],
            ],
          ),
        ),
      ),
    );

    if (widget.allowCardDrag) {
      cardContent = Draggable<Map<String, dynamic>>(
        data: {
          'cardId': card.id,
          'fromColumnId': columnId,
        },
        feedback: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            width: widget.columnWidth - 32.0,
            child: cardContent,
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.5,
          child: cardContent,
        ),
        child: cardContent,
      );
    }

    return cardContent;
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
      case 'urgent':
        return ZoniColors.error;
      case 'medium':
        return ZoniColors.warning;
      case 'low':
        return ZoniColors.success;
      default:
        return ZoniColors.neutralGray;
    }
  }

  Color _getDueDateColor(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (difference < 0) {
      return ZoniColors.error; // Overdue
    } else if (difference <= 1) {
      return ZoniColors.warning; // Due soon
    } else {
      return ZoniColors.neutralGray; // Normal
    }
  }
}
