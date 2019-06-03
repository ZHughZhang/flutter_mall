import 'package:flutter/material.dart';
import '../demo/provide_demo.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    body: Center(child:Column(
        children: <Widget>[
          Number(),
          provide_demo(),
        ],
      ),),
    );
  }
}



