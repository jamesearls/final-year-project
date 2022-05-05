import 'package:firebase_auth/firebase_auth.dart';
import 'screens/screens.dart';

late final User user;
var appRoutes = {
  '/': (context) => HomeScreen(),
  '/index': (context) => const IndexScreen(),
  '/login': (context) => const LoginScreen(),
  // '/register': (context) => RegisterScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/map': (context) => const MapScreen(),
  '/admin': (context) => AdminPageView(),
};
