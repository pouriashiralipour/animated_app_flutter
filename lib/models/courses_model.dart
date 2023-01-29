import 'package:flutter/material.dart';

class Course {
  final String title, description, src;
  final Color color;

  Course(
      {required this.title,
      this.description = "Build and animate an IOS app from scratch",
      this.src = "assets/icons/ios.svg",
      this.color = const Color(0xFF7553F6)});
}

List<Course> courses = [
  Course(title: "Animations in SwiftUI"),
  Course(
      title: "Animations in Flutter",
      src: "assets/icons/code.svg",
      color: const Color(0xFF80A4FF))
];

List<Course> recentCourses = [
  Course(title: "State Machine"),
  Course(
      title: "Animated Menu",
      src: "assets/icons/code.svg",
      color: const Color(0xFF9CC5FF)),
  Course(title: "Flutter with Rive"),
  Course(
      title: "Animated Menu",
      src: "assets/icons/code.svg",
      color: const Color(0xFF9CC5FF)),
];
