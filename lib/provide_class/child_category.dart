import 'package:flutter/material.dart';
import '../model/category_model.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> list = [];
  int childIndex = 0;//右边top 的状态改变索引
  String categoryId ='4';//左侧菜单ID
  String subId = '';// 小类
  int page = 1;//页码
  String noMoreText = '';//显示没有数据提示
  
  bool loadMored = false;

  getChildCategory(List<BxMallSubDto> list_,categoryId) {
  
    need_to_recover();
    this.categoryId = categoryId;
    this.childIndex = 0; //每次切换左侧菜单进行清零
    BxMallSubDto bxMallSubDto = BxMallSubDto('', '00', '全部', 'null');
    this.list = [bxMallSubDto];
    this.list.addAll(list_);
    notifyListeners();
  }
  //需要复原的数据
  need_to_recover() {
    this.page=1;
    this.noMoreText='';
    this.loadMored = false;
  }

  //改变子类索引
  changChildIndex(index,subId) {
    need_to_recover();
    this.childIndex = index;
    this.subId = subId;
    notifyListeners();
  }
  
  setPage(){
     this. page++;
  }
  setRefreshpage () {
    this.page =1;
  }
  setNoMoreText (noMoreText) {
    this.noMoreText = noMoreText;
      this.notifyListeners();
  }
  
  setLoadMoreTag(){
    this.loadMored = true;
  }
  
}
