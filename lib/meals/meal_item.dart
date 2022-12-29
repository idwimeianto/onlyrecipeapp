import 'package:flutter/material.dart';
import 'package:onlyrecipeapp/services/services.dart';
import 'package:onlyrecipeapp/shared/shared.dart';
import 'dart:developer';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('masuk meal item');

    return Hero(
      tag: meal.strMealThumb,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (BuildContext context) => TopicScreen(topic: topic),
          //     ),
          //   );
          // },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                    // child: Image.asset(
                    //   'assets/covers/${topic.img}',
                    //   fit: BoxFit.contain,
                    // ),
                    ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    meal.strMeal,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              // Flexible(child: TopicProgress(topic: topic)),
            ],
          ),
        ),
      ),
    );
  }
}

// class TopicScreen extends StatelessWidget {
//   final Topic topic;

//   const TopicScreen({super.key, required this.topic});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       body: ListView(
//         children: [
//           Hero(
//             tag: topic.img,
//             child: Image.asset('assets/covers/${topic.img}',
//                 width: MediaQuery.of(context).size.width),
//           ),
//           Text(
//             topic.title,
//             style: const TextStyle(
//                 height: 2, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           QuizList(topic: topic),
//         ],
//       ),
//     );
//   }
// }
