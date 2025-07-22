import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/routes/routes.dart';
import 'core/routes/routes_services.dart';
import 'core/styles/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      onGenerateRoute: RouteServices.generateRoute,
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(),
        scaffoldBackgroundColor: AppColors.offWhite,
      ),
    );
  }
}
