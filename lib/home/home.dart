import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlyrecipeapp/services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onlyrecipeapp/meals/meal_item.dart';
import 'package:onlyrecipeapp/shared/bottom_nav.dart';
import 'package:onlyrecipeapp/shared/error.dart';
import 'package:onlyrecipeapp/shared/loading.dart';
import 'dart:developer';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categorie>>(
        future: TheMealDBService().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var categorieList = snapshot.data!;
            var categoryListTemp = categorieList.map((s) => s.strCategory);
            var categories = ['All', ...categoryListTemp];

            return Scaffold(
              appBar: AppBar(
                title: Text('Home'),
                automaticallyImplyLeading: false,
              ),
              body: ContentWidget(categories: categories),
              bottomNavigationBar: const BottomNavBar(
                index: 0,
              ),
            );
          } else {
            return const Text('No data found in Firestore. Check database');
          }
        });
    ;
  }
}

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key, required this.categories});

  final List<String> categories;

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  late TextEditingController _controller;
  final myController = TextEditingController();
  bool showMeals = false;

  String dropdownValue = 'All';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        top: 0,
        right: 16,
        bottom: 0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: myController,
            ),
            Divider(),
            DropdownButton<String>(
              isExpanded: true,
              menuMaxHeight: 300,
              value: dropdownValue,
              icon: const Icon(FontAwesomeIcons.chevronDown),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: widget.categories
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Divider(),
            ElevatedButton.icon(
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.white,
                size: 20,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                minimumSize: const Size.fromHeight(0),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  showMeals = true;
                });
              },
              label: Text('Search', textAlign: TextAlign.center),
            ),
            showMeals
                ? FutureBuilder<List<Meal>>(
                    future: TheMealDBService()
                        .getMeals(myController.text, dropdownValue),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingScreen();
                      } else if (snapshot.hasError) {
                        return Center(
                          child:
                              ErrorMessage(message: snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        var meals = snapshot.data!;

                        log('masuk future $showMeals');

                        return GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          crossAxisSpacing: 10.0,
                          crossAxisCount: 2,
                          children: meals
                              .map((meal) => MealItem(meal: meal))
                              .toList(),
                        );
                      } else {
                        return const Text(
                            'No data found in Firestore. Check database');
                      }
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
