import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListDrink extends StatefulWidget {
  const ListDrink({Key? key}) : super(key: key);

  @override
  State<ListDrink> createState() => _ListDrinkState();


}

class _ListDrinkState extends State<ListDrink> {
  late Stream<QuerySnapshot> _usersStream;
  final List<int> _data = <int>[];

  @override
  void initState() {
    _usersStream = FirebaseFirestore.instance
        .collection('product')
        .where('product_category', isEqualTo: 'D')
        .snapshots();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(
      title: const Text('Choose Drink'),
    ),

       body: LayoutBuilder(
         builder: (BuildContext context, BoxConstraints constraints) {
           return SingleChildScrollView(
               child: Column(
                 children: <Widget>[
                   Container(
                     width: constraints.maxWidth,
                     height: constraints.maxHeight * 0.80,
                     child: getListDrink(),
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
       )  ,

    );

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

  Widget getListDrink(){
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
}
