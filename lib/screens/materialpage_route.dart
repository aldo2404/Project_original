import 'package:flutter/material.dart';
import 'package:fx_project/screens/screens_routeGenerator.dart';

class MaterialPageRoutes extends StatelessWidget {
  const MaterialPageRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: ScreenRouteGenerator.routeGenerator,
    );
  }
}
