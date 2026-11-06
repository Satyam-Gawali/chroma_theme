import 'package:flutter/material.dart';
import 'chroma_theme_mode.dart';

/// Configuration for time-based, automatic sunrise/sunset theme switching.
class ChromaSchedule {
  /// Time of day when Light mode should activate. Default is 06:00 AM.
  final TimeOfDay lightTime;

  /// Time of day when Dark/AMOLED mode should activate. Default is 07:00 PM (19:00).
  final TimeOfDay darkTime;

  /// Mode to use during the dark period. Defaults to [ChromaThemeMode.dark],
  /// but can be set to [ChromaThemeMode.amoled] for OLED screens.
  final ChromaThemeMode darkEffectiveMode;

  const ChromaSchedule({
    this.lightTime = const TimeOfDay(hour: 6, minute: 0),
    this.darkTime = const TimeOfDay(hour: 19, minute: 0),
    ChromaThemeMode? darkEffectiveMode,
    ChromaThemeMode? darkTargetMode,
  }) : darkEffectiveMode = darkTargetMode ?? darkEffectiveMode ?? ChromaThemeMode.dark;

  /// Alias for [darkEffectiveMode].
  ChromaThemeMode get darkTargetMode => darkEffectiveMode;

  /// Evaluates whether the given [dateTime] (defaults to [DateTime.now()]) falls
  /// in the daytime (light) or nighttime (dark) schedule.
  ChromaThemeMode resolveMode([DateTime? dateTime]) {
    final now = dateTime ?? DateTime.now();
    final currentMinutes = now.hour * 60 + now.minute;

    final lightMinutes = lightTime.hour * 60 + lightTime.minute;
    final darkMinutes = darkTime.hour * 60 + darkTime.minute;

    if (darkMinutes > lightMinutes) {
      // Normal schedule (e.g. 6:00 to 19:00 is daytime)
      if (currentMinutes >= lightMinutes && currentMinutes < darkMinutes) {
        return ChromaThemeMode.light;
      }
      return darkEffectiveMode;
    } else {
      // Overnight schedule (e.g. 19:00 to 6:00 next day is nighttime)
      if (currentMinutes >= darkMinutes || currentMinutes < lightMinutes) {
        return darkEffectiveMode;
      }
      return ChromaThemeMode.light;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChromaSchedule &&
        other.lightTime == lightTime &&
        other.darkTime == darkTime &&
        other.darkEffectiveMode == darkEffectiveMode;
  }

  @override
  int get hashCode => Object.hash(lightTime, darkTime, darkEffectiveMode);
}
