import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../pages/details_page.dart';


Handler detail_handler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> param ){
    String goodsId = param['id'].first;
    return DetailsPage(goodsId);
  },
  );