import 'package:chroma_theme/chroma_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChromaSchedule Sun-Aware Deep Boundary Tests', () {
    test('evaluates standard daytime schedule (06:00 to 18:00)', () {
      const schedule = ChromaSchedule(
        lightTime: TimeOfDay(hour: 6, minute: 0),
        darkTime: TimeOfDay(hour: 18, minute: 0),
        darkEffectiveMode: ChromaThemeMode.dark,
      );

      // Exactly at sunrise
      final atSunrise = DateTime(2025, 1, 1, 6, 0);
      expect(schedule.resolveMode(atSunrise), ChromaThemeMode.light);

      // Midday
      final midday = DateTime(2025, 1, 1, 12, 30);
      expect(schedule.resolveMode(midday), ChromaThemeMode.light);

      // One minute before sunset
      final beforeSunset = DateTime(2025, 1, 1, 17, 59);
      expect(schedule.resolveMode(beforeSunset), ChromaThemeMode.light);

      // Exactly at sunset
      final atSunset = DateTime(2025, 1, 1, 18, 0);
      expect(schedule.resolveMode(atSunset), ChromaThemeMode.dark);

      // Midnight
      final midnight = DateTime(2025, 1, 1, 0, 0);
      expect(schedule.resolveMode(midnight), ChromaThemeMode.dark);

      // 5:59 AM (before sunrise)
      final earlyMorning = DateTime(2025, 1, 1, 5, 59);
      expect(schedule.resolveMode(earlyMorning), ChromaThemeMode.dark);
    });

    test('evaluates overnight schedule crossing midnight (e.g. 21:00 to 07:00)', () {
      const overnightSchedule = ChromaSchedule(
        lightTime: TimeOfDay(hour: 7, minute: 0),
        darkTime: TimeOfDay(hour: 21, minute: 0),
        darkEffectiveMode: ChromaThemeMode.amoled,
      );

      // 22:00 at night -> AMOLED
      final night = DateTime(2025, 1, 1, 22, 0);
      expect(overnightSchedule.resolveMode(night), ChromaThemeMode.amoled);

      // 02:00 early morning -> AMOLED
      final earlyHours = DateTime(2025, 1, 1, 2, 0);
      expect(overnightSchedule.resolveMode(earlyHours), ChromaThemeMode.amoled);

      // 08:00 morning -> Light
      final morning = DateTime(2025, 1, 1, 8, 0);
      expect(overnightSchedule.resolveMode(morning), ChromaThemeMode.light);
    });

    test('schedule value equality and hashCode', () {
      const s1 = ChromaSchedule(lightTime: TimeOfDay(hour: 6, minute: 0));
      const s2 = ChromaSchedule(lightTime: TimeOfDay(hour: 6, minute: 0));
      const s3 = ChromaSchedule(lightTime: TimeOfDay(hour: 7, minute: 0));

      expect(s1 == s2, isTrue);
      expect(s1.hashCode, s2.hashCode);
      expect(s1 == s3, isFalse);
    });
  });
}
