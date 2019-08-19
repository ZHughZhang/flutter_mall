import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:flutter_mall/demo/Counter.dart';
import 'package:provide/provide.dart';
import 'package:flutter_mall/provide_class/child_category.dart';
import 'package:flutter_mall/provide_class/category_goods_list.dart';
import 'package:fluro/fluro.dart';

void main() {
  var counter = Counter();
  var provides = Providers();
  var caregory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  final router = Router();
  
  provides
    ..provide(Provider<Counter>.value(counter))
     ..provide(Provider<ChildCategory>.value(caregory))
  ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
  runApp(ProviderNode(child: MyApp(), providers: provides));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pinkAccent,
        ),
        home: IndexPage(),
      ),
    );
  }
}
