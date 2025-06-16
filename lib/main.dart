
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sun_record/db_sun/db_sun.dart';
import 'package:sun_record/pages/load_error/load_error_binding.dart';
import 'package:sun_record/pages/load_error/load_error_view.dart';
import 'package:sun_record/pages/sun_add/sun_add_binding.dart';
import 'package:sun_record/pages/sun_add/sun_add_check.dart';
import 'package:sun_record/pages/sun_add/sun_add_view.dart';
import 'package:sun_record/pages/sun_main/sun_main_binding.dart';
import 'package:sun_record/pages/sun_main/sun_main_view.dart';
import 'package:sun_record/pages/sun_notic/sun_notic_binding.dart';
import 'package:sun_record/pages/sun_notic/sun_notic_view.dart';

Color primaryColor = const Color(0xff3b82f6);
Color bgColor = const Color(0xfffafafa);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBSun().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Sun,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Sun = [
  GetPage(name: '/', page: () => const SunNoticView(), binding: SunNoticBinding()),
  GetPage(name: '/load_error', page: () => const LoadErrorView(), binding: LoadErrorBinding()),
  GetPage(name: '/sun_main', page: () => const SunMainPage(), binding: SunMainBinding()),
  GetPage(name: '/sun_we', page: () => SunAddCheck()),
  GetPage(name: '/sun_add', page: () => SunAddPage(), binding: SunAddBinding()),
];