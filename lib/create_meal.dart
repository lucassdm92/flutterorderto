import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterorderto/list_drink.dart';
import 'package:flutterorderto/list_meal.dart';

class CreateMeals extends StatefulWidget {
  const CreateMeals({Key? key}) : super(key: key);

  @override
  State<CreateMeals> createState() => _CreateMealsState();
}

class _CreateMealsState extends State<CreateMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Meal'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.80,
                child: const ListMeal(),
              ),

              ElevatedButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListDrink()));
              }, child: Text("NEXT"))

            ],
          ));
        },
      ),
    );
  }
}
