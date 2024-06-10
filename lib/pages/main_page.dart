import 'package:flutter/material.dart';
import 'notes_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotesPage(),
    );
  }
}
