class AuthApi {
  // base url of image folders
  static const String baseUrlSliderImage = "https://cmi.edu.pk/qca/slide/";

  static const String _name = "name";

  static const String loginApi = "https://cmi.edu.pk/qca/api/v1/login";
  static const String registerApi = "https://cmi.edu.pk/qca/api/v1/register";
  static const String resetpasswordApi =
      "https://cmi.edu.pk/qca/api/v1/password/email";
  static const String otpApi =
      "https://cmi.edu.pk/qca/api/v1/password/code/check";
  static const String resetspasswordApi =
      "https://cmi.edu.pk/qca/api/v1/password/reset";
  static const String getDashboardApi =
      "https://cmi.edu.pk/qca/api/v1/dashboard";

  static const String getDashboardApi2 =
      "https://cmi.edu.pk/qca/api/v1/baseurl/category/xxxxxxx";
  static const String courseApi = "https://cmi.edu.pk/qca/api/v1/courseList";
  static const String getPayApi =
      "https://cmi.edu.pk/qca/api/v1/student/myPayments";
  static const String postInvoiceById =
      "https://cmi.edu.pk/qca/api/v1/student/getInvoiceById";
  static const String getstudentCourse =
      "https://cmi.edu.pk/qca/api/v1/student/myCourses";
  static const String getstudentCourseById =
      "https://cmi.edu.pk/qca/api/v1/student/getCourseById";
  static const String uploadReceiptApi =
      "https://cmi.edu.pk/qca/api/v1/student/uploadReceipt";
  static const String videoLecturesApi =
      "https://cmi.edu.pk/qca/api/v1/student/getCourseVideos";
  static const String getTestApi =
      "https://cmi.edu.pk/qca/api/v1/student/getCourseTests";
  static const String startTestApi =
      "https://cmi.edu.pk/qca/api/v1/student/startTest";

  static const String testinfo =
      "https://cmi.edu.pk/qca/api/v1/student/testInfo";
  static const String getQuestionTestApi =
      "https://cmi.edu.pk/qca/api/v1/student/getTestQuestions";
  static const String postAnswerApi =
      "https://cmi.edu.pk/qca/api/v1/student/postAnswers";
  static const String getMyResult1 =
      "https://cmi.edu.pk/qca/api/v1/student/myResultsCourses";
  static const String getMyResultsTestApi =
      "https://cmi.edu.pk/qca/api/v1/student/myResultsTests";
  static const String getMyfinalResultApi =
      "https://cmi.edu.pk/qca/api/v1/student/myFinalResults";

  static const String getMyWalletApi =
      "https://cmi.edu.pk/qca/api/v1/student/myWallet";

  static const String createInvoiceid =
      'https://cmi.edu.pk/qca/api/v1/student/createInvoice';
  static const String showBankInvoice =
      'https://cmi.edu.pk/qca/api/v1/student/paymentGateWay/posting_url/';
  static const String getInvoiceByIdApi =
      'https://cmi.edu.pk/qca/api/v1/student/getInvoiceById';
  static const String billInquiryApi =
      "https://cmi.edu.pk/qca/api/v1/BillInquiry";

  static const String billPaymentApi =
      "https://cmi.edu.pk/qca/api/v1/BillPayment";

  static const String getTestfee =
      "https://cmi.edu.pk/qca/api/v1/student/getTestFee";
}
