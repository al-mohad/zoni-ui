import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/zoni_colors.dart';

/// A code block component for displaying syntax-highlighted code.
class ZoniCodeBlock extends StatefulWidget {
  /// Creates a code block component.
  const ZoniCodeBlock({
    super.key,
    required this.code,
    this.language,
    this.title,
    this.showLineNumbers = false,
    this.showCopyButton = true,
    this.maxLines,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// The code content to display.
  final String code;

  /// Programming language for syntax highlighting.
  final String? language;

  /// Optional title for the code block.
  final String? title;

  /// Whether to show line numbers.
  final bool showLineNumbers;

  /// Whether to show the copy button.
  final bool showCopyButton;

  /// Maximum number of lines to display.
  final int? maxLines;

  /// Background color of the code block.
  final Color? backgroundColor;

  /// Text style for the code.
  final TextStyle? textStyle;

  /// Border radius of the code block.
  final double borderRadius;

  /// Padding inside the code block.
  final EdgeInsets padding;

  /// Creates a dark-themed code block.
  const ZoniCodeBlock.dark({
    super.key,
    required this.code,
    this.language,
    this.title,
    this.showLineNumbers = false,
    this.showCopyButton = true,
    this.maxLines,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(16.0),
  })  : backgroundColor = const Color(0xFF1E1E1E),
        textStyle = const TextStyle(
          color: Color(0xFFD4D4D4),
          fontFamily: 'monospace',
          fontSize: 14.0,
        );

  /// Creates a light-themed code block.
  const ZoniCodeBlock.light({
    super.key,
    required this.code,
    this.language,
    this.title,
    this.showLineNumbers = false,
    this.showCopyButton = true,
    this.maxLines,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(16.0),
  })  : backgroundColor = const Color(0xFFF8F8F8),
        textStyle = const TextStyle(
          color: Color(0xFF333333),
          fontFamily: 'monospace',
          fontSize: 14.0,
        );

  @override
  State<ZoniCodeBlock> createState() => _ZoniCodeBlockState();
}

class _ZoniCodeBlockState extends State<ZoniCodeBlock> {
  bool _isHovered = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Color get _backgroundColor {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F8F8);
  }

  TextStyle get _textStyle {
    if (widget.textStyle != null) return widget.textStyle!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      color: isDark ? const Color(0xFFD4D4D4) : const Color(0xFF333333),
      fontFamily: 'monospace',
      fontSize: 14.0,
      height: 1.4,
    );
  }

  List<String> get _lines => widget.code.split('\n');

  @override
  Widget build(BuildContext context) {
    final lines = _lines;
    final displayLines = widget.maxLines != null
        ? lines.take(widget.maxLines!).toList()
        : lines;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: ZoniColors.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null || widget.showCopyButton) _buildHeader(),
            Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: widget.padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: displayLines.asMap().entries.map((entry) {
                      final index = entry.key;
                      final line = entry.value;
                      return _buildCodeLine(index + 1, line);
                    }).toList(),
                  ),
                ),
              ),
            ),
            if (widget.maxLines != null && lines.length > widget.maxLines!)
              _buildTruncationIndicator(lines.length - widget.maxLines!),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: _backgroundColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.borderRadius),
          topRight: Radius.circular(widget.borderRadius),
        ),
        border: Border(
          bottom: BorderSide(
            color: ZoniColors.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.title != null)
            Text(
              widget.title!,
              style: _textStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
              ),
            )
          else
            const SizedBox.shrink(),
          if (widget.showCopyButton)
            AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.6,
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                onPressed: _copyToClipboard,
                icon: Icon(
                  Icons.copy,
                  size: 16.0,
                  color: _textStyle.color,
                ),
                tooltip: 'Copy code',
                constraints: const BoxConstraints(
                  minWidth: 32.0,
                  minHeight: 32.0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCodeLine(int lineNumber, String line) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLineNumbers) ...[
          SizedBox(
            width: 40.0,
            child: Text(
              lineNumber.toString(),
              style: _textStyle.copyWith(
                color: _textStyle.color!.withValues(alpha: 0.5),
                fontSize: 12.0,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 16.0),
        ],
        Expanded(
          child: Text(
            line.isEmpty ? ' ' : line,
            style: _textStyle,
            softWrap: false,
          ),
        ),
      ],
    );
  }

  Widget _buildTruncationIndicator(int hiddenLines) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '... and $hiddenLines more lines',
        style: _textStyle.copyWith(
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
          color: _textStyle.color!.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

/// Predefined code block themes.
class ZoniCodeThemes {
  static const TextStyle darkTheme = TextStyle(
    color: Color(0xFFD4D4D4),
    fontFamily: 'monospace',
    fontSize: 14.0,
    height: 1.4,
  );

  static const TextStyle lightTheme = TextStyle(
    color: Color(0xFF333333),
    fontFamily: 'monospace',
    fontSize: 14.0,
    height: 1.4,
  );

  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color lightBackground = Color(0xFFF8F8F8);
}
