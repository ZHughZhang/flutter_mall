import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

//服务热像
class CallLeaderPhone extends StatelessWidget {
 
	final Map leaderinfo;
	
	CallLeaderPhone({Key key,this.leaderinfo}):super(key: key); //店长的电话+头像
	
	
	
  @override
  Widget build(BuildContext context) {
    return Container(
	    width: MediaQuery.of(context).size.width,
	    child: InkWell(
		    onTap: _launchUrl,
		    child: Image.network('${leaderinfo['leaderImage']}',fit: BoxFit.fill,),
	    ),
    );
  }
  void _launchUrl() async{
  	  String  url = 'tel:'+leaderinfo['leaderPhone'];
  	  
  	  if (await canLaunch(url)){
  	  	await launch(url);
	    }else{
  	  	throw 'Could not launch $url';
	    }
  }
}
