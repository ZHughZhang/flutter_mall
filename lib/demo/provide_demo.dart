import 'package:flutter/material.dart';

import 'package:provide/provide.dart';
import 'Counter.dart';

class provide_demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Counter>(builder: (context, child, counter) {
        return Text(
          '${counter.value}',
          style: Theme.of(context).textTheme.display1,
        );
      }),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('递增'),
      ),
    );
  }
}
