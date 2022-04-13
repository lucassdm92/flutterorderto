import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterorderto/checkbox_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterorderto/checklist_datails.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('category');

  //Controllers Text
  final categoryTitleController = TextEditingController();
  final categoryDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> addProduct() {
    // Call the user's CollectionReference to add a new user
    return product
        .add({
          'category_title': categoryTitleController.text,
          'category_description': categoryDescription.text
        })
        .then((value) => print("Category Added"))
        .catchError((error) => print("Failed to add Category: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Category'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
                child: Column(
              children: <Widget>[
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Tittle';
                        }
                        return null;
                      },
                      controller: categoryTitleController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Enter the category title"),
                    )),
                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Tittle';
                        }
                        return null;
                      },
                      controller: categoryDescription,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Enter the category description"),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addProduct()
                              .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content:
                                          Text('Registered Successfully'))))
                              .catchError((error) =>
                                  print("Failed to add user: $error"))
                              .whenComplete(() => Navigator.pop(context));
                        }
                      },
                      child: Text("Submit"),
                    ))
              ],
            ))
          ],
        );
      }),
    );
  }
}
