import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateIngredient extends StatefulWidget {
  const CreateIngredient({Key? key}) : super(key: key);

  @override
  _CreateIngredientState createState() => _CreateIngredientState();
}

class _CreateIngredientState extends State<CreateIngredient> {
  final titleIngredient = TextEditingController();
  final qtyIngredient = TextEditingController();
  final amountIngredient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    CollectionReference product =
        FirebaseFirestore.instance.collection('product');

    Future<void> addProduct() {
      // Call the user's CollectionReference to add a new user
      return product
          .add({
            'product_title': titleIngredient.text, // John Doe
            'product_quantity': qtyIngredient.text, // Stokes and Sons
            'product_price': amountIngredient.text,
            'product_category': "I" // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Ingredient'),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: titleIngredient,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Tittle';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Enter the tittle"),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: qtyIngredient,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Quantity';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Quantity"),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: amountIngredient,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Amount';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Amount"),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addProduct()
                                  .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                          SnackBar(content: Text('Registered Successfully'))))
                                  .catchError((error) =>
                                      print("Failed to add user: $error")).whenComplete(() => Navigator.pop(context));
                            }
                          },
                          child: Text("Submit"),
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
