import 'package:flutter/services.dart';

Future<void> impact() async {
  await HapticFeedback.mediumImpact();
}

Future<void> success() async {
  await HapticFeedback.lightImpact();
  await Future<void>.delayed(const Duration(milliseconds: 200));
  await HapticFeedback.heavyImpact();
}

Future<void> warning() async {
  await HapticFeedback.heavyImpact();
  await Future<void>.delayed(const Duration(milliseconds: 200));
  await HapticFeedback.lightImpact();
}

Future<void> back() async {
  await HapticFeedback.lightImpact();
  await Future<void>.delayed(const Duration(milliseconds: 150));
  await HapticFeedback.mediumImpact();
  await Future<void>.delayed(const Duration(milliseconds: 150));
  await HapticFeedback.heavyImpact();

  // await HapticFeedback.lightImpact();
  // await Future<void>.delayed(const Duration(milliseconds: 100));
  // await HapticFeedback.lightImpact();
  // await Future<void>.delayed(const Duration(milliseconds: 100));
  // await HapticFeedback.heavyImpact();
  // await Future<void>.delayed(const Duration(milliseconds: 100));
  // await HapticFeedback.lightImpact();
}
