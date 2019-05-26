import 'package:flutter/material.dart';



class ADBanner extends StatelessWidget {
	
	Map<String,dynamic> _ad_list;
	
	
	ADBanner({Key key,Map<String,dynamic> ad_list}):super(key:key){
		  _ad_list = ad_list;
	}
	
	@override
  Widget build(BuildContext context) {
		
		print(_ad_list);
		
    return Container(
	    child: Image.network('${_ad_list['PICTURE_ADDRESS']}'),
    );
  }
}
