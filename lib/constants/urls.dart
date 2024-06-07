//store urls
class Urls {
  static const String baseUrl = "https://d5d0-196-4-80-2.ngrok-free.app/api";
  static const String uzLogin = baseUrl + "/login";
  static const String uzLogout = baseUrl + "/logout";

  //Courses
  static const String getCourses = "$baseUrl/courses";
  static const String getCoursesByDepartment = "$baseUrl/courses/department";
  static const String deleteCourse = "$baseUrl/courses/delete";
  static const String updateCourse = "$baseUrl/courses/update";
  static const String addCourse = "$baseUrl/courses/add";

  //Departments
  static const String getDepartments = "$baseUrl/departments";

  //Timetable
  static const String getTimetable = "$baseUrl/timetable";
  static const String getTimetableByDepartment =
      "$baseUrl/timetable/department";
  static const String generateTimetable = "$baseUrl/timetable/generate";
}
