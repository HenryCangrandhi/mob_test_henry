import 'package:get/get.dart';
import 'package:mob_test_henry/screen/home_screen.dart';
import 'package:mob_test_henry/screen/user_list.dart';

class RouteClass{
  static String home = "/home";
  static String userList = "/userList";

  static String getHomeRoute() => home;
  static String getUserList() => userList;

  static List<GetPage> routes = [
    GetPage(name: home, page: ()=> const HomeScreen(title: 'Home')),
    GetPage(name: userList, page: ()=> const UserList(title: "User Data")),
  ];
}