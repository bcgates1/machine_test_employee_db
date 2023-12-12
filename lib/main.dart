import 'package:flutter/material.dart';
import 'controllers/home_screen_provider.dart';
import 'models/database_helper.dart';
import 'package:provider/provider.dart';

import 'utils/globals.dart';
import 'views/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Globals.kheight = MediaQuery.sizeOf(context).height;
    Globals.kwidth = MediaQuery.sizeOf(context).width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeScreenProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Globals.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
