class AuthApi {
  // base url of image folders
  static const String baseUrlWeb = "https://qca.com.pk";
  static const String baseUrlSliderImage = "$baseUrlWeb/slide/";
  static const String imageUrl = "$baseUrlWeb/frontend/img/learning.png";
  static const String dashboardImagesBaseUrl = "$baseUrlWeb/category";

  static const String _name = "name";

  static const String loginApi = "https://qca.com.pk/api/v1/login";
  static const String registerApi = "https://qca.com.pk/api/v1/register";

  static const String deleteApi =
      "https://qca.com.pk/api/v1/student/deleteAccount";
  static const String resetpasswordApi =
      "https://qca.com.pk/api/v1/password/email";
  static const String otpApi = "https://qca.com.pk/api/v1/password/code/check";
  static const String resetspasswordApi =
      "https://qca.com.pk/api/v1/password/reset";
  static const String getDashboardApi = "https://qca.com.pk/api/v1/dashboard";

  static const String courseApi = "https://qca.com.pk/api/v1/courseList";
  static const String getPayApi =
      "https://qca.com.pk/api/v1/student/myPayments";
  static const String postInvoiceById =
      "https://qca.com.pk/api/v1/student/getInvoiceById";
  static const String getstudentCourse =
      "https://qca.com.pk/api/v1/student/myCourses";
  static const String getGroupsText =
      "https://qca.com.pk/api/v1/student/getGroups";
  static const String getCourseAlbum =
      "https://qca.com.pk/api/v1/student/getCourseAlbums";
  static const String getstudentCourseById =
      "https://qca.com.pk/api/v1/student/getCourseById";
  static const String uploadReceiptApi =
      "https://qca.com.pk/api/v1/student/uploadReceipt";
  static const String videoLecturesApi =
      "https://qca.com.pk/api/v1/student/getCourseVideos";
  static const String getTestApi =
      "https://qca.com.pk/api/v1/student/getCourseTests";
  static const String startTestApi =
      "https://qca.com.pk/api/v1/student/testInfo";
  static const String testinfo = "https://qca.com.pk/api/v1/student/startTest";
  static const String getQuestionTestApi =
      "https://qca.com.pk/api/v1/student/getTestQuestions";
  static const String postAnswerApi =
      "https://qca.com.pk/api/v1/student/postAnswers";
  static const String getMyResult1 =
      "https://qca.com.pk/api/v1/student/myResultsCourses";
  static const String getMyResultsTestApi =
      "https://qca.com.pk/api/v1/student/myResultsTests";
  static const String getMyfinalResultApi =
      "https://qca.com.pk/api/v1/student/myFinalResults";

  static const String getMyWalletApi =
      "https://qca.com.pk/api/v1/student/myWallet";

  static const String createInvoiceid =
      'https://qca.com.pk/api/v1/student/createInvoice';
  static const String showBankInvoice =
      'https://qca.com.pk/api/v1/student/paymentGateWay/posting_url/';
  static const String getInvoiceByIdApi =
      'https://qca.com.pk/api/v1/student/getInvoiceById';
  static const String billInquiryApi = "https://qca.com.pk/api/v1/BillInquiry";

  static const String billPaymentApi = "https://qca.com.pk/api/v1/BillPayment";

  static const String getTestfee =
      "https://qca.com.pk/api/v1/student/getTestFee";
}
