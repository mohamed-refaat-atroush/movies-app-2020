import 'package:flutter/material.dart';
import 'package:movies_app_2020/providers/movies.dart';
import 'package:provider/provider.dart';
import 'screens/tabs_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Movies()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies 2020',
        theme: ThemeData.dark(),
        home: TabsScreen(),
      ),
    );
  }
}
