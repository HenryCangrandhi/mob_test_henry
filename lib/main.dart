import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mob_test_henry/blocs/user_bloc.dart';
import 'package:mob_test_henry/blocs/user_event.dart';
import 'package:mob_test_henry/route/app_route.dart';
import 'package:mob_test_henry/screen/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetUserEvent()),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteClass.getHomeRoute(),
        getPages: RouteClass.routes,
      ),
    );
  }
}