import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

//楼层title
class FloorTitle extends StatelessWidget {
	final String pic_url ;
	
	
	FloorTitle({Key key,this.pic_url}):super(key:key);
	
  @override
  Widget build(BuildContext context) {
    return Container(
	    padding: EdgeInsets.all(8.0),
	    child: Image.network(pic_url,fit: BoxFit.fill,),
    );
  }
}


//楼层商品列表

class FloorContent extends StatelessWidget {
	
	final List floorgoods;
	
	FloorContent({Key key,this.floorgoods}):super(key:key);
	
  @override
  Widget build(BuildContext context) {
    return Container(
	    child: Column(
		    children: <Widget>[
		    	_firstRow(),
			    _otherGoods(),
		    ],
	    ),
    );
  }
  
  Widget _firstRow(){
  	return Row(
		  children: <Widget>[
		  	_goodItem(floorgoods[0]),
		  	Column(
				  children: <Widget>[
					  _goodItem(floorgoods[1]),
					  _goodItem(floorgoods[2]),
				  ],
			  ),
		  
		  ],
	  );
  }
  
  
  Widget _otherGoods(){
  	return Row(
		  children: <Widget>[
			  _goodItem(floorgoods[3]),
			  _goodItem(floorgoods[4]),
		  ],
	  );
  }
  
  Widget _goodItem(Map goods){
  	return Container(
		  width: ScreenUtil().setWidth(375),
		  child:InkWell(
			  onTap: (){},
			  child: Image.network(goods['image']),
		  ),
	  );
  }
}

