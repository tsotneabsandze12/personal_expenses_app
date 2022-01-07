import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_expenses_app/presentation/views/home_view.dart';
import 'package:personal_expenses_app/presentation/views/login_view.dart';
import 'package:provider/provider.dart';
import 'domain/providers/state_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => StateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Personal Expenses Aoo',
      theme: ThemeData(
        primaryColor: const Color(0xffcbefef),
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.poppins(textStyle: textTheme.bodyText1),
        ),
      ),
      initialRoute: LoginView.routeName,
       routes: {
        HomeView.routeName: (context) => const HomeView(),
       },
      home: const LoginView(),
    );
  }
}
