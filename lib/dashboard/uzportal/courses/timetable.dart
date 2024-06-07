import 'package:flutter/material.dart';

class TimetablePage extends StatelessWidget {
  final List<Map<String, String>> timetableData = [
    {
      "Department": "Computer Science",
      "Level": "Year 2",
      "Code": "CS201",
      "Name": "Data Structures and Algorithms",
      "Venue": "LT2",
      "Time": "9:00 AM",
      "Duration": "2 hours",
      "Lecturer": "Dr. Johnson",
    },
    {
      "Department": "Computer Science",
      "Level": "Year 2",
      "Code": "CS202",
      "Name": "Database Management Systems",
      "Venue": "LT1",
      "Time": "11:00 AM",
      "Duration": "2 hours",
      "Lecturer": "Dr. Davis",
    },
    {
      "Department": "Computer Science",
      "Level": "Year 2",
      "Code": "CS203",
      "Name": "Operating Systems",
      "Venue": "LT3",
      "Time": "2:00 PM",
      "Duration": "2 hours",
      "Lecturer": "Dr. Wilson",
    },
    {
      "Department": "Computer Science",
      "Level": "Year 2",
      "Code": "CS204",
      "Name": "Computer Networks",
      "Venue": "LT4",
      "Time": "4:00 PM",
      "Duration": "2 hours",
      "Lecturer": "Dr. Smith",
    },
  ];

  TimetablePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses Timetable"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Department")),
            DataColumn(label: Text("Level")),
            DataColumn(label: Text("Code")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Venue")),
            DataColumn(label: Text("Time")),
            DataColumn(label: Text("Duration")),
            DataColumn(label: Text("Lecturer")),
          ],
          rows: timetableData.map((data) => _timetableDataRow(data)).toList(),
        ),
      ),
    );
  }

  DataRow _timetableDataRow(Map<String, String> data) {
    return DataRow(
      cells: [
        DataCell(Text(data["Department"] ?? "")),
        DataCell(Text(data["Level"] ?? "")),
        DataCell(Text(data["Code"] ?? "")),
        DataCell(Text(data["Name"] ?? "")),
        DataCell(Text(data["Venue"] ?? "")),
        DataCell(Text(data["Time"] ?? "")),
        DataCell(Text(data["Duration"] ?? "")),
        DataCell(Text(data["Lecturer"] ?? "")),
      ],
    );
  }
}
