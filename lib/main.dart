import 'package:course_example/managers/breath_manager.dart';
import 'package:course_example/managers/notification_manager.dart';
import 'package:course_example/managers/skew_manager.dart';
import 'package:course_example/views/splash_sceen.dart';
import 'package:flutter/material.dart';
import 'package:oak_tree/oak_tree.dart';

void main() async {
  await setupOakTree(callback: () {
    oak.registerLazySingleton(() => BreathManager());
    oak.registerLazySingleton(() => SkewManager());
    oak.registerLazySingleton(() => NotificationManager());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplasScreen(),
    );
  }
}
