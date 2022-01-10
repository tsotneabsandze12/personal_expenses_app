import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_expenses_app/presentation/views/home_view.dart';
import 'package:personal_expenses_app/presentation/views/login_view.dart';
import 'package:provider/provider.dart';
import 'domain/providers/state_provider.dart';

void main() {
  runApp(
    // DevicePreview(
    //   enabled: true,
    //builder: (BuildContext context) =>
    ChangeNotifierProvider(
      create: (ctx) => StateProvider(),
      child: const MyApp(),
    ),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Personal Expenses App',
      theme: ThemeData(
        primaryColor: const Color(0xffcbefef),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context)
              .textTheme,
        ).copyWith(
          bodyText1: GoogleFonts.poppins(),
          bodyText2: GoogleFonts.poppins(),
          subtitle1: GoogleFonts.poppins(),
          subtitle2: GoogleFonts.poppins(),
          button: GoogleFonts.poppins(),
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
