// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/poli_user_controller.dart';

class PoliUserView extends GetView<PoliUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PoliUserView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Responsive Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'My App Title', // Replace with your title
                  style: TextStyle(fontSize: 24.0),
                ),
              ),

              // Image with Aspect Ratio
              AspectRatio(
                aspectRatio: 3 / 2, // Adjust based on image dimensions
                child: Image.asset(
                    'assets/image.jpg'), // Replace with your image path
              ),

              // Content with Padding
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ));
  }
}
