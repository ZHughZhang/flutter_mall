import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';


//获取首页主题内容

Future getHomePageContent() async {
	try {
		print('开始获取首页数据');
		Response response;
		
		Dio dio = Dio();
		
		dio.options.contentType =
				ContentType.parse('application/x-www-form-urlencoded;charset=UTF-8'); //连接方式
		//lon=121.36236572265625&lat=31.242551803588867
		var fromData = {'lon': '121.36236572265625', 'lat': '31.242551803588867'};
		response = await dio.post(servicePath['homePageContent'], data: fromData);//请求地址+提交的数据
		if (response.statusCode == 200) {
			print(response.data);
			return response.data;
		} else {
			throw Exception('异常Code:$response.statusCode');
		}
	} catch (e) {
		print('ERRO========================>$e');
	}
}