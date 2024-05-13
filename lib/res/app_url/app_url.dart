class AppUrl {

  /// base Url
  static const String baseurl = "https://qca.com.pk";


  ///  Auth Api
  static const String loginApi = "$baseurl/api/v1/login";
  static const String signupapi = "$baseurl/api/v1/register";
  static const String forgetapi = "$baseurl/api/v1/password/email";
  static const String otpapi = "$baseurl/api/v1/password/code/check";



  static const String homeDashboardapi = "$baseurl/api/v1/dashboard";

  static const String getGroupsText = "$baseurl/api/v1/student/getGroups";

  static const String getTestApi = "$baseurl/api/v1/student/getCourseTests";
  static const String courseApi = "https://qca.com.pk/api/v1/courseList";

  static const String coursedetailapi = "$baseurl/api/v1/student/getCourseById";

  static const String studentCourseapi = "$baseurl/api/v1/student/myCourses";

  static const String videoapi = "$baseurl/api/v1/student/getCourseVideos";

  static const String coursealbum = "$baseurl/api/v1/student/getCourseAlbums";

  /// MyResults Api
  static const String getMyResult1 = "$baseurl/api/v1/student/myResultsCourses";
  static const String getMyResultsTestApi = "$baseurl/api/v1/student/myResultsTests";

  static const String finalResultApi = "$baseurl/api/v1/student/myFinalResults";
}
