import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  
  @override
  void initState() {
    super.initState();
   
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(child:  FutureBuilder(
      future: getHotContent(),
        builder:(context,data){
            if (data.hasData) {
              var  datas = json.decode(data.data.toString());
                return Text('测试');
            }else {
               return  Center(child: Text('加载中....'),) ;
            }
        }),);
  }
  
  Widget _hottitle  = Container (
    child: Text('火爆专区'),
  );
  
}
