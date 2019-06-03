import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//轮播下面的导航栏
class TopNav extends StatelessWidget {
	
	final  List nav_list;//导航栏数据
	
	
	TopNav({Key key,this.nav_list}):super(key:key);
	
	
	Widget _gridViewItemUI(BuildContext con,item){
			return InkWell(
				onTap: (){
					print('点击了一下');
				},
				child: Column(
					children: <Widget>[
						Image.network(item['image'],fit: BoxFit.fill,width: ScreenUtil().setWidth(95),),
						Text(item['mallCategoryName']),
					],
				),
				
			);
	}
	
	@override
  Widget build(BuildContext context) {
		if(this.nav_list.length > 10) {
			this.nav_list.removeRange(10,this.nav_list.length);//移除 从某一位开始到某一位结束
		}//
    return Container(
	    height: ScreenUtil().setHeight(320),
	    padding: EdgeInsets.all(3.0),
	    child: GridView.count(
		    physics: NeverScrollableScrollPhysics(),//禁止滚动,解决滑动冲突
		    controller:ScrollController(),
		    crossAxisCount: 5,
		    padding: EdgeInsets.all(5.0),
		    children:nav_list.map((item){
		    	  return _gridViewItemUI(context, item);
		    }).toList(),
	    ),
	    
    );
  }
}
