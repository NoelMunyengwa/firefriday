import 'package:flutter/material.dart';

String getGreeting(String name) {
  var now = DateTime.now();
  int hour = now.hour;

  if (hour < 12) {
    return "Good morning, $name!";
  } else if (hour < 17) {
    return "Good afternoon, $name!";
  } else {
    return "Good evening, $name!";
  }
}
