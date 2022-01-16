import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[800],
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      title: 'Notes',
      home: const SignInPage(),
    );
  }
}
