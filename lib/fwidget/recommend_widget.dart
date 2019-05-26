import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//商品推荐
class Recommens extends StatelessWidget {
  final List recommend_list;

  Recommens({Key key, this.recommend_list}) : super(key: key);

  //商品推荐
  Widget _titleWidget() {
    return Container(
      alignment:Alignment.centerLeft,
      height: ScreenUtil().setHeight(60),
      padding: EdgeInsets.only(left: 10),
      child: Text(
        '商品推荐',
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
      decoration: BoxDecoration(
          color:Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 0.5,
            ),
          )),
    );
  }

  //商品的item
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(color: Colors.black12, width: 0.5),
            )),
        child: Column(
          children: <Widget>[
            Image.network('${recommend_list[index]['image']}'),
            Text('¥${recommend_list[index]['mallPrice']}'),
            Text(
              '¥${recommend_list[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget _recommend_list() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
          scrollDirection: Axis.horizontal, //横向滚动
          itemCount: recommend_list.length,
          itemBuilder: (context, index) {
            return _item(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommend_list()],
      ),
    );
  }
}
