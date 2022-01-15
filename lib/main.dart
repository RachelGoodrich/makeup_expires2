import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeup_expires2/page/product_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Makeup Expires!';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    themeMode: ThemeMode.light,
    theme: ThemeData(
      primaryColor: Colors.pink,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.pink,
        elevation: 0,
      ),
    ),
    home: ProductsPage(),
  );
}