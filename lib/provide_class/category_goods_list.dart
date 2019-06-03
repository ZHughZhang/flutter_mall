import 'package:flutter/material.dart';
import '../model/good_list.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<ItemGoods> _list = [];

  List<ItemGoods> get getItemGoodsList => _list;

  getCategoryGoodsListProvide(List<ItemGoods> list) {
    this._list = list;
    notifyListeners();
  }

  getMoreList(List<ItemGoods> itemList) {
    _list.addAll(itemList);
    notifyListeners();
  }
}
