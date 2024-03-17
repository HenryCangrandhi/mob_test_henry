import 'package:get/get.dart';
import 'package:mob_test_henry/screen/user_list.dart';

class RouteClass{
  static String home = "/";

  static String getHomeRoute() => home;

  static List<GetPage> routes = [
    GetPage(name: home, page: ()=> UserList(title: "User Data")),
  ];
}