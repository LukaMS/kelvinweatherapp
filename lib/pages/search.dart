import 'package:flutter/material.dart';
import 'package:weatherapp/customWidgets/searchPageWidgets/searchAppBar.dart';
import 'package:weatherapp/customWidgets/searchPageWidgets/searchBar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: searchAppBar(),
      ),
      body: CustomSearchBar(),
    );
  }
}