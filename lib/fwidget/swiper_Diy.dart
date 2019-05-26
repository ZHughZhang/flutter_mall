import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//首页轮播图
class SwiperDiy extends StatelessWidget {
  final List swiper_date; //轮播图的地址数组

  SwiperDiy({Key key,this.swiper_date}):super(key:key);

  @override
  Widget build(BuildContext context) {
    print( '设备高:${ScreenUtil.screenHeight}=====>设备宽:${ScreenUtil.screenWidth}=========>设备像素:${ScreenUtil.pixelRatio}');
    return  Container(
      height:ScreenUtil().setHeight(333) ,
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiper_date.length, //数组的长度
        itemBuilder: (BuildContext context, int index) {//构建以个图片容器
          //
          return Image.network(
              '${swiper_date[index]['image']}',
            fit: BoxFit.fill,
            
          );
        },
        autoplay: swiper_date.length >1? true : false, //是否自动播放
        pagination: SwiperPagination(), //设置分页指示器
      ),
    );
  }
}
