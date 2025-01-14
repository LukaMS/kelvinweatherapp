// ignore_for_file: file_names

import 'package:flutter/material.dart';

class searchButton extends StatelessWidget {
  const searchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
              color: Colors.black,
              icon: const Icon(Icons.search),
              iconSize: 35,
              onPressed: () async {
                Navigator.pushNamed(context, '/search');
              },
            );
  }
}