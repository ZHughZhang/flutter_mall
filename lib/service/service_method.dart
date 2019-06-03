import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';


//获取首页主题内容


class HttpRequest {
	var url;
	var requestMethod;
	var date;
	var options;
	HttpRequest({ this.url, this.requestMethod, this.date,this.options}):
				assert(url != null){
		if (this.requestMethod == null){  this.requestMethod = 'get';}
	}
	
/*	Future getHttpRequest2()async{
		try {
			Response response;
			Dio dio = Dio();
			if (options == null) {
				dio.options.contentType = ContentType.parse('application/x-www-from-urlencode;charset=UTF-8');
			}
			if (requestMethod == 'get') {
				response = await dio.get(url,queryParameters: date,options:  options);
			}else if(requestMethod == 'post') {
				response = await dio.post(url,options: options,data: !(date is Map) ? date: null);
			}
			
			if (response.statusCode == 200) {
				return response.data;
			}else {
				throw Exception('错误代码 :${response.statusCode}');
			}
		}catch(e){
			return print('======================>$e');
		}
	}*/
	
	Future getHttpRequest() async{
		try {
			Response response;
			Dio dio = Dio();
			if (options == null) {
				dio.options.contentType = ContentType.parse('application/x-www-from-urlencode;charset=UTF-8');
			}
			LogInterceptor logInterceptor = LogInterceptor();
			//dio.interceptors.add(logInterceptor);
			//print(logInterceptor.printAll(dio.options.toString()));
			if (requestMethod == 'get') {
					response = await dio.get(url,queryParameters: date,options:  options);
			}else if(requestMethod == 'post') {
				response = await dio.post(url,queryParameters: date is Map? date: null,options: options,data: !(date is Map) ? date: null);
			}
			
			if (response.statusCode == 200) {
				return response.data;
			}else {
				throw Exception('错误代码 :${response.statusCode}');
			}
		}catch(e){
			return print('======================>$e');
		}
	}
	
}


//商品首页的商品
dynamic getHomePageContent()  {
	try {
		var fromData = {'lon': '121.36236572265625', 'lat': '31.242551803588867'};
		return HttpRequest(url:servicePath['homePageContent'],date: fromData ,requestMethod: 'post').getHttpRequest();
	} catch (e) {
		print('ERRO========================>$e');
	}
}

//火爆专区的接口
dynamic getHotContent({Map page })  {
	try {
		
		return HttpRequest(url: servicePath['hot'],requestMethod: 'post',date: page).getHttpRequest();
	} catch (e) {
		print('ERRO========================>$e');
	}
}

//获取分类接口

dynamic getCategory () {
	return HttpRequest(url: servicePath['category'],requestMethod: 'post',date: null).getHttpRequest();
}

//分类界面的商品列表

dynamic getMallGoods(goodsinfo){
	return HttpRequest(url: servicePath['getMallGoods'],requestMethod: 'post',date: goodsinfo).getHttpRequest();
}