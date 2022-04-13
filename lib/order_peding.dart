import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPending extends StatefulWidget {
  const OrderPending({Key? key}) : super(key: key);

  @override
  _OrderPendingState createState() => _OrderPendingState();
}

class _OrderPendingState extends State<OrderPending> {
  final List<Widget> items = [
   const Text( "Funfou"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
    const Text("Funfou2"),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    return Container(
      width: size.width,
      height: size.height * 0.79,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  <Widget> [
                    const Text("Order Number 12LO98"),

                    const SizedBox(width: 50),

                    ElevatedButton(onPressed: (){},
                        child: const Text("Aceitar")),

                    const SizedBox(width: 10),

                    ElevatedButton(
                        onPressed: (){},
                        child: const Text("Rejeitar"),
                      style: style,
                    ),
                    const SizedBox(width: 10)


                  ],
                ),
                Container(
                  child: Text("TEste"),
                  alignment: Alignment.topLeft,
                )



              ],

            ),
          );
        },
      ),
    );
  }
}
