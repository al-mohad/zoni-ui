import 'package:flutter/material.dart';

/// Form wrapper component with validation and submission handling.
class ZoniForm extends StatefulWidget {
  /// Creates a Zoni form.
  const ZoniForm({
    super.key,
    required this.child,
    this.onSubmit,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// The form content.
  final Widget child;

  /// Called when the form is submitted.
  final VoidCallback? onSubmit;

  /// When to validate the form.
  final AutovalidateMode autovalidateMode;

  /// Called when any form field changes.
  final VoidCallback? onChanged;

  /// Padding around the form.
  final EdgeInsets padding;

  @override
  State<ZoniForm> createState() => _ZoniFormState();
}

class _ZoniFormState extends State<ZoniForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Validates the form.
  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  /// Saves the form.
  void save() {
    _formKey.currentState?.save();
  }

  /// Resets the form.
  void reset() {
    _formKey.currentState?.reset();
  }

  /// Submits the form if valid.
  void submit() {
    if (validate()) {
      save();
      widget.onSubmit?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      onChanged: widget.onChanged,
      child: Padding(
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }
}

/// Form section component for grouping related form fields.
class ZoniFormSection extends StatelessWidget {
  /// Creates a form section.
  const ZoniFormSection({
    super.key,
    this.title,
    this.description,
    required this.children,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.spacing = 16.0,
  });

  /// Section title.
  final String? title;

  /// Section description.
  final String? description;

  /// Form fields in this section.
  final List<Widget> children;

  /// Padding around the section.
  final EdgeInsets padding;

  /// Spacing between form fields.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (description != null) ...[
              const SizedBox(height: 4.0),
              Text(
                description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:
                      theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
            const SizedBox(height: 16.0),
          ],
          ...children.map((child) => Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: child,
              )),
        ],
      ),
    );
  }
}

/// Form field wrapper with consistent styling and validation display.
class ZoniFormField<T> extends StatelessWidget {
  /// Creates a form field wrapper.
  const ZoniFormField({
    super.key,
    this.label,
    this.isRequired = false,
    this.helperText,
    this.errorText,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  /// Field label.
  final String? label;

  /// Whether the field is required.
  final bool isRequired;

  /// Helper text below the field.
  final String? helperText;

  /// Error text to display.
  final String? errorText;

  /// The form field widget.
  final Widget child;

  /// Padding around the field.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Row(
              children: [
                Text(
                  label!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isRequired) ...[
                  const SizedBox(width: 4.0),
                  Text(
                    '*',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8.0),
          ],
          child,
          if (errorText != null) ...[
            const SizedBox(height: 4.0),
            Text(
              errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ] else if (helperText != null) ...[
            const SizedBox(height: 4.0),
            Text(
              helperText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Form actions component for submit/cancel buttons.
class ZoniFormActions extends StatelessWidget {
  /// Creates form actions.
  const ZoniFormActions({
    super.key,
    this.primaryAction,
    this.secondaryAction,
    this.alignment = MainAxisAlignment.end,
    this.spacing = 12.0,
    this.padding = const EdgeInsets.only(top: 24.0),
  });

  /// Primary action button (usually submit).
  final Widget? primaryAction;

  /// Secondary action button (usually cancel).
  final Widget? secondaryAction;

  /// Alignment of the actions.
  final MainAxisAlignment alignment;

  /// Spacing between actions.
  final double spacing;

  /// Padding around the actions.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[];

    if (secondaryAction != null) {
      actions.add(secondaryAction!);
    }

    if (primaryAction != null) {
      if (actions.isNotEmpty) {
        actions.add(SizedBox(width: spacing));
      }
      actions.add(primaryAction!);
    }

    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: alignment,
        children: actions,
      ),
    );
  }
}
