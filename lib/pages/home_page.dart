import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../fwidget/swiper_Diy.dart';
import '../fwidget/top_nav.dart';
import '../fwidget/AD_banner.dart';
import '../fwidget/call_leaderphone.dart';
import '../fwidget/recommend_widget.dart';
import '../fwidget/floor_ttitle.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
/*
* AutomaticKeepAliveClientMixin 页面防止重复加载
* 必须是动态加载的页面才能使用 页面保活
*
* */
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(//解决异步渲染
          future: getHomePageContent(),
          builder: (BuildContext context,spanshot){
            if(spanshot.hasData){
                  var data = json.decode(spanshot.data.toString());
                  print('${data['data']['slides']}=====================>');
                  data = data['data'];
                  List<Map> swiper = (data['slides'] as List).cast();
                  List<Map> nav = (data['category'] as List).cast();
                  Map<String,dynamic> ad = Map.from(data['advertesPicture']);
                  Map<String,dynamic> leaderinfo = Map.from(data['shopInfo']);
                  List<Map> recommend  = (data['recommend'] as List).cast();
                  String floorTitle = data['floor1Pic']['PICTURE_ADDRESS'];
                  String floor2Title = data['floor2Pic']['PICTURE_ADDRESS'];
                  String floor3Title = data['floor3Pic']['PICTURE_ADDRESS'];
                  List<Map> floor1Content = (data['floor1'] as List).cast();
                  List<Map> floor2Content = (data['floor2'] as List).cast();
                  List<Map> floor3Content = (data['floor3'] as List).cast();
                  return SingleChildScrollView(
                    child: Column (
                      children: <Widget>[
                        SwiperDiy(swiper_date: swiper,),
                        TopNav(nav_list: nav,),
                        ADBanner(ad_list: ad,),
                        CallLeaderPhone(leaderinfo: leaderinfo,),
                        Recommens(recommend_list: recommend,),
                        FloorTitle(pic_url: floorTitle,),
                        FloorContent(floorgoods: floor1Content,),
                        FloorTitle(pic_url: floor2Title,),
                        FloorContent(floorgoods: floor2Content,),
                        FloorTitle(pic_url: floor3Title,),
                        FloorContent(floorgoods: floor3Content,),
                      ],
                    ),
                  ) ;
            }else {
                return Center(
                child: Text('加载中',style:TextStyle(fontSize:ScreenUtil().setSp(28))),
                );
            }
          }
      ),//解决异步网络请求,无需在setSate渲染
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

