import 'package:hive_flutter/hive_flutter.dart';
import 'package:livemcq3/core/constants/app_constants.dart';

class HiveBoxes {
  static const String downloadedQuestions = AppConstants.hiveBoxDownloadedQuestions;
  static const String savedJobs = AppConstants.hiveBoxSavedJobs;
  static const String libraryBooks = AppConstants.hiveBoxLibraryBooks;
  static const String examAnswers = AppConstants.hiveBoxExamAnswers;
  static const String user = AppConstants.hiveBoxUser;

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(downloadedQuestions);
    await Hive.openBox(savedJobs);
    await Hive.openBox(libraryBooks);
    await Hive.openBox(examAnswers);
    await Hive.openBox(user);
  }

  static Box getDownloadedQuestionsBox() => Hive.box(downloadedQuestions);
  static Box getSavedJobsBox() => Hive.box(savedJobs);
  static Box getLibraryBooksBox() => Hive.box(libraryBooks);
  static Box getExamAnswersBox() => Hive.box(examAnswers);
  static Box getUserBox() => Hive.box(user);
}
