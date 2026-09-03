class ApiEndpoints {
  ApiEndpoints._();

  static const String version = '/api/v1';

  // Public endpoints (no auth required)
  static const String login = '$version/login';
  static const String register = '$version/register';
  static const String smsSendOtp = '$version/sms/send-otp';
  static const String smsVerifyOtp = '$version/sms/verify-otp';
  static const String categories = '$version/categories';
  static const String syllabuses = '$version/syllabus';
  static const String jobs = '$version/jobs';
  static const String books = '$version/books';
  static const String courses = '$version/courses';
  static const String contests = '$version/contests';
  static const String cvTemplates = '$version/cv-templates';
  static const String leaderboard = '$version/leaderboard';
  static const String dailyQuiz = '$version/quiz/daily';
  static const String submitDailyQuiz = '$version/quiz/submit';

  // Authenticated endpoints
  static const String me = '$version/me';
  static const String logout = '$version/logout';
  static const String profile = '$version/profile';
  static const String orders = '$version/orders';
  static const String offlinePracticeDownload = '$version/practice/download';
  static const String notificationsRegister = '$version/notifications/register';
  static const String notificationsPreferences = '$version/notifications/preferences';

  // Parameterized endpoints
  static String questions(int categoryId) => '$version/categories/$categoryId/questions';
  static String submitCategory(int categoryId) => '$version/categories/$categoryId/submit';
  static String subjects(int categoryId) => '$version/categories/$categoryId/subjects';
  static String chapters(int subjectId) => '$version/subjects/$subjectId/chapters';
  static String bookmarkQuestion(int questionId) => '$version/questions/$questionId/bookmark';
  static String removeBookmark(int questionId) => '$version/questions/$questionId/bookmark';
  static String bookmarks = '$version/bookmarks';
  static String examHistory = '$version/exam-history';
  static String jobDetail(int jobId) => '$version/jobs/$jobId';
  static String jobSave(int jobId) => '$version/jobs/$jobId/save';
  static String jobUnsave(int jobId) => '$version/jobs/$jobId/unsave';
  static String savedJobs = '$version/jobs/saved';
  static String jobCategories = '$version/job-categories';
  static String bookDetail(int bookId) => '$version/books/$bookId';
  static String bookPreview(int bookId) => '$version/books/$bookId/preview';
  static String bookDownload(int bookId) => '$version/books/$bookId/download';
  static String contestDetail(int contestId) => '$version/contests/$contestId';
  static String contestJoin(int contestId) => '$version/contests/$contestId/join';
  static String contestSubmit(int contestId) => '$version/contests/$contestId/submit';
  static String contestArena(int contestId) => '$version/contests/$contestId/arena';
  static String contestResult(int contestId) => '$version/contests/$contestId/result';
  static String paymentStatus(String transactionId) => '$version/payments/status/$transactionId';
  static String paymentsInitiate = '$version/payments/initiate';
  static String paymentsVerify = '$version/payments/verify';
  static String offlinePracticeSync(int packId) => '$version/practice/offline/$packId/sync';
  static String jobAlerts = '$version/job-alerts';
  static String jobAlertDetail(int id) => '$version/job-alerts/$id';
  static const String cvs = '$version/cvs';
  static String cvDetail(int id) => '$version/cvs/$id';
  static String cvSection(int id, String section) => '$version/cvs/$id/sections/$section';
  static String cvDuplicate(int id) => '$version/cvs/$id/duplicate';
  static String cvPdf(int id) => '$version/cvs/$id/pdf';

  // BDApps DCB Single-Rail Auth & Billing
  static const String dcbOperatorCheck = '$version/auth/operator-check';
  static const String dcbOtpSend = '$version/auth/otp/send';
  static const String dcbVerifyAndSubscribe = '$version/auth/otp/verify-and-subscribe';
  static const String dcbBillingCancel = '$version/billing/cancel';
  static const String billingGateways = '$version/billing/gateways';

  // Quiz Payment Flow
  static String quizAccess(int categoryId) => '$version/quiz/$categoryId/access';
  static String quizInitiatePayment(int categoryId) => '$version/quiz/$categoryId/pay';
  static String quizVerifyDcbPayment(int categoryId) => '$version/quiz/$categoryId/pay/verify-dcb';
  static String quizMyAccess() => '$version/quiz/my-access';

  // Legacy Carrier Billing
  static const String carrierBillingOtpRequest = '$version/carrier-billing/otp/request';
  static const String carrierBillingOtpVerify = '$version/carrier-billing/otp/verify';
  static const String carrierBillingStatus = '$version/carrier-billing/status';
  static const String carrierBillingUnsubscribe = '$version/carrier-billing/unsubscribe';
  static const String carrierBillingCharge = '$version/carrier-billing/charge';
}
