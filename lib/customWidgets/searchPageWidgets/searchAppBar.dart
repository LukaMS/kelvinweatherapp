// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: camel_case_types
class searchAppBar extends StatelessWidget {
  const searchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 98, 39, 176),
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Search City',
          style: TextStyle(
            color: Colors.white,
          ),
          ),
      );
  }
}