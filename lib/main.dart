import 'package:flutter/material.dart';
import 'package:note_app_flutter/pages/main_page.dart';
import 'pages/welcome_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var box = await Hive.openBox('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.blueGrey[50], // Changed scaffold background color
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.teal), // Changed text color
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
