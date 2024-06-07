import 'dart:convert';
import 'package:firefriday/constants/urls.dart';
import 'package:http/http.dart' as http;

// Departments

Future<List<Department>> fetchDepartments() async {
  final response = await http.get(Uri.parse(Urls.getDepartments));

  if (response.statusCode == 200) {
    final decodedData = jsonDecode(response.body) as List;
    return decodedData.map((data) => Department.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load departments');
  }
}

class Department {
  final String name;

  Department({required this.name});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      name: json['department'] as String,
    );
  }
}

//Get courses

Future<List<Course>> fetchCourses() async {
  final response = await http.get(Uri.parse(Urls.getCourses));

  if (response.statusCode == 200) {
    final decodedData = jsonDecode(response.body) as List;

    return decodedData.map((data) => Course.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load courses');
  }
}

class Course {
  final String department;
  final String level;
  final String year;
  final String courseCode;
  final String courseTitle;
  final String lecturer;
  final String duration;
  final String isCampusWide;

  Course({
    required this.department,
    required this.level,
    required this.year,
    required this.courseCode,
    required this.courseTitle,
    required this.lecturer,
    required this.duration,
    required this.isCampusWide,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      department: json['department'] as String,
      level: json['level'] as String,
      year: json['year'] as String,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      lecturer: json['lecturer'] as String,
      duration: json['duration'] as String,
      isCampusWide: json['isCampusWide'] as String,
    );
  }
}

//Timetable

// Replace with your actual API endpoint URL
class Timetable {
  final String departments;
  final String levels;
  final String year;
  final String courses;
  final String courseTitle;
  final String lecturers;
  final String durations;
  final bool isCampusWide;

  Timetable({
    required this.departments,
    required this.levels,
    required this.year,
    required this.courses,
    required this.courseTitle,
    required this.lecturers,
    required this.durations,
    required this.isCampusWide,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      departments: json['department'] as String,
      levels: json['level'] as String,
      year: json['year'] as String,
      courses: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      lecturers: json['lecturer'] as String,
      durations: json['duration'] as String,
      isCampusWide: json['isCampusWide'] as bool,
    );
  }
}

Future<String> generateTimetable(List<Timetable> courses) async {
  final response = await http.post(
    Uri.parse(Urls.generateTimetable),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(courses),
  );

  if (response.statusCode == 200) {
    print("Timetable response: " + response.body.toString());
    return response.body;
  } else {
    throw Exception('Failed to generate timetable');
  }
}
