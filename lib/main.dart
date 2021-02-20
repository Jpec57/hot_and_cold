import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_and_cold/pages/home/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request().isGranted;
  await Permission.locationWhenInUse.request().isGranted;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hot and Cold',
      // supportedLocales: [
      //   const Locale(EN_LOCALE),
      //   const Locale(FR_LOCALE),
      //   const Locale(JAP_LOCALE),
      // ],
      navigatorKey: Get.key,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(headline1: TextStyle(fontSize: 30))),
      onGenerateRoute: (settings) {
        // if (settings.name == DeckPage.routeName) {
        //   final DeckPageArguments args = settings.arguments;
        //
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       return DeckPage(
        //         id: args.id,
        //       );
        //     },
        //   );
        // }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      routes: {
        // LoginPage.routeName: (context) => LoginPage(),
      },
      home: HomePage(),
    );
  }
}
