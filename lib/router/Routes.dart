import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routes {
  static String root = '/';
  static String detailPage = '/detail';
  static void configureRoutes (Router router){
      router.notFoundHandler = Handler(
        handlerFunc: (context,Map<String, List<String>> param) {
            print('ERROR =====> Router was not Found');
      }
      );
      
      router.define(detailPage, handler: detail_handler);
  }
}