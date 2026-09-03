import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {},
    'bn': {},
  };

  String get appName => _localizedValues[locale.languageCode]?['appName'] ?? 'LiveMCQ';
  String get welcome => _localizedValues[locale.languageCode]?['welcome'] ?? 'Welcome';
  String get login => _localizedValues[locale.languageCode]?['login'] ?? 'Login';
  String get register => _localizedValues[locale.languageCode]?['register'] ?? 'Register';
  String get home => _localizedValues[locale.languageCode]?['home'] ?? 'Home';
  String get practice => _localizedValues[locale.languageCode]?['practice'] ?? 'Practice';
  String get jobs => _localizedValues[locale.languageCode]?['jobs'] ?? 'Jobs';
  String get books => _localizedValues[locale.languageCode]?['books'] ?? 'Books';
  String get profile => _localizedValues[locale.languageCode]?['profile'] ?? 'Profile';
  String get notifications => _localizedValues[locale.languageCode]?['notifications'] ?? 'Notifications';
  String get logout => _localizedValues[locale.languageCode]?['logout'] ?? 'Logout';
  String get settings => _localizedValues[locale.languageCode]?['settings'] ?? 'Settings';
  String get language => _localizedValues[locale.languageCode]?['language'] ?? 'Language';
  String get loading => _localizedValues[locale.languageCode]?['loading'] ?? 'Loading...';
  String get error => _localizedValues[locale.languageCode]?['error'] ?? 'Error';
  String get retry => _localizedValues[locale.languageCode]?['retry'] ?? 'Retry';
  String get noData => _localizedValues[locale.languageCode]?['noData'] ?? 'No data available';
  String get submit => _localizedValues[locale.languageCode]?['submit'] ?? 'Submit';
  String get cancel => _localizedValues[locale.languageCode]?['cancel'] ?? 'Cancel';
  String get save => _localizedValues[locale.languageCode]?['save'] ?? 'Save';
  String get delete => _localizedValues[locale.languageCode]?['delete'] ?? 'Delete';
  String get edit => _localizedValues[locale.languageCode]?['edit'] ?? 'Edit';
  String get search => _localizedValues[locale.languageCode]?['search'] ?? 'Search';
  String get filter => _localizedValues[locale.languageCode]?['filter'] ?? 'Filter';
  String get back => _localizedValues[locale.languageCode]?['back'] ?? 'Back';
  String get next => _localizedValues[locale.languageCode]?['next'] ?? 'Next';
  String get getStarted => _localizedValues[locale.languageCode]?['getStarted'] ?? 'Get Started';
  String get dailyQuiz => _localizedValues[locale.languageCode]?['dailyQuiz'] ?? 'Daily Quiz';
  String get liveContests => _localizedValues[locale.languageCode]?['liveContests'] ?? 'Live Contests';
  String get savedJobs => _localizedValues[locale.languageCode]?['savedJobs'] ?? 'Saved Jobs';
  String get jobAlerts => _localizedValues[locale.languageCode]?['jobAlerts'] ?? 'Job Alerts';
  String get applyNow => _localizedValues[locale.languageCode]?['applyNow'] ?? 'Apply Now';
  String get buyNow => _localizedValues[locale.languageCode]?['buyNow'] ?? 'Buy Now';
  String get readNow => _localizedValues[locale.languageCode]?['readNow'] ?? 'Read Now';
  String get preview => _localizedValues[locale.languageCode]?['preview'] ?? 'Preview';
  String get download => _localizedValues[locale.languageCode]?['download'] ?? 'Download';
  String get continueReading => _localizedValues[locale.languageCode]?['continueReading'] ?? 'Continue Reading';
  String get streak => _localizedValues[locale.languageCode]?['streak'] ?? 'Streak';
  String get rank => _localizedValues[locale.languageCode]?['rank'] ?? 'Rank';
  String get score => _localizedValues[locale.languageCode]?['score'] ?? 'Score';
  String get correct => _localizedValues[locale.languageCode]?['correct'] ?? 'Correct';
  String get wrong => _localizedValues[locale.languageCode]?['wrong'] ?? 'Wrong';
  String get total => _localizedValues[locale.languageCode]?['total'] ?? 'Total';
  String get result => _localizedValues[locale.languageCode]?['result'] ?? 'Result';
  String get backToPractice => _localizedValues[locale.languageCode]?['backToPractice'] ?? 'Back to Practice';
  String get joinContest => _localizedValues[locale.languageCode]?['joinContest'] ?? 'Join Contest';
  String get leaderboard => _localizedValues[locale.languageCode]?['leaderboard'] ?? 'Leaderboard';
  String get noUpcomingContests => _localizedValues[locale.languageCode]?['noUpcomingContests'] ?? 'No upcoming contests';
  String get noBooksAvailable => _localizedValues[locale.languageCode]?['noBooksAvailable'] ?? 'No books available';
  String get noJobsAvailable => _localizedValues[locale.languageCode]?['noJobsAvailable'] ?? 'No jobs available';
  String get premium => _localizedValues[locale.languageCode]?['premium'] ?? 'Premium';
  String get free => _localizedValues[locale.languageCode]?['free'] ?? 'Free';
  String get price => _localizedValues[locale.languageCode]?['price'] ?? 'Price';
  String get purchased => _localizedValues[locale.languageCode]?['purchased'] ?? 'Purchased';
  String get orderHistory => _localizedValues[locale.languageCode]?['orderHistory'] ?? 'Order History';
  String get myLibrary => _localizedValues[locale.languageCode]?['myLibrary'] ?? 'My Library';
  String get accountSettings => _localizedValues[locale.languageCode]?['accountSettings'] ?? 'Account Settings';
  String get notificationPreferences => _localizedValues[locale.languageCode]?['notificationPreferences'] ?? 'Notification Preferences';
  String get appLock => _localizedValues[locale.languageCode]?['appLock'] ?? 'App Lock';
  String get deleteAccount => _localizedValues[locale.languageCode]?['deleteAccount'] ?? 'Delete Account';
  String get logoutConfirm => _localizedValues[locale.languageCode]?['logoutConfirm'] ?? 'Are you sure you want to logout?';
  String get yes => _localizedValues[locale.languageCode]?['yes'] ?? 'Yes';
  String get no => _localizedValues[locale.languageCode]?['no'] ?? 'No';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'bn'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
