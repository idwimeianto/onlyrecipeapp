import 'package:onlyrecipeapp/favorites/favorites.dart';
import 'package:onlyrecipeapp/home/home.dart';
import 'package:onlyrecipeapp/index/index.dart';
import 'package:onlyrecipeapp/login/login.dart';
import 'package:onlyrecipeapp/profile/profile.dart';

var appRoutes = {
  '/': (context) => const IndexScreen(),
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/favorites': (context) => const FavoritesScreen(),
};
