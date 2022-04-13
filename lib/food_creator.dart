import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterorderto/checkbox_state.dart';
import 'package:flutterorderto/radio_state.dart';

import 'checklist_datails.dart';

class FoodCreator extends StatefulWidget {
  const FoodCreator({Key? key}) : super(key: key);

  @override
  State<FoodCreator> createState() => _FoodCreatorState();
}

class _FoodCreatorState extends State<FoodCreator> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference product =
  FirebaseFirestore.instance.collection('product');

  Map<String, CheckBoxState> listChecked = <String, CheckBoxState>{};

  bool recall = true;

  final titleFoodController = TextEditingController();

  final valueFoodController = TextEditingController();

  final descriptionFoodController = TextEditingController();

  final quantityFoodController = TextEditingController();

  Future<void> addProduct() {
    // Call the user's CollectionReference to add a new user
    return product
        .add({
      'product_title': titleFoodController.text, // John Doe
      'product_quantity': quantityFoodController.text, // Stokes and Sons
      'product_price': valueFoodController.text,
      'product_category': "F", // Food
      'product_description': descriptionFoodController.text,
      'product_ingredients': [listChecked.keys.toList().toString()] // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  callback(title, value) {
    if (value) {
      listChecked.putIfAbsent(
          title, () => CheckBoxState(title: title, value: true));
    } else {
      listChecked.remove(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, CheckBoxState> listChecked = <String, CheckBoxState>{};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Tittle Product';
                          }
                          return null;
                        },
                        controller: titleFoodController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Enter the tittle Product"),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the description Product';
                          }
                          return null;
                        },
                        controller: descriptionFoodController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Enter the Description Product"),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the value';
                          }
                          return null;
                        },
                        controller: valueFoodController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Enter the value of Product"),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Quantity Product';
                          }
                          return null;
                        },
                        controller: quantityFoodController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Enter the Quantity Product"),
                      )),
                  Container(height: 100, child: listOfIngradient()),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addProduct()
                                .then((value) =>
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content:
                                    Text('Registered Successfully'))))
                                .catchError((error) =>
                                print("Failed to add user: $error"))
                                .whenComplete(() => Navigator.pop(context));
                          }
                        },
                        child: const Text("Submit"),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listOfIngradient() {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('category')
        .snapshots();
    bool isFalse = false;
    RadioState _radio;
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
                return Radio(value: Text(snapshot.data!.docs[index]['category_title']),
                    groupValue: snapshot.data!.docs[index]['category_title'],
                    onChanged: (newValue) =>
                        setState(() => snapshot.data!.docs[index]));
              });
        });
  }
}
