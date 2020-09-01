import 'package:flutter/material.dart';
import 'package:safflower/model/common_model.dart';
import 'package:safflower/model/sales_box_model.dart';
import 'package:safflower/widget/webview.dart';

class SalseBox extends StatelessWidget {
  final SalesBoxModel salseBox;

  const SalseBox({Key key, @required this.salseBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
//        添加组件Widget
      child: _items(context),
    );
  }

  //设置sub数据
  _items(BuildContext context) {
    if (salseBox == null) return null;
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salseBox.bigCard1, salseBox.bigCard2, true, false));
    items.add(_doubleItem(
        context, salseBox.smallCard1, salseBox.smallCard2, false, false));
    items.add(_doubleItem(
        context, salseBox.smallCard3, salseBox.smallCard4, false, true));
    return Column(
      children: [
        Container(
          height: 46.0,
          margin: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salseBox.icon,
                height: 15.0,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 1.0, 8.0, 1.0),
                margin: EdgeInsets.only(right: 7.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xffff4e63),
                          Color(0xffff6cc9),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebView(
                          url: salseBox.moreUrl,
                          title: '更多活动',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard,
      CommonModel rightCard, bool big, bool last) {
    return Row(
      children: [
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last)
      ],
    );
  }

//  单个Item组件Widget
  Widget _item(
      BuildContext context, CommonModel model, bool big, bool left, bool last) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
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
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                right: left ? borderSide : BorderSide.none,
                bottom: last ? BorderSide.none : borderSide)),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: big ? 129 : 80,
        ),
      ),
    );
  }
}
