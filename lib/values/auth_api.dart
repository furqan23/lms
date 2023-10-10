class AuthApi {
  static const String _name = "name";

  static const String loginApi = "https://cmi.edu.pk/qca/api/v1/login";
  static const String registerApi =
      "https://cmi.edu.pk/qca/api/v1/register";
  static const String resetpasswordApi =
      "https://cmi.edu.pk/qca/api/v1/password/email";
  static const String otpApi =
      "https://cmi.edu.pk/qca/api/v1/password/code/check";
  static const String resetspasswordApi =
      "https://cmi.edu.pk/qca/api/v1/password/reset";
  static const String getDashboardApi =
      "https://cmi.edu.pk/qca/api/v1/dashboard";
  static const String courseApi =
      "https://cmi.edu.pk/qca/api/v1/courseList";
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

  static const String testinfo ="https://cmi.edu.pk/qca/api/v1/student/testInfo";
  static const String getQuestionTestApi =
      "https://cmi.edu.pk/qca/api/v1/student/getTestQuestions";
  static const String postAnswerApi =
      "https://cmi.edu.pk/qca/api/v1/student/postAnswers";
  static const String getMyResult1 ="https://cmi.edu.pk/qca/api/v1/student/myResultsCourses";
  static const String getMyResultsTestApi =
      "https://cmi.edu.pk/qca/api/v1/student/myResultsTests";
  static const String getMyfinalResultApi =
      "https://cmi.edu.pk/qca/api/v1/student/myFinalResults";

  static const String baseUrlSliderImage="https://cmi.edu.pk/qca/public/slide/";
}
