
class ItemGoods {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  ItemGoods({this.image, this.oriPrice, this.presentPrice, this.goodsName,
      this.goodsId});
  
  
  factory ItemGoods.formJson(json){
      return ItemGoods(image:json['image'],oriPrice:json['oriPrice'],presentPrice: json['presentPrice'],goodsName: json['goodsName'],goodsId: json['goodsId'] );
  }
  
}

class  ItemGoodsList_ {
    List<ItemGoods> data;


    ItemGoodsList_(this.data);

    factory ItemGoodsList_.formJson(List json) {
     // if (json!=null)
      return ItemGoodsList_(json.map((val) => ItemGoods.formJson(val)).toList());
      //else return ItemGoodsList_([]);
     }
     
  
  
}