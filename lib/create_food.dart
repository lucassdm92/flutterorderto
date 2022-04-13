import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterorderto/create_category.dart';

import 'food_creator.dart';

class CreateMeal extends StatefulWidget {
  const CreateMeal({Key? key}) : super(key: key);

  @override
  _CreateMealState createState() => _CreateMealState();
}

class _CreateMealState extends State<CreateMeal> {
  @override
  Widget build(BuildContext context) {
    CollectionReference product =
        FirebaseFirestore.instance.collection('product');
    return Column(
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateCategory()));
            },
            child: const Text("Create Category")),
        ElevatedButton(onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FoodCreator()));
        }, child: const Text("Create a Product")),
      ],
    );
  }
}
