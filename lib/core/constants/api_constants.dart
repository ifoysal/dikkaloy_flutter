class ApiConstants {
  static const String baseUrlKey = 'API_BASE_URL';

  static String get baseUrl {
    const url = String.fromEnvironment('API_BASE_URL', defaultValue: 'https://dikkhaloy.kidsgrow.com.bd');
    return url.replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp(r'/+$'), '');
  }

  static String get authLogin => '$baseUrl/login';
  static String get authRegister => '$baseUrl/register';
  static String get authMe => '$baseUrl/me';
  static String get authLogout => '$baseUrl/logout';
  static String get categories => '$baseUrl/categories';
  static String subjects(int categoryId) => '$baseUrl/categories/$categoryId/subjects';
  static String chapters(int subjectId) => '$baseUrl/subjects/$subjectId/chapters';
  static String syllabus() => '$baseUrl/syllabus';
  static String categoryQuestions(int categoryId) => '$baseUrl/categories/$categoryId/questions';
  static String submitExam(int categoryId) => '$baseUrl/categories/$categoryId/submit';
  static String examHistory() => '$baseUrl/exam-history';
  static String bookmarkQuestion(int questionId) => '$baseUrl/questions/$questionId/bookmark';
  static String bookmarks() => '$baseUrl/bookmarks';
  static String profile() => '$baseUrl/profile';
  static String contests() => '$baseUrl/contests';
  static String contest(int id) => '$baseUrl/contests/$id';
  static String joinContest(int id) => '$baseUrl/contests/$id/join';
  static String submitContest(int id) => '$baseUrl/contests/$id/submit';
  static String contestArena(int id) => '$baseUrl/contests/$id/arena';
  static String contestResult(int id) => '$baseUrl/contests/$id/result';
  static String leaderboard() => '$baseUrl/leaderboard';
  static String jobs() => '$baseUrl/jobs';
  static String job(int id) => '$baseUrl/jobs/$id';
  static String saveJob(int id) => '$baseUrl/jobs/$id/save';
  static String unsaveJob(int id) => '$baseUrl/jobs/$id/unsave';
  static String savedJobs() => '$baseUrl/jobs/saved';
  static String jobAlerts() => '$baseUrl/job-alerts';
  static String jobAlert(int id) => '$baseUrl/job-alerts/$id';
  static String applications() => '$baseUrl/applications';
  static String books() => '$baseUrl/books';
  static String book(int id) => '$baseUrl/books/$id';
  static String bookPreview(int id) => '$baseUrl/books/$id/preview';
  static String bookDownload(int id) => '$baseUrl/books/$id/download';
  static String orders() => '$baseUrl/orders';
  static String paymentsInitiate() => '$baseUrl/payments/initiate';
  static String paymentsVerify() => '$baseUrl/payments/verify';
  static String paymentsStatus(String transactionId) => '$baseUrl/payments/status/$transactionId';
  static String cvs() => '$baseUrl/cvs';
  static String cv(int id) => '$baseUrl/cvs/$id';
  static String cvSection(int id, String section) => '$baseUrl/cvs/$id/sections/$section';
  static String cvDuplicate(int id) => '$baseUrl/cvs/$id/duplicate';
  static String cvPdf(int id) => '$baseUrl/cvs/$id/pdf';
  static String cvTemplates() => '$baseUrl/cv-templates';
  static String notificationsRegister() => '$baseUrl/notifications/register';
  static String notificationsPreferences() => '$baseUrl/notifications/preferences';
  static String quizDaily() => '$baseUrl/quiz/daily';
  static String quizSubmit() => '$baseUrl/quiz/submit';
  static String get analytics => '$baseUrl/analytics';
  static String practiceDownload() => '$baseUrl/practice/download';
  static String practiceOfflineSync(int id) => '$baseUrl/practice/offline/$id/sync';
  static String smsSendOtp() => '$baseUrl/sms/send-otp';
  static String smsVerifyOtp() => '$baseUrl/sms/verify-otp';
  static String carrierBillingOtpRequest() => '$baseUrl/carrier-billing/otp/request';
  static String carrierBillingOtpVerify() => '$baseUrl/carrier-billing/otp/verify';
  static String carrierBillingStatus() => '$baseUrl/carrier-billing/status';
  static String carrierBillingUnsubscribe() => '$baseUrl/carrier-billing/unsubscribe';
  static String carrierBillingCharge() => '$baseUrl/carrier-billing/charge';
}
