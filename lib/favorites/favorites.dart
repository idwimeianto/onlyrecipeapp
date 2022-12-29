import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:onlyrecipeapp/services/services.dart';
import 'package:onlyrecipeapp/shared/bottom_nav.dart';
import 'package:onlyrecipeapp/shared/error.dart';
import 'package:onlyrecipeapp/shared/loading.dart';
import 'dart:developer';

// class FavoritesScreen extends StatefulWidget {
//   const FavoritesScreen({super.key});

//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var favorites = Provider.of<Favorites>(context);

//     log('data: ${favorites.meals}');

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorites'),
//         automaticallyImplyLeading: false,
//       ),
//       bottomNavigationBar: const BottomNavBar(
//         index: 1,
//       ),
//     );
//   }
// }

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Meal>(
      future: TheMealDBService().getMealById('52771'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
            ),
            // body: GridView.count(
            //   primary: false,
            //   padding: const EdgeInsets.all(20.0),
            //   crossAxisSpacing: 10.0,
            //   crossAxisCount: 2,
            // ),
            bottomNavigationBar: const BottomNavBar(index: 1),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
