import 'package:flutter/material.dart';//android 的 material风格
import 'package:flutter/cupertino.dart';//IOS 的设计风格
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
	
	final List<BottomNavigationBarItem> bottomTabs = [
		BottomNavigationBarItem(
				icon: Icon(CupertinoIcons.home),
				title: Text('首页')
		),
		BottomNavigationBarItem(
				icon: Icon(CupertinoIcons.search),
				title: Text('分类')
		),
		BottomNavigationBarItem(
				icon: Icon(CupertinoIcons.shopping_cart),
				title: Text('购物车')
		),
		BottomNavigationBarItem(
				icon: Icon(CupertinoIcons.profile_circled),
				title: Text('会员中心')
		),
	];
	
	final List<Widget> tabBodies = [
		HomePage(),
		CategoryPage(),
		CartPage(),
		MemberPage(),
	];
	
	int current_index = 0;
	var current_page;
	
	@override
  void initState() {
		current_page = tabBodies[0];
    super.initState();
  }
	
  @override
  Widget build(BuildContext context) {
    return Scaffold(
	    backgroundColor: Color.fromRGBO(244,245,245,1.0),
	    bottomNavigationBar: BottomNavigationBar(
			    type: BottomNavigationBarType.fixed,//导航栏的类型
			    currentIndex: current_index,
			    items:bottomTabs,
		    onTap: (index) => {
			    	setState(
						    (){
						    	current_index = index;
						    	current_page = tabBodies[current_index];
						    }
				    )
		    },
	    ),
    );
  }
}

