import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('bn', ''),
  ];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get appName => _values[locale.languageCode]!['appName']!;
  String get login => _values[locale.languageCode]!['login']!;
  String get register => _values[locale.languageCode]!['register']!;
  String get email => _values[locale.languageCode]!['email']!;
  String get password => _values[locale.languageCode]!['password']!;
  String get confirmPassword => _values[locale.languageCode]!['confirmPassword']!;
  String get phone => _values[locale.languageCode]!['phone']!;
  String get name => _values[locale.languageCode]!['name']!;
  String get submit => _values[locale.languageCode]!['submit']!;
  String get cancel => _values[locale.languageCode]!['cancel']!;
  String get save => _values[locale.languageCode]!['save']!;
  String get delete => _values[locale.languageCode]!['delete']!;
  String get home => _values[locale.languageCode]!['home']!;
  String get categories => _values[locale.languageCode]!['categories']!;
  String get contests => _values[locale.languageCode]!['contests']!;
  String get jobs => _values[locale.languageCode]!['jobs']!;
  String get books => _values[locale.languageCode]!['books']!;
  String get profile => _values[locale.languageCode]!['profile']!;
  String get settings => _values[locale.languageCode]!['settings']!;
  String get notifications => _values[locale.languageCode]!['notifications']!;
  String get logout => _values[locale.languageCode]!['logout']!;
  String get loading => _values[locale.languageCode]!['loading']!;
  String get error => _values[locale.languageCode]!['error']!;
  String get retry => _values[locale.languageCode]!['retry']!;
  String get noData => _values[locale.languageCode]!['noData']!;
  String get ok => _values[locale.languageCode]!['ok']!;
  String get otp => _values[locale.languageCode]!['otp']!;
  String get sendOtp => _values[locale.languageCode]!['sendOtp']!;
  String get verifyOtp => _values[locale.languageCode]!['verifyOtp']!;
  String get resendOtp => _values[locale.languageCode]!['resendOtp']!;
  String get biometricLogin => _values[locale.languageCode]!['biometricLogin']!;
  String get enableBiometric => _values[locale.languageCode]!['enableBiometric']!;
  String get examHistory => _values[locale.languageCode]!['examHistory']!;
  String get bookmarks => _values[locale.languageCode]!['bookmarks']!;
  String get savedJobs => _values[locale.languageCode]!['savedJobs']!;
  String get library => _values[locale.languageCode]!['library']!;
  String get orderHistory => _values[locale.languageCode]!['orderHistory']!;
  String get checkout => _values[locale.languageCode]!['checkout']!;
  String get paymentPending => _values[locale.languageCode]!['paymentPending']!;
  String get paymentSuccess => _values[locale.languageCode]!['paymentSuccess']!;
  String get paymentFailed => _values[locale.languageCode]!['paymentFailed']!;
  String get cvBuilder => _values[locale.languageCode]!['cvBuilder']!;
  String get createCv => _values[locale.languageCode]!['createCv']!;
  String get editCv => _values[locale.languageCode]!['editCv']!;
  String get previewCv => _values[locale.languageCode]!['previewCv']!;
  String get downloadPdf => _values[locale.languageCode]!['downloadPdf']!;
  String get duplicate => _values[locale.languageCode]!['duplicate']!;
  String get analytics => _values[locale.languageCode]!['analytics']!;
  String get offlineMode => _values[locale.languageCode]!['offlineMode']!;
  String get sync => _values[locale.languageCode]!['sync']!;
  String get online => _values[locale.languageCode]!['online']!;
  String get offline => _values[locale.languageCode]!['offline']!;
  String get leaderboard => _values[locale.languageCode]!['leaderboard']!;
  String get score => _values[locale.languageCode]!['score']!;
  String get rank => _values[locale.languageCode]!['rank']!;
  String get join => _values[locale.languageCode]!['join']!;
  String get waitingRoom => _values[locale.languageCode]!['waitingRoom']!;
  String get arena => _values[locale.languageCode]!['arena']!;
  String get result => _values[locale.languageCode]!['result']!;
  String get apply => _values[locale.languageCode]!['apply']!;
  String get createAlert => _values[locale.languageCode]!['createAlert']!;
  String get deleteAccount => _values[locale.languageCode]!['deleteAccount']!;
  String get updateProfile => _values[locale.languageCode]!['updateProfile']!;
  String get notificationPreferences => _values[locale.languageCode]!['notificationPreferences']!;
  String get language => _values[locale.languageCode]!['language']!;
  String get darkMode => _values[locale.languageCode]!['darkMode']!;
  String get bengali => _values[locale.languageCode]!['bengali']!;
  String get english => _values[locale.languageCode]!['english']!;
  String get question => _values[locale.languageCode]!['question']!;
  String get next => _values[locale.languageCode]!['next']!;
  String get previous => _values[locale.languageCode]!['previous']!;
  String get finish => _values[locale.languageCode]!['finish']!;
  String get timeLeft => _values[locale.languageCode]!['timeLeft']!;
  String get weakAreas => _values[locale.languageCode]!['weakAreas']!;
  String get attempts => _values[locale.languageCode]!['attempts']!;
  String get averageScore => _values[locale.languageCode]!['averageScore']!;
  String get completed => _values[locale.languageCode]!['completed']!;
  String get inProgress => _values[locale.languageCode]!['inProgress']!;
  String get notStarted => _values[locale.languageCode]!['notStarted']!;
  String get description => _values[locale.languageCode]!['description']!;
  String get noInternet => _values[locale.languageCode]!['noInternet']!;
  String get somethingWentWrong => _values[locale.languageCode]!['somethingWentWrong']!;
  String get permissionDenied => _values[locale.languageCode]!['permissionDenied']!;
  String get camera => _values[locale.languageCode]!['camera']!;
  String get gallery => _values[locale.languageCode]!['gallery']!;
  String get remove => _values[locale.languageCode]!['remove']!;
  String get close => _values[locale.languageCode]!['close']!;
  String get continueAction => _values[locale.languageCode]!['continue']!;
  String get skip => _values[locale.languageCode]!['skip']!;
  String get editProfile => _values[locale.languageCode]!['editProfile']!;
  String get orders => _values[locale.languageCode]!['orders']!;
  String get applications => _values[locale.languageCode]!['applications']!;
  String get reader => _values[locale.languageCode]!['reader']!;
  String get getStarted => _values[locale.languageCode]!['getStarted']!;

  static const Map<String, Map<String, String>> _values = {
    'en': {
      'appName': 'LiveMCQ3',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'phone': 'Phone',
      'name': 'Name',
      'submit': 'Submit',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'home': 'Home',
      'categories': 'Categories',
      'contests': 'Contests',
      'jobs': 'Jobs',
      'books': 'Books',
      'profile': 'Profile',
      'settings': 'Settings',
      'notifications': 'Notifications',
      'logout': 'Logout',
      'loading': 'Loading...',
      'error': 'Error',
      'retry': 'Retry',
      'noData': 'No data available',
      'ok': 'OK',
      'otp': 'OTP',
      'sendOtp': 'Send OTP',
      'verifyOtp': 'Verify OTP',
      'resendOtp': 'Resend OTP',
      'biometricLogin': 'Biometric Login',
      'enableBiometric': 'Enable Biometric',
      'examHistory': 'Exam History',
      'bookmarks': 'Bookmarks',
      'savedJobs': 'Saved Jobs',
      'library': 'Library',
      'orderHistory': 'Order History',
      'checkout': 'Checkout',
      'paymentPending': 'Payment Pending',
      'paymentSuccess': 'Payment Successful',
      'paymentFailed': 'Payment Failed',
      'cvBuilder': 'CV Builder',
      'createCv': 'Create CV',
      'editCv': 'Edit CV',
      'previewCv': 'Preview CV',
      'downloadPdf': 'Download PDF',
      'duplicate': 'Duplicate',
      'analytics': 'Analytics',
      'offlineMode': 'Offline Mode',
      'sync': 'Sync',
      'online': 'Online',
      'offline': 'Offline',
      'leaderboard': 'Leaderboard',
      'score': 'Score',
      'rank': 'Rank',
      'join': 'Join',
      'waitingRoom': 'Waiting Room',
      'arena': 'Arena',
      'result': 'Result',
      'apply': 'Apply',
      'createAlert': 'Create Alert',
      'deleteAccount': 'Delete Account',
      'updateProfile': 'Update Profile',
      'editProfile': 'Edit Profile',
      'orders': 'Orders',
      'applications': 'Applications',
      'reader': 'Reader',
      'notificationPreferences': 'Notification Preferences',
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'bengali': 'Bengali',
      'english': 'English',
      'question': 'Question',
      'next': 'Next',
      'previous': 'Previous',
      'finish': 'Finish',
      'timeLeft': 'Time Left',
      'weakAreas': 'Weak Areas',
      'attempts': 'Attempts',
      'averageScore': 'Average Score',
      'completed': 'Completed',
      'inProgress': 'In Progress',
      'notStarted': 'Not Started',
      'description': 'Description',
      'noInternet': 'No internet connection',
      'somethingWentWrong': 'Something went wrong',
      'permissionDenied': 'Permission denied',
      'camera': 'Camera',
      'gallery': 'Gallery',
      'remove': 'Remove',
      'close': 'Close',
      'continue': 'Continue',
      'skip': 'Skip',
      'getStarted': 'Get Started',
    },
    'bn': {
      'appName': 'লাইভএমসিকিউ3',
      'login': 'লগইন',
      'register': 'রেজিস্ট্রার',
      'email': 'ইমেইল',
      'password': 'পাসওয়ার্ড',
      'confirmPassword': 'পাসওয়ার্ড নিশ্চিত করুন',
      'phone': 'ফোন',
      'name': 'নাম',
      'submit': 'জমা দিন',
      'cancel': 'বাতিল',
      'save': 'সংরক্ষণ',
      'delete': 'মুছুন',
      'home': 'হোম',
      'categories': 'ক্যাটাগরি',
      'contests': 'প্রতিযোগিতা',
      'jobs': 'চাকরি',
      'books': 'বই',
      'profile': 'প্রোফাইল',
      'settings': 'সেটিংস',
      'notifications': 'নোটিফিকেশন',
      'logout': 'লগআউট',
      'loading': 'লোড হচ্ছে...',
      'error': 'ত্রুটি',
      'retry': 'পুনরায় চেষ্টা',
      'noData': 'কোন তথ্য নেই',
      'ok': 'ঠিক আছে',
      'otp': 'ওটিপি',
      'sendOtp': 'ওটিপি পাঠান',
      'verifyOtp': 'ওটিপি যাচাই',
      'resendOtp': 'ওটিপি পুনরায় পাঠান',
      'biometricLogin': 'বায়োমেট্রিক লগইন',
      'enableBiometric': 'বায়োমেট্রিক চালু করুন',
      'examHistory': 'পরীক্ষার ইতিহাস',
      'bookmarks': 'বুকমার্ক',
      'savedJobs': 'সংরক্ষিত চাকরি',
      'library': 'লাইব্রেরি',
      'orderHistory': 'অর্ডার ইতিহাস',
      'checkout': 'চেকআউট',
      'paymentPending': 'পেমেন্ট লম্বিত',
      'paymentSuccess': 'পেমেন্ট সফল',
      'paymentFailed': 'পেমেন্ট ব্যর্থ',
      'cvBuilder': 'সিভ বিল্ডার',
      'createCv': 'সিভ তৈরি',
      'editCv': 'সিভ সম্পাদনা',
      'previewCv': 'সিভ প্রিভিউ',
      'downloadPdf': 'পিডিএফ ডাউনলোড',
      'duplicate': 'অনুলিপি',
      'analytics': 'বিশ্লেষণ',
      'offlineMode': 'অফলাইন মোড',
      'sync': 'সিঙ্ক',
      'online': 'অনলাইন',
      'offline': 'অফলাইন',
      'leaderboard': 'লিডারবোর্ড',
      'score': 'স্কোর',
      'rank': 'র‍্যাঙ্ক',
      'join': 'যোগ দিন',
      'waitingRoom': 'অপেক্ষারুম',
      'arena': 'অ্যারেনা',
      'result': 'ফলাফল',
      'apply': 'আবেদন',
      'createAlert': 'অ্যালার্ট তৈরি',
      'deleteAccount': 'অ্যাকাউন্ট মুছুন',
      'updateProfile': 'প্রোফাইল আপডেট',
      'editProfile': 'প্রোফাইল সম্পাদনা',
      'orders': 'অর্ডার',
      'applications': 'আবেদন',
      'reader': 'রিডার',
      'notificationPreferences': 'নোটিফিকেশন পছন্দ',
      'language': 'ভাষা',
      'darkMode': 'ডার্ক মোড',
      'bengali': 'বাংলা',
      'english': 'ইংলিশ',
      'question': 'প্রশ্ন',
      'next': 'পরবর্তী',
      'previous': 'পূর্ববর্তী',
      'finish': 'শেষ করুন',
      'timeLeft': 'সময় বাকি',
      'weakAreas': 'দুর্বল এলাকা',
      'attempts': 'প্রয়াস',
      'averageScore': 'গড় স্কোর',
      'completed': 'সম্পূর্ণ',
      'inProgress': 'চালু',
      'notStarted': 'শুরু হয়নি',
      'description': 'বিবরণ',
      'noInternet': 'ইন্টারনেট সংযোগ নেই',
      'somethingWentWrong': 'কিছু সমস্যা হয়েছে',
      'permissionDenied': 'অনুমতি অস্বীকার',
      'camera': 'ক্যামেরা',
      'gallery': 'গ্যালারি',
      'remove': 'সার্চ',
      'close': 'বন্ধ',
      'continue': 'চালিয়ে যান',
      'skip': 'এড়িয়ে যান',
      'getStarted': 'শুরু করুন',
    }
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'bn'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
