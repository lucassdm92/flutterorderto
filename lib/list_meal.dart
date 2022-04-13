import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListMeal extends StatefulWidget {
  const ListMeal({Key? key}) : super(key: key);

  @override
  State<ListMeal> createState() => _ListMealState();
}

class _ListMealState extends State<ListMeal> {
  late Stream<QuerySnapshot> _usersStream;
  final List<int> _data = <int>[];

  @override
  void initState() {
    _usersStream = FirebaseFirestore.instance
        .collection('product')
        .where('product_category', isEqualTo: 'F')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (_data.length < snapshot.data!.docs.length) {
            List.generate(snapshot.data!.docs.length, (index) => _data.add(0));
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
                return Card(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data!.docs[index]['product_title']),
                    _data[index] == 0
                        ? showAddButton(index)
                        : showQuantityButton(index),
                  ],
                ));
              });
        });
  }

  Widget showAddButton(int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _data[index]++;
        });
      },
      child: const Text("ADD"),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.blueAccent)))),
    );
  }

  Widget showQuantityButton(int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  _data[index]++;
                });
              },
              icon: const Icon(Icons.add)),
          Text(_data[index].toString()),
          IconButton(
              onPressed: () {
                setState(() {
                  _data[index]--;
                });
              },
              icon: const Icon(Icons.remove))
        ],
      ),
    );
  }
}
