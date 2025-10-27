import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/zoni_colors.dart';
import '../../theme/zoni_text_styles.dart';
import '../../constants/zoni_constants.dart';

/// Enum for file upload variants
enum ZoniFileUploadVariant {
  standard,
  outlined,
  filled,
  dashed,
}

/// Enum for file upload sizes
enum ZoniFileUploadSize {
  small,
  medium,
  large,
}

/// Represents an uploaded file
class ZoniUploadedFile {
  const ZoniUploadedFile({
    required this.name,
    required this.size,
    required this.type,
    this.path,
    this.data,
    this.uploadProgress = 0.0,
    this.isUploading = false,
    this.isUploaded = false,
    this.error,
  });

  final String name;
  final int size;
  final String type;
  final String? path;
  final Uint8List? data;
  final double uploadProgress;
  final bool isUploading;
  final bool isUploaded;
  final String? error;

  ZoniUploadedFile copyWith({
    String? name,
    int? size,
    String? type,
    String? path,
    Uint8List? data,
    double? uploadProgress,
    bool? isUploading,
    bool? isUploaded,
    String? error,
  }) {
    return ZoniUploadedFile(
      name: name ?? this.name,
      size: size ?? this.size,
      type: type ?? this.type,
      path: path ?? this.path,
      data: data ?? this.data,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      isUploading: isUploading ?? this.isUploading,
      isUploaded: isUploaded ?? this.isUploaded,
      error: error ?? this.error,
    );
  }

  String get formattedSize {
    if (size < 1024) return '${size}B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)}KB';
    if (size < 1024 * 1024 * 1024) return '${(size / (1024 * 1024)).toStringAsFixed(1)}MB';
    return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }
}

/// A customizable file upload widget following Zoni design system
class ZoniFileUpload extends StatefulWidget {
  /// Creates a ZoniFileUpload
  const ZoniFileUpload({
    super.key,
    this.onFilesSelected,
    this.onFileRemoved,
    this.onUploadProgress,
    this.onUploadComplete,
    this.onUploadError,
    this.variant = ZoniFileUploadVariant.standard,
    this.size = ZoniFileUploadSize.medium,
    this.acceptedFileTypes = const ['*'],
    this.maxFileSize = 10 * 1024 * 1024, // 10MB
    this.maxFiles = 1,
    this.dragAndDrop = true,
    this.showProgress = true,
    this.showFileList = true,
    this.allowRemove = true,
    this.disabled = false,
    this.title,
    this.subtitle,
    this.icon,
    this.buttonText,
    this.dragOverText,
    this.backgroundColor,
    this.borderColor,
    this.dragOverColor,
    this.textColor,
    this.iconColor,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
  });

  /// Callback when files are selected
  final void Function(List<ZoniUploadedFile> files)? onFilesSelected;

  /// Callback when a file is removed
  final void Function(ZoniUploadedFile file)? onFileRemoved;

  /// Callback for upload progress updates
  final void Function(ZoniUploadedFile file, double progress)? onUploadProgress;

  /// Callback when upload is complete
  final void Function(ZoniUploadedFile file)? onUploadComplete;

  /// Callback when upload fails
  final void Function(ZoniUploadedFile file, String error)? onUploadError;

  /// Visual variant of the file upload
  final ZoniFileUploadVariant variant;

  /// Size of the file upload
  final ZoniFileUploadSize size;

  /// Accepted file types (MIME types or extensions)
  final List<String> acceptedFileTypes;

  /// Maximum file size in bytes
  final int maxFileSize;

  /// Maximum number of files
  final int maxFiles;

  /// Whether drag and drop is enabled
  final bool dragAndDrop;

  /// Whether to show upload progress
  final bool showProgress;

  /// Whether to show the file list
  final bool showFileList;

  /// Whether files can be removed
  final bool allowRemove;

  /// Whether the upload is disabled
  final bool disabled;

  /// Title text
  final String? title;

  /// Subtitle text
  final String? subtitle;

  /// Custom icon
  final IconData? icon;

  /// Custom button text
  final String? buttonText;

  /// Text shown when dragging over
  final String? dragOverText;

  /// Background color
  final Color? backgroundColor;

  /// Border color
  final Color? borderColor;

  /// Color when dragging over
  final Color? dragOverColor;

  /// Text color
  final Color? textColor;

  /// Icon color
  final Color? iconColor;

  /// Border radius
  final BorderRadius? borderRadius;

  /// Padding
  final EdgeInsetsGeometry? padding;

  /// Height of the upload area
  final double? height;

  /// Width of the upload area
  final double? width;

  @override
  State<ZoniFileUpload> createState() => _ZoniFileUploadState();
}

class _ZoniFileUploadState extends State<ZoniFileUpload> {
  final List<ZoniUploadedFile> _files = [];
  bool _isDragOver = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildUploadArea(theme),
        if (widget.showFileList && _files.isNotEmpty) ...[
          const SizedBox(height: ZoniSpacing.md),
          _buildFileList(theme),
        ],
      ],
    );
  }

  Widget _buildUploadArea(ThemeData theme) {
    return GestureDetector(
      onTap: widget.disabled ? null : _selectFiles,
      child: DragTarget<List<String>>(
        onWillAccept: (data) => widget.dragAndDrop && !widget.disabled,
        onAccept: (data) {
          setState(() => _isDragOver = false);
          _handleFiles(data);
        },
        onLeave: (data) => setState(() => _isDragOver = false),
        onMove: (details) => setState(() => _isDragOver = true),
        builder: (context, candidateData, rejectedData) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            height: widget.height ?? _getHeight(),
            padding: widget.padding ?? _getPadding(),
            decoration: BoxDecoration(
              color: _backgroundColor,
              border: Border.all(
                color: _borderColor,
                width: _getBorderWidth(),
                style: widget.variant == ZoniFileUploadVariant.dashed
                    ? BorderStyle.none
                    : BorderStyle.solid,
              ),
              borderRadius: _borderRadius,
            ),
            child: _buildContent(theme),
          );
        },
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.icon ?? Icons.cloud_upload_outlined,
          size: _getIconSize(),
          color: widget.iconColor ?? _getIconColor(theme),
        ),
        const SizedBox(height: ZoniSpacing.sm),
        if (widget.title != null || _isDragOver)
          Text(
            _isDragOver
                ? (widget.dragOverText ?? 'Drop files here')
                : widget.title ?? 'Upload files',
            style: _getTitleStyle(theme),
            textAlign: TextAlign.center,
          ),
        if (widget.subtitle != null && !_isDragOver) ...[
          const SizedBox(height: ZoniSpacing.xs),
          Text(
            widget.subtitle!,
            style: _getSubtitleStyle(theme),
            textAlign: TextAlign.center,
          ),
        ],
        if (!_isDragOver) ...[
          const SizedBox(height: ZoniSpacing.md),
          ElevatedButton.icon(
            onPressed: widget.disabled ? null : _selectFiles,
            icon: const Icon(Icons.folder_open),
            label: Text(widget.buttonText ?? 'Choose files'),
          ),
        ],
      ],
    );
  }

  Widget _buildFileList(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selected Files (${_files.length}/${widget.maxFiles})',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: ZoniSpacing.sm),
        ..._files.map((file) => _buildFileItem(file, theme)),
      ],
    );
  }

  Widget _buildFileItem(ZoniUploadedFile file, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZoniSpacing.sm),
      padding: const EdgeInsets.all(ZoniSpacing.md),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(ZoniBorderRadius.md),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(
            _getFileIcon(file.type),
            color: _getFileIconColor(file.type),
          ),
          const SizedBox(width: ZoniSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: ZoniSpacing.xs),
                Row(
                  children: [
                    Text(
                      file.formattedSize,
                      style: theme.textTheme.bodySmall,
                    ),
                    if (file.error != null) ...[
                      const SizedBox(width: ZoniSpacing.sm),
                      Icon(
                        Icons.error_outline,
                        size: 16,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(width: ZoniSpacing.xs),
                      Text(
                        file.error!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
                if (widget.showProgress && file.isUploading) ...[
                  const SizedBox(height: ZoniSpacing.sm),
                  LinearProgressIndicator(
                    value: file.uploadProgress,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ZoniColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (widget.allowRemove && !file.isUploading)
            IconButton(
              onPressed: () => _removeFile(file),
              icon: const Icon(Icons.close),
              iconSize: 20,
              tooltip: 'Remove file',
            ),
        ],
      ),
    );
  }

  void _selectFiles() async {
    // This would integrate with file_picker package in a real implementation
    // For now, we'll simulate file selection
    final List<ZoniUploadedFile> mockFiles = [
      ZoniUploadedFile(
        name: 'example.pdf',
        size: 1024 * 1024, // 1MB
        type: 'application/pdf',
      ),
    ];

    _handleFiles(mockFiles.map((f) => f.name).toList());
  }

  void _handleFiles(List<String> filePaths) {
    final List<ZoniUploadedFile> newFiles = [];

    for (final String path in filePaths) {
      if (_files.length + newFiles.length >= widget.maxFiles) break;

      // Simulate file creation
      final ZoniUploadedFile file = ZoniUploadedFile(
        name: path.split('/').last,
        size: 1024 * 1024, // Mock size
        type: _getMimeType(path),
        path: path,
      );

      // Validate file
      final String? error = _validateFile(file);
      if (error != null) {
        newFiles.add(file.copyWith(error: error));
      } else {
        newFiles.add(file);
      }
    }

    setState(() {
      _files.addAll(newFiles);
    });

    widget.onFilesSelected?.call(newFiles);
  }

  void _removeFile(ZoniUploadedFile file) {
    setState(() {
      _files.remove(file);
    });
    widget.onFileRemoved?.call(file);
  }

  String? _validateFile(ZoniUploadedFile file) {
    if (file.size > widget.maxFileSize) {
      return 'File too large';
    }

    if (widget.acceptedFileTypes.isNotEmpty &&
        !widget.acceptedFileTypes.contains('*')) {
      final bool isAccepted = widget.acceptedFileTypes.any((type) {
        if (type.startsWith('.')) {
          return file.name.toLowerCase().endsWith(type.toLowerCase());
        }
        return file.type.toLowerCase().contains(type.toLowerCase());
      });

      if (!isAccepted) {
        return 'File type not allowed';
      }
    }

    return null;
  }

  String _getMimeType(String fileName) {
    final String extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }

  IconData _getFileIcon(String mimeType) {
    if (mimeType.startsWith('image/')) return Icons.image;
    if (mimeType.startsWith('video/')) return Icons.video_file;
    if (mimeType.startsWith('audio/')) return Icons.audio_file;
    if (mimeType.contains('pdf')) return Icons.picture_as_pdf;
    if (mimeType.contains('word') || mimeType.contains('document')) return Icons.description;
    if (mimeType.contains('spreadsheet') || mimeType.contains('excel')) return Icons.table_chart;
    if (mimeType.contains('presentation') || mimeType.contains('powerpoint')) return Icons.slideshow;
    if (mimeType.startsWith('text/')) return Icons.text_snippet;
    return Icons.insert_drive_file;
  }

  Color _getFileIconColor(String mimeType) {
    if (mimeType.startsWith('image/')) return Colors.green;
    if (mimeType.startsWith('video/')) return Colors.red;
    if (mimeType.startsWith('audio/')) return Colors.purple;
    if (mimeType.contains('pdf')) return Colors.red;
    if (mimeType.contains('word')) return Colors.blue;
    if (mimeType.contains('excel')) return Colors.green;
    if (mimeType.contains('powerpoint')) return Colors.orange;
    return Colors.grey;
  }

  double _getHeight() {
    switch (widget.size) {
      case ZoniFileUploadSize.small:
        return 120;
      case ZoniFileUploadSize.medium:
        return 160;
      case ZoniFileUploadSize.large:
        return 200;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ZoniFileUploadSize.small:
        return const EdgeInsets.all(ZoniSpacing.md);
      case ZoniFileUploadSize.medium:
        return const EdgeInsets.all(ZoniSpacing.lg);
      case ZoniFileUploadSize.large:
        return const EdgeInsets.all(ZoniSpacing.xl);
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ZoniFileUploadSize.small:
        return 32;
      case ZoniFileUploadSize.medium:
        return 48;
      case ZoniFileUploadSize.large:
        return 64;
    }
  }

  BorderRadius get _borderRadius {
    return widget.borderRadius ??
        const BorderRadius.all(Radius.circular(ZoniBorderRadius.md));
  }

  Color get _backgroundColor {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    if (_isDragOver) return widget.dragOverColor ?? ZoniColors.primary.withValues(alpha: 0.1);
    switch (widget.variant) {
      case ZoniFileUploadVariant.standard:
        return Colors.transparent;
      case ZoniFileUploadVariant.outlined:
        return Colors.transparent;
      case ZoniFileUploadVariant.filled:
        return ZoniColors.neutralGray.withValues(alpha: 0.05);
      case ZoniFileUploadVariant.dashed:
        return Colors.transparent;
    }
  }

  Color get _borderColor {
    if (widget.borderColor != null) return widget.borderColor!;
    if (_isDragOver) return ZoniColors.primary;
    if (widget.disabled) return ZoniColors.neutralGray.withValues(alpha: 0.3);
    switch (widget.variant) {
      case ZoniFileUploadVariant.standard:
        return ZoniColors.neutralGray.withValues(alpha: 0.3);
      case ZoniFileUploadVariant.outlined:
        return ZoniColors.primary;
      case ZoniFileUploadVariant.filled:
        return Colors.transparent;
      case ZoniFileUploadVariant.dashed:
        return ZoniColors.neutralGray.withValues(alpha: 0.5);
    }
  }

  double _getBorderWidth() {
    switch (widget.variant) {
      case ZoniFileUploadVariant.standard:
        return 1.0;
      case ZoniFileUploadVariant.outlined:
        return 2.0;
      case ZoniFileUploadVariant.filled:
        return 0.0;
      case ZoniFileUploadVariant.dashed:
        return 2.0;
    }
  }

  Color _getIconColor(ThemeData theme) {
    if (widget.disabled) return theme.disabledColor;
    if (_isDragOver) return ZoniColors.primary;
    return theme.iconTheme.color ?? ZoniColors.neutralGray;
  }

  TextStyle _getTitleStyle(ThemeData theme) {
    return theme.textTheme.titleMedium?.copyWith(
      color: widget.textColor ?? _getTextColor(theme),
      fontWeight: FontWeight.w500,
    ) ?? const TextStyle();
  }

  TextStyle _getSubtitleStyle(ThemeData theme) {
    return theme.textTheme.bodyMedium?.copyWith(
      color: widget.textColor?.withValues(alpha: 0.7) ?? _getTextColor(theme).withValues(alpha: 0.7),
    ) ?? const TextStyle();
  }

  Color _getTextColor(ThemeData theme) {
    if (widget.disabled) return theme.disabledColor;
    if (_isDragOver) return ZoniColors.primary;
    return theme.textTheme.bodyMedium?.color ?? ZoniColors.neutralGray;
  }
}

/// Extension for easy file upload access
extension ZoniFileUploadExtension on BuildContext {
  Future<List<ZoniUploadedFile>?> showFileUploadDialog({
    String title = 'Upload Files',
    List<String> acceptedFileTypes = const ['*'],
    int maxFileSize = 10 * 1024 * 1024,
    int maxFiles = 5,
  }) async {
    List<ZoniUploadedFile>? selectedFiles;

    await showDialog<void>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: 400,
            child: ZoniFileUpload(
              acceptedFileTypes: acceptedFileTypes,
              maxFileSize: maxFileSize,
              maxFiles: maxFiles,
              onFilesSelected: (files) {
                selectedFiles = files;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );

    return selectedFiles;
  }
}
