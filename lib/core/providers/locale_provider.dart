import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:livemcq3/core/constants/app_constants.dart';

final localeProvider = StateProvider<Locale>((ref) {
  final box = Hive.box(AppConstants.hiveBoxSettings);
  final savedLocale = box.get('locale') as String?;
  return Locale(savedLocale ?? AppConstants.defaultLanguage);
});

class LocaleService {
  static Future<void> saveLocale(String languageCode) async {
    final box = Hive.box(AppConstants.hiveBoxSettings);
    await box.put('locale', languageCode);
  }
}
