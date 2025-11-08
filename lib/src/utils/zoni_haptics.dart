import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Haptic feedback utilities for the Zoni design system.
///
/// This class provides consistent haptic feedback patterns across all
/// interactive components, with proper platform handling and user preferences.
class ZoniHaptics {
  const ZoniHaptics._();

  /// Whether haptic feedback is enabled globally.
  /// This can be controlled by user preferences or system settings.
  static bool _isEnabled = true;

  /// Gets the current haptic feedback enabled state.
  static bool get isEnabled => _isEnabled;

  /// Sets the haptic feedback enabled state.
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Provides light haptic feedback for subtle interactions.
  ///
  /// Use this for:
  /// - Button taps
  /// - Toggle switches
  /// - Radio button selections
  /// - Checkbox interactions
  static Future<void> light() async {
    if (!_isEnabled || kIsWeb) return;
    
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Silently handle any haptic feedback errors
      if (kDebugMode) {
        print('ZoniHaptics: Light haptic feedback failed: $e');
      }
    }
  }

  /// Provides medium haptic feedback for standard interactions.
  ///
  /// Use this for:
  /// - Form submissions
  /// - Navigation actions
  /// - Modal dismissals
  /// - Tab selections
  static Future<void> medium() async {
    if (!_isEnabled || kIsWeb) return;
    
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      // Silently handle any haptic feedback errors
      if (kDebugMode) {
        print('ZoniHaptics: Medium haptic feedback failed: $e');
      }
    }
  }

  /// Provides heavy haptic feedback for significant interactions.
  ///
  /// Use this for:
  /// - Destructive actions (delete, remove)
  /// - Important confirmations
  /// - Error states
  /// - Success completions
  static Future<void> heavy() async {
    if (!_isEnabled || kIsWeb) return;
    
    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      // Silently handle any haptic feedback errors
      if (kDebugMode) {
        print('ZoniHaptics: Heavy haptic feedback failed: $e');
      }
    }
  }

  /// Provides selection haptic feedback for picker-style interactions.
  ///
  /// Use this for:
  /// - Dropdown selections
  /// - Picker wheel changes
  /// - Slider value changes
  /// - Stepper increments/decrements
  static Future<void> selection() async {
    if (!_isEnabled || kIsWeb) return;
    
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      // Silently handle any haptic feedback errors
      if (kDebugMode) {
        print('ZoniHaptics: Selection haptic feedback failed: $e');
      }
    }
  }

  /// Provides vibration feedback for notifications and alerts.
  ///
  /// Use this for:
  /// - Push notifications
  /// - Alert dialogs
  /// - System notifications
  /// - Background task completions
  static Future<void> vibrate() async {
    if (!_isEnabled || kIsWeb) return;
    
    try {
      await HapticFeedback.vibrate();
    } catch (e) {
      // Silently handle any haptic feedback errors
      if (kDebugMode) {
        print('ZoniHaptics: Vibration feedback failed: $e');
      }
    }
  }

  /// Provides success haptic feedback for positive outcomes.
  ///
  /// This is a convenience method that uses medium impact for success states.
  /// Use this for:
  /// - Successful form submissions
  /// - Completed tasks
  /// - Positive confirmations
  /// - Achievement unlocks
  static Future<void> success() async {
    await medium();
  }

  /// Provides error haptic feedback for negative outcomes.
  ///
  /// This is a convenience method that uses heavy impact for error states.
  /// Use this for:
  /// - Form validation errors
  /// - Failed operations
  /// - Network errors
  /// - Invalid inputs
  static Future<void> error() async {
    await heavy();
  }

  /// Provides warning haptic feedback for cautionary interactions.
  ///
  /// This is a convenience method that uses medium impact for warning states.
  /// Use this for:
  /// - Confirmation dialogs
  /// - Potentially destructive actions
  /// - Important notices
  /// - Validation warnings
  static Future<void> warning() async {
    await medium();
  }

  /// Provides button press haptic feedback.
  ///
  /// This is the standard haptic feedback for button interactions.
  /// It uses light impact for a subtle but noticeable response.
  static Future<void> buttonPress() async {
    await light();
  }

  /// Provides toggle haptic feedback for switch-like controls.
  ///
  /// This is optimized for toggle interactions like switches, checkboxes,
  /// and radio buttons. Uses selection click for precise feedback.
  static Future<void> toggle() async {
    await selection();
  }

  /// Provides long press haptic feedback for context menus and tooltips.
  ///
  /// This uses medium impact to indicate a long press has been recognized.
  static Future<void> longPress() async {
    await medium();
  }

  /// Provides drag start haptic feedback for drag and drop operations.
  ///
  /// This uses light impact to indicate drag operation has started.
  static Future<void> dragStart() async {
    await light();
  }

  /// Provides drag end haptic feedback for drag and drop operations.
  ///
  /// This uses medium impact to indicate successful drop or drag completion.
  static Future<void> dragEnd() async {
    await medium();
  }
}

/// Haptic feedback types for different interaction patterns.
enum ZoniHapticType {
  /// Light haptic feedback for subtle interactions
  light,
  
  /// Medium haptic feedback for standard interactions
  medium,
  
  /// Heavy haptic feedback for significant interactions
  heavy,
  
  /// Selection haptic feedback for picker-style interactions
  selection,
  
  /// Vibration feedback for notifications and alerts
  vibrate,
  
  /// Success haptic feedback for positive outcomes
  success,
  
  /// Error haptic feedback for negative outcomes
  error,
  
  /// Warning haptic feedback for cautionary interactions
  warning,
  
  /// Button press haptic feedback
  buttonPress,
  
  /// Toggle haptic feedback for switch-like controls
  toggle,
  
  /// Long press haptic feedback
  longPress,
  
  /// Drag start haptic feedback
  dragStart,
  
  /// Drag end haptic feedback
  dragEnd,
}

/// Extension to easily trigger haptic feedback from enum values.
extension ZoniHapticTypeExtension on ZoniHapticType {
  /// Triggers the haptic feedback for this type.
  Future<void> trigger() async {
    switch (this) {
      case ZoniHapticType.light:
        await ZoniHaptics.light();
        break;
      case ZoniHapticType.medium:
        await ZoniHaptics.medium();
        break;
      case ZoniHapticType.heavy:
        await ZoniHaptics.heavy();
        break;
      case ZoniHapticType.selection:
        await ZoniHaptics.selection();
        break;
      case ZoniHapticType.vibrate:
        await ZoniHaptics.vibrate();
        break;
      case ZoniHapticType.success:
        await ZoniHaptics.success();
        break;
      case ZoniHapticType.error:
        await ZoniHaptics.error();
        break;
      case ZoniHapticType.warning:
        await ZoniHaptics.warning();
        break;
      case ZoniHapticType.buttonPress:
        await ZoniHaptics.buttonPress();
        break;
      case ZoniHapticType.toggle:
        await ZoniHaptics.toggle();
        break;
      case ZoniHapticType.longPress:
        await ZoniHaptics.longPress();
        break;
      case ZoniHapticType.dragStart:
        await ZoniHaptics.dragStart();
        break;
      case ZoniHapticType.dragEnd:
        await ZoniHaptics.dragEnd();
        break;
    }
  }
}
