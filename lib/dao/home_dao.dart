import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safflower/model/home_model.dart';

const home_url='http://www.devio.org/io/flutter_app/json/home_page.json';

/**
 * 首页入口接口
 */
class HomeDao{
  static Future<HomeModel> fetch() async{
    final response=await http.get(home_url);
    if(response.statusCode==200){
//      修复中文乱码
      Utf8Decoder utf8decoder=Utf8Decoder();
      var result=json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);

    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}