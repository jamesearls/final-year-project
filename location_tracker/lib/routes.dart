import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_tracker/screens/home_screen/home_screen.dart';
import 'package:location_tracker/screens/login_screen/login_screen.dart';
import 'package:location_tracker/screens/register_screen/register_screen.dart';
import 'package:location_tracker/screens/profile_screen/profile_screen.dart';
import 'package:location_tracker/screens/map_screen/map_screen.dart';
import 'package:location_tracker/screens/index_screen/index_screen.dart';

late final User user;
var appRoutes = {
  '/': (context) => HomeScreen(),
  '/index': (context) => const IndexScreen(),
  '/login': (context) => const LoginScreen(),
  // '/register': (context) => RegisterScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/map': (context) => const MapScreen(),
};
