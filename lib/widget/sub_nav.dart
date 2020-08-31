import 'package:flutter/material.dart';
import 'package:safflower/model/common_model.dart';
import 'package:safflower/model/grid_nav_model.dart';
import 'package:safflower/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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

  //设置sub数据
  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) => {items.add(_item(context, model))});
//    计算出第一行显示的数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.sublist(separate, subNavList.length),
            ))
      ],
    );
  }

//  单个Item组件Widget
  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(child: GestureDetector(
//      点击事件
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar)));
      },
      child: Column(
        children: [
          Image.network(
            model.icon,
            width: 18.0,
            height: 18.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Text(
              model.title,
              style: TextStyle(fontSize: 12.0),
            ),
          )
        ],
      ),
    ));
  }
}
