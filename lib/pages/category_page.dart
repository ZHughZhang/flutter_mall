import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../model/category_model.dart';
import '../provide_class/child_category.dart';
import '../provide_class/category_goods_list.dart';
import '../model/good_list.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategory(),
                ItemGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryModel> category_list = [];
  var oldIndex = 0;

  @override
  void initState() {
    _getCategory();
    //getItemGoodsListInfo().itemGoodsList(context, categoryId: '4',subId: '');
    getItemGoodsListInfo()
        .itemGoodsList(context, categoryId: '4', subId: '', page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemBuilder: (con, index) {
          return _leftInkWell(index);
        },
        itemCount: category_list.length,
      ),
    );
  }

  Widget _leftInkWell(index) {
    bool isClick = false;
    isClick = (index == oldIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          oldIndex = index;
        });
        Provide.value<ChildCategory>(context).getChildCategory(
            category_list[index].bxMallSubDto,
            category_list[index].mallCategoryId);
        getItemGoodsListInfo().itemGoodsList(context,
            categoryId: category_list[index].mallCategoryId, subId: '');
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          category_list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await getCategory().then((val) {
      var data = json.decode(val.toString());
      CategoryListModel listModel = CategoryListModel.formJson(data['data']);
      setState(() {
        category_list = listModel.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory(
          category_list[0].bxMallSubDto, category_list[0].mallCategoryId);
    });
  }
}

class RightCategory extends StatefulWidget {
  @override
  _RightCategoryState createState() => _RightCategoryState();
}

class _RightCategoryState extends State<RightCategory> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, list) {
      return Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.list.length,
            itemBuilder: (context, index) {
              return _rightInkWell(index, list.list[index]);
            }),
      );
    });
  }

  Widget _rightInkWell(index, item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex
        ? true
        : false);
    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changChildIndex(index, item.mallSubId); //点击之后切换 字体颜色;
        getItemGoodsListInfo().itemGoodsList(context, subId: item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

//子类列表
class ItemGoodsList extends StatefulWidget {
  @override
  _ItemGoodsListState createState() => _ItemGoodsListState();
}

//子类列表的动态生成类
class _ItemGoodsListState extends State<ItemGoodsList> {
  GlobalKey<RefreshFooterState> footKey = GlobalKey();
  GlobalKey<RefreshHeaderState> headertKey = GlobalKey();
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(builder: (context, child, _list) {
      try {
        if (!Provide.value<ChildCategory>(context).loadMored)
          scrollController.jumpTo(0.0);
        /*if(Provide.value<ChildCategory>(context).page ==1) {
          
          }*/
      } catch (e) {
        print('进入页面第一次初始化${e}');
      }
      return _list.getItemGoodsList.length > 0
          ? Expanded(
              //继承 Flexible  有一定的伸缩能力, 可以解决屏幕溢出
              child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: footKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  moreInfo: '加载更多',
                  loadReadyText: '上拉加载...',
                ),
                refreshHeader: ClassicsHeader(
                  key: headertKey,
                  bgColor: Colors.white,
                  textColor: Colors.pinkAccent,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  refreshedText: '刷新完毕',
                  refreshingText: '刷新ing....',
                  refreshText: '下拉刷新',
                ),
                loadMore: () async {
                  Provide.value<ChildCategory>(context).setLoadMoreTag();
                  Provide.value<ChildCategory>(context).setPage();
                  await getItemGoodsListInfo().itemGoodsList(
                    context,
                    isLoadMore: true,
                  );
                  //print('${Provide.value<ChildCategory>(context).page}>>>>>>>>>>>');
                },
                onRefresh: () async {
                  Provide.value<ChildCategory>(context).setRefreshpage();
                  getItemGoodsListInfo().itemGoodsList(context);
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return _itemGoodsListWidget(_list.getItemGoodsList, index);
                  },
                  itemCount: _list.getItemGoodsList.length,
                ),
              ),
              alignment: Alignment.center,
            ))
          : Text(
              '暂时没有数据',
              style: TextStyle(fontSize: ScreenUtil().setSp(30)),
            );
    });
  }

//商品列表
  Widget _goodsImage(List<ItemGoods> data, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(data[index].image),
    );
  }

//商品的名字
  Widget _goodsName(List<ItemGoods> data, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      alignment: Alignment.centerLeft,
      child: Text(
        data[index].goodsName,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

//商品价格
  Widget _goodsPrice(List<ItemGoods> data, index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            '价格:   ¥${data[index].presentPrice}',
            textAlign: TextAlign.left,
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          )),
          Expanded(
            child: Text(
              '¥ ${data[index].presentPrice}',
              style: TextStyle(
                  color: Colors.black12,
                  decoration: TextDecoration.lineThrough,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          ),
        ],
      ),
    );
  }

//商品列表
  Widget _itemGoodsListWidget(List<ItemGoods> data, index) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(color: Colors.black12, width: 1))),
          child: Row(
            children: <Widget>[
              _goodsImage(data, index),
              Column(
                children: <Widget>[
                  _goodsName(data, index),
                  _goodsPrice(data, index),
                ],
              )
            ],
          ),
        ));
  }
}

//子类的请求Api
class getItemGoodsListInfo {
  void itemGoodsList(context,
      {page, categoryId, isLoadMore = false, String subId}) {
    var data = {
      'categoryId': categoryId == null
          ? Provide.value<ChildCategory>(context).categoryId
          : categoryId,
      'categorySubId':
          subId == null ? Provide.value<ChildCategory>(context).subId : subId,
      'page': page == null ? Provide.value<ChildCategory>(context).page : page,
    };
    getMallGoods(data).then((val) {
      var goodsinfo = json.decode(val.toString());
      ItemGoodsList_ itemGoodsList = ItemGoodsList_.formJson(
         goodsinfo['data']== null ? []:goodsinfo['data']);
      
      print('${goodsinfo}');

      if (goodsinfo['data'] == null) {
        if (isLoadMore) {
          print('加载更多,没有数据了');
          Fluttertoast.showToast(
              msg: '已经到底了',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              timeInSecForIos: 1,
              fontSize: 16.0);
          Provide.value<ChildCategory>(context).setNoMoreText('没有更多数据了');
        } else {
          Provide.value<CategoryGoodsListProvide>(context)
              .getCategoryGoodsListProvide([]);
        }
      } else {
        if ((isLoadMore)) {
          Provide.value<CategoryGoodsListProvide>(context)
              .getMoreList(itemGoodsList.data);
        } else {
          Provide.value<CategoryGoodsListProvide>(context)
              .getCategoryGoodsListProvide(itemGoodsList.data);
        }
      }
    });
  }
}
