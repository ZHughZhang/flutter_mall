import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../fwidget/swiper_diy_widget.dart';
import '../fwidget/top_nav_widget.dart';
import '../fwidget/ad_banner_widget.dart';
import '../fwidget/call_leader_phone_widget.dart';
import '../fwidget/recommend_widget.dart';
import '../fwidget/floor_ttitle_widget.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/*
* AutomaticKeepAliveClientMixin 页面防止重复加载
* 必须是动态加载的页面才能使用 页面保活
*
* */
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //
  int page = 1;
  List hotGoodsList = [];
  GlobalKey<RefreshFooterState> _globalKey = GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _refreshKey = GlobalKey<RefreshHeaderState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
          //解决异步渲染
          future: getHomePageContent(),
          builder: (BuildContext context, spanshot) {
            if (spanshot.hasData) {
              var data = json.decode(spanshot.data.toString());
              //print('${data['data']['slides']}=====================>');
              data = data['data'];
              List<Map> swiper = (data['slides'] as List).cast();
              List<Map> nav = (data['category'] as List).cast();
              Map<String, dynamic> ad = Map.from(data['advertesPicture']);
              Map<String, dynamic> leaderinfo = Map.from(data['shopInfo']);
              List<Map> recommend = (data['recommend'] as List).cast();
              String floorTitle = data['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1Content = (data['floor1'] as List).cast();
              List<Map> floor2Content = (data['floor2'] as List).cast();
              List<Map> floor3Content = (data['floor3'] as List).cast();
              return EasyRefresh(
                refreshFooter: ClassicsFooter(//定义底部上拉刷新的样式
                  key: _globalKey,//必须添加
                  bgColor: Colors.white,
                  textColor: Colors.pinkAccent,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  moreInfo: '加载更多',
                  noMoreText: '没有更多了',
                ),
                refreshHeader: ClassicsHeader(
                    key: _refreshKey,
                  bgColor: Colors.white,
                  textColor: Colors.pinkAccent,
                  showMore: true,
                  refreshedText: '刷新完毕',
                  refreshingText: '刷新ing',
                  refreshText: '下拉刷新',
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SwiperDiy(
                        swiper_date: swiper,
                      ),
                      TopNav(
                        nav_list: nav,
                      ),
                      ADBanner(
                        ad_list: ad,
                      ),
                      CallLeaderPhone(
                        leaderinfo: leaderinfo,
                      ),
                      Recommens(
                        recommend_list: recommend,
                      ),
                      FloorTitle(
                        pic_url: floorTitle,
                      ),
                      FloorContent(
                        floorgoods: floor1Content,
                      ),
                      FloorTitle(
                        pic_url: floor2Title,
                      ),
                      FloorContent(
                        floorgoods: floor2Content,
                      ),
                      FloorTitle(
                        pic_url: floor3Title,
                      ),
                      FloorContent(
                        floorgoods: floor3Content,
                      ),
                      _hotGoods(),
                    ],
                  ),
                ),
                loadMore: () async {//加载更富哦
                  var frompage = {'page': page};
                  await getHotContent(page: frompage).then((val) {
                    setState(() {
                      hotGoodsList.addAll(work_data(val));
                      page++;
                    });
                  });
                },
                onRefresh: () async {//下拉刷新
                  page=1;
                  var from_page = {'page':page};
                  await getHotContent(page: from_page).then((val){
                     setState(() {
                        hotGoodsList.clear();
                        hotGoodsList.addAll(work_data(val));
                     });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中',
                    style: TextStyle(fontSize: ScreenUtil().setSp(28))),
              );
            }
          }), //解决异步网络请求,无需在setSate渲染
    );
  }
  dynamic work_data (data) =>((json.decode(data.toString())['data'] as List).toList());
  
  
  
  Widget _goodsTitle = Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(2.0),
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: null,
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('${val['mallPrice']}'),
                    Text(
                      '${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[_goodsTitle, _wrapList()],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
