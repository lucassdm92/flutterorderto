import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateDrink extends StatefulWidget {
  const CreateDrink({Key? key}) : super(key: key);

  @override
  State<CreateDrink> createState() => CreateDrink_State();
}

class CreateDrink_State extends State<CreateDrink> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');

  final _formKey = GlobalKey<FormState>();

  final titleDrinkController = TextEditingController();
  final priceDrinkController = TextEditingController();
  final descriptionDrinkController = TextEditingController();

  Future<void> addProduct() {
    // Call the user's CollectionReference to add a new user
    return product
        .add({
          'product_title': titleDrinkController.text,
          'product_quantity': 0,
          'product_price': priceDrinkController.text,
          'product_category': "D", // Food
          'product_description': descriptionDrinkController.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Drink'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("Please enter the Drinks Tittle");
                        }
                        return null;
                      },
                      controller: titleDrinkController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Please enter the Drinks Tittle"),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("Please enter the Drinks Price");
                        }
                        return null;
                      },
                      controller: priceDrinkController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Please enter the Drinks Price"),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("Please enter the Drinks description");
                        }
                        return null;
                      },
                      controller: descriptionDrinkController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Please enter the Drinks description"),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addProduct()
                              .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content:
                                          Text('Registered Successfully'))))
                              .catchError((error) =>
                                  print("Failed to add user: $error"))
                              .whenComplete(() => Navigator.pop(context));
                        }
                      },
                      child: const Text("Submit"),
                    ))
              ],
            )),
      ),
    );
  }
}
