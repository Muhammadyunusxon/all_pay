import 'package:flutter/material.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProsteIndexedStack(
        children: [],
      ),
    );
  }
}
