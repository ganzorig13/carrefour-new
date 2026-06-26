import 'package:carrefour/library/library.dart';
import 'package:carrefour/main_config.dart';
import 'package:carrefour/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainConfig.setStoreConfig();
  await MainConfig.setFirebaseConfig();
  await MainConfig.setOrientationConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(MainController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Carrefour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: IOPages.initial,
      getPages: IOPages.pages,
      navigatorObservers: [routeObserver],
    );
  }
}
