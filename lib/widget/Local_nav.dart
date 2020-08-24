import 'package:flutter/material.dart';
import 'package:safflower/model/common_model.dart';
import 'package:safflower/model/grid_nav_model.dart';
import 'package:safflower/widget/webview.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
//        添加组件Widget
        child: _items(context),
      ),
    );
  }

  //设置local数据
  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) => {items.add(_item(context, model))});
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

//  单个Item组件Widget
  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
//      点击事件
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        WebView(url: model.url,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar)));
      },
      child: Column(
        children: [
          Image.network(
            model.icon,
            width: 32.0,
            height: 32.0,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
