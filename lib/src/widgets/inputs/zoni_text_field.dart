import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/zoni_animations.dart';
import '../../utils/zoni_haptics.dart';
import '../../utils/zoni_input_utils.dart';

/// Input field size variants for the Zoni design system.
///
/// This is an alias for [ZoniInputSize] to maintain backward compatibility.
typedef ZoniTextFieldSize = ZoniInputSize;

/// A customizable text input field following the Zoni design system.
///
/// This widget provides a consistent text field implementation with
/// multiple sizes, variants, and comprehensive styling options. It follows
/// Material Design 3 guidelines for input components and includes professional
/// features like haptic feedback, focus animations, and accessibility support.
///
/// Example usage:
/// ```dart
/// ZoniTextField(
///   decoration: ZoniInputDecoration(
///     labelText: 'Email',
///     hintText: 'Enter your email',
///     prefixIcon: Icon(Icons.email),
///   ),
///   onChanged: (value) => print(value),
/// )
/// ```
class ZoniTextField extends StatefulWidget {
  /// Creates a Zoni text field.
  const ZoniTextField({
    super.key,
    this.controller,
    this.decoration,
    this.variant = ZoniInputVariant.outlined,
    this.size = ZoniTextFieldSize.medium,
    this.maxLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.focusNode,
    this.semanticLabel,
    this.enableHapticFeedback = true,
    this.hapticType = ZoniHapticType.light,
    this.enableFocusAnimation = true,
    this.animationDuration,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.buildCounter,
    this.onAppPrivateCommand,
    this.mouseCursor,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.onTapOutside,
    this.clipBehavior = Clip.hardEdge,
    this.scribbleEnabled = true,
    this.canRequestFocus = true,
    // Backward compatibility parameters
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The decoration configuration for the input field.
  ///
  /// If null, a default decoration will be created based on the variant and size.
  final ZoniInputDecoration? decoration;

  /// The visual variant of the text field.
  final ZoniInputVariant variant;

  /// The size of the text field.
  final ZoniTextFieldSize size;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  /// The minimum number of lines for the text field.
  final int? minLines;

  /// The maximum number of characters allowed.
  final int? maxLength;

  /// Whether to obscure the text (for passwords).
  final bool obscureText;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field should be focused initially.
  final bool autofocus;

  /// The type of keyboard to display.
  final TextInputType? keyboardType;

  /// The action to take when the user presses the action button.
  final TextInputAction? textInputAction;

  /// Input formatters to apply to the text.
  final List<TextInputFormatter>? inputFormatters;

  /// Validator function for form validation.
  final String? Function(String?)? validator;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the text.
  final ValueChanged<String>? onSubmitted;

  /// Called when the text field is tapped.
  final GestureTapCallback? onTap;

  /// Called when the user indicates that they are done editing the text.
  final VoidCallback? onEditingComplete;

  /// Focus node for the text field.
  final FocusNode? focusNode;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Whether to enable haptic feedback on interactions.
  final bool enableHapticFeedback;

  /// The type of haptic feedback to provide.
  final ZoniHapticType hapticType;

  /// Whether to enable focus animations.
  final bool enableFocusAnimation;

  /// Duration for focus animations.
  final Duration? animationDuration;

  /// The style to use for the text being edited.
  final TextStyle? textStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// Whether to show input suggestions as the user types.
  final bool enableSuggestions;

  /// If true, the text field will expand to fill its parent.
  final bool expands;

  /// Whether to show cursor.
  final bool? showCursor;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// The color to use when painting the cursor.
  final Color? cursorColor;

  /// Controls how tall the selection highlight boxes are computed to be.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// The appearance of the keyboard.
  final Brightness? keyboardAppearance;

  /// Configures padding to edges surrounding a Scrollable when the Textfield scrolls into view.
  final EdgeInsets scrollPadding;

  /// Whether to enable user interface affordances for changing the selection.
  final bool enableInteractiveSelection;

  /// Callback that generates a custom InputDecorator.counter widget.
  final InputCounterWidgetBuilder? buildCounter;

  /// This is used to receive a private command from the input method.
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// Builds the text selection toolbar when requested by the user.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Configuration of spell check service.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Configuration of magnifier.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Controls the undo state.
  final UndoHistoryController? undoController;

  /// Called for each distinct tap except for every second tap of a double tap.
  final TapRegionCallback? onTapOutside;

  /// The content will be clipped (or not) according to this option.
  final Clip clipBehavior;

  /// Whether iOS 14 Scribble features are enabled for this widget.
  final bool scribbleEnabled;

  /// Whether this text field can request the primary focus.
  final bool canRequestFocus;

  // Backward compatibility parameters
  /// The label text to display above the field.
  ///
  /// This is a convenience parameter. Use [decoration.labelText] for more control.
  final String? label;

  /// The hint text to display when the field is empty.
  ///
  /// This is a convenience parameter. Use [decoration.hintText] for more control.
  final String? hintText;

  /// Helper text to display below the field.
  ///
  /// This is a convenience parameter. Use [decoration.helperText] for more control.
  final String? helperText;

  /// Error text to display below the field.
  ///
  /// This is a convenience parameter. Use [decoration.errorText] for more control.
  final String? errorText;

  /// Widget to display before the input text.
  ///
  /// This is a convenience parameter. Use [decoration.prefixIcon] for more control.
  final Widget? prefixIcon;

  /// Widget to display after the input text.
  ///
  /// This is a convenience parameter. Use [decoration.suffixIcon] for more control.
  final Widget? suffixIcon;

  @override
  State<ZoniTextField> createState() => _ZoniTextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<TextEditingController?>('controller', controller),
      )
      ..add(DiagnosticsProperty<ZoniInputDecoration?>('decoration', decoration))
      ..add(EnumProperty<ZoniInputVariant>('variant', variant))
      ..add(EnumProperty<ZoniTextFieldSize>('size', size))
      ..add(IntProperty('maxLines', maxLines))
      ..add(IntProperty('minLines', minLines))
      ..add(IntProperty('maxLength', maxLength))
      ..add(FlagProperty('obscureText', value: obscureText, ifTrue: 'obscured'))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(FlagProperty('readOnly', value: readOnly, ifTrue: 'readOnly'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType))
      ..add(EnumProperty<TextInputAction?>('textInputAction', textInputAction))
      ..add(
        DiagnosticsProperty<List<TextInputFormatter>?>(
          'inputFormatters',
          inputFormatters,
        ),
      )
      ..add(
        DiagnosticsProperty<String? Function(String?)?>(
          'validator',
          validator,
        ),
      )
      ..add(DiagnosticsProperty<ValueChanged<String>?>('onChanged', onChanged))
      ..add(
        DiagnosticsProperty<ValueChanged<String>?>(
          'onSubmitted',
          onSubmitted,
        ),
      )
      ..add(DiagnosticsProperty<GestureTapCallback?>('onTap', onTap))
      ..add(
        DiagnosticsProperty<VoidCallback?>(
          'onEditingComplete',
          onEditingComplete,
        ),
      )
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(
        FlagProperty(
          'enableHapticFeedback',
          value: enableHapticFeedback,
          ifFalse: 'disabled',
        ),
      )
      ..add(EnumProperty<ZoniHapticType>('hapticType', hapticType))
      ..add(
        FlagProperty(
          'enableFocusAnimation',
          value: enableFocusAnimation,
          ifFalse: 'disabled',
        ),
      )
      ..add(
        DiagnosticsProperty<Duration?>(
          'animationDuration',
          animationDuration,
        ),
      )
      ..add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle))
      ..add(EnumProperty<TextAlign>('textAlign', textAlign))
      ..add(EnumProperty<TextDirection?>('textDirection', textDirection))
      ..add(
        EnumProperty<TextCapitalization>(
          'textCapitalization',
          textCapitalization,
        ),
      )
      ..add(
        FlagProperty('autocorrect', value: autocorrect, ifFalse: 'disabled'),
      )
      ..add(
        FlagProperty(
          'enableSuggestions',
          value: enableSuggestions,
          ifFalse: 'disabled',
        ),
      )
      ..add(FlagProperty('expands', value: expands, ifTrue: 'expands'))
      ..add(FlagProperty('showCursor', value: showCursor, ifFalse: 'hidden'))
      ..add(DoubleProperty('cursorWidth', cursorWidth))
      ..add(DoubleProperty('cursorHeight', cursorHeight))
      ..add(DiagnosticsProperty<Radius?>('cursorRadius', cursorRadius))
      ..add(ColorProperty('cursorColor', cursorColor))
      ..add(
        EnumProperty<ui.BoxHeightStyle>(
          'selectionHeightStyle',
          selectionHeightStyle,
        ),
      )
      ..add(
        EnumProperty<ui.BoxWidthStyle>(
          'selectionWidthStyle',
          selectionWidthStyle,
        ),
      )
      ..add(EnumProperty<Brightness?>('keyboardAppearance', keyboardAppearance))
      ..add(DiagnosticsProperty<EdgeInsets>('scrollPadding', scrollPadding))
      ..add(
        FlagProperty(
          'enableInteractiveSelection',
          value: enableInteractiveSelection,
          ifFalse: 'disabled',
        ),
      )
      ..add(
        DiagnosticsProperty<InputCounterWidgetBuilder?>(
          'buildCounter',
          buildCounter,
        ),
      )
      ..add(
        DiagnosticsProperty<AppPrivateCommandCallback?>(
          'onAppPrivateCommand',
          onAppPrivateCommand,
        ),
      )
      ..add(DiagnosticsProperty<MouseCursor?>('mouseCursor', mouseCursor))
      ..add(
        DiagnosticsProperty<EditableTextContextMenuBuilder?>(
          'contextMenuBuilder',
          contextMenuBuilder,
        ),
      )
      ..add(
        DiagnosticsProperty<SpellCheckConfiguration?>(
          'spellCheckConfiguration',
          spellCheckConfiguration,
        ),
      )
      ..add(
        DiagnosticsProperty<TextMagnifierConfiguration?>(
          'magnifierConfiguration',
          magnifierConfiguration,
        ),
      )
      ..add(
        DiagnosticsProperty<UndoHistoryController?>(
          'undoController',
          undoController,
        ),
      )
      ..add(
        DiagnosticsProperty<TapRegionCallback?>('onTapOutside', onTapOutside),
      )
      ..add(EnumProperty<Clip>('clipBehavior', clipBehavior))
      ..add(
        FlagProperty(
          'scribbleEnabled',
          value: scribbleEnabled,
          ifFalse: 'disabled',
        ),
      )
      ..add(
        FlagProperty(
          'canRequestFocus',
          value: canRequestFocus,
          ifFalse: 'disabled',
        ),
      )
      // Backward compatibility parameters
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('helperText', helperText))
      ..add(StringProperty('errorText', errorText))
      ..add(DiagnosticsProperty<Widget?>('prefixIcon', prefixIcon))
      ..add(DiagnosticsProperty<Widget?>('suffixIcon', suffixIcon));
  }
}

/// State class for [ZoniTextField] with professional features.
class _ZoniTextFieldState extends State<ZoniTextField>
    with TickerProviderStateMixin, ZoniAnimationMixin {
  late FocusNode _focusNode;
  late AnimationController _focusAnimationController;
  late Animation<double> _focusAnimation;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    // Initialize focus animation
    _focusAnimationController = AnimationController(
      duration: widget.animationDuration ?? ZoniAnimations.focusDuration,
      vsync: this,
    );

    _focusAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _focusAnimationController,
        curve: ZoniAnimations.standard,
      ),
    );

    // Listen to focus changes
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _focusAnimationController.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (widget.enableFocusAnimation) {
      if (_focusNode.hasFocus) {
        _focusAnimationController.forward();
      } else {
        _focusAnimationController.reverse();
      }
    }

    // Provide haptic feedback on focus change
    if (widget.enableHapticFeedback && _focusNode.hasFocus) {
      widget.hapticType.trigger();
    }
  }

  void _handleTap() {
    if (widget.enableHapticFeedback) {
      widget.hapticType.trigger();
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    // Create the effective decoration by merging custom decoration with defaults
    final ZoniInputDecoration effectiveDecoration =
        _createEffectiveDecoration();

    Widget textField = AnimatedBuilder(
      animation: _focusAnimation,
      builder: (BuildContext context, Widget? child) => TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        style: widget.textStyle ?? ZoniInputUtils.getTextStyle(widget.size),
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        textCapitalization: widget.textCapitalization,
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.enableSuggestions,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        expands: widget.expands,
        showCursor: widget.showCursor,
        cursorWidth: widget.cursorWidth,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        onTap: _handleTap,
        onTapOutside: widget.onTapOutside,
        buildCounter: widget.buildCounter,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        mouseCursor: widget.mouseCursor,
        contextMenuBuilder: widget.contextMenuBuilder,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        magnifierConfiguration: widget.magnifierConfiguration,
        undoController: widget.undoController,
        clipBehavior: widget.clipBehavior,
        stylusHandwritingEnabled: widget.scribbleEnabled,
        canRequestFocus: widget.canRequestFocus,
        decoration: effectiveDecoration.toInputDecoration(),
      ),
    );

    // Add semantic label if provided
    if (widget.semanticLabel != null) {
      textField = Semantics(
        label: widget.semanticLabel,
        textField: true,
        child: textField,
      );
    }

    return textField;
  }

  /// Creates the effective decoration by merging custom decoration with defaults
  /// and backward compatibility parameters.
  ZoniInputDecoration _createEffectiveDecoration() {
    // Start with default decoration based on variant and size
    final ZoniInputDecoration defaultDecoration =
        ZoniInputUtils.createDefaultDecoration(
      variant: widget.variant,
      size: widget.size,
    );

    // If custom decoration is provided, merge it with defaults
    ZoniInputDecoration effectiveDecoration =
        widget.decoration?.copyWith() ?? defaultDecoration;

    // Apply backward compatibility parameters if they override decoration values
    if (widget.label != null) {
      effectiveDecoration =
          effectiveDecoration.copyWith(labelText: widget.label);
    }
    if (widget.hintText != null) {
      effectiveDecoration =
          effectiveDecoration.copyWith(hintText: widget.hintText);
    }
    if (widget.helperText != null) {
      effectiveDecoration =
          effectiveDecoration.copyWith(helperText: widget.helperText);
    }
    if (widget.errorText != null) {
      effectiveDecoration =
          effectiveDecoration.copyWith(errorText: widget.errorText);
    }
    if (widget.prefixIcon != null) {
      effectiveDecoration =
          effectiveDecoration.copyWith(prefixIcon: widget.prefixIcon);
    }
    if (widget.suffixIcon != null) {
      effectiveDecoration =
          effectiveDecoration.copyWith(suffixIcon: widget.suffixIcon);
    }

    return effectiveDecoration;
  }
}
