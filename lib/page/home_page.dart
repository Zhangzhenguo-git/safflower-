import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:safflower/dao/home_dao.dart';
import 'package:safflower/model/common_model.dart';
import 'package:safflower/model/grid_nav_model.dart';
import 'package:safflower/model/home_model.dart';
import 'package:safflower/model/sales_box_model.dart';
import 'package:safflower/widget/Local_nav.dart';
import 'package:safflower/widget/grid_nav.dart';
import 'package:safflower/widget/loading_container.dart';
import 'package:safflower/widget/sales_box.dart';
import 'package:safflower/widget/sub_nav.dart';
import 'package:safflower/widget/webview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const APPBAR_SCROLL_OFFSET = 100;

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    "https://pages.c-ctrip.com/hdz/2020shuqi/3rd./pc.jpg",
    "https://pages.c-ctrip.com/hotel/202008/99jiudianjie/pces.jpg",
    "https://pages.c-ctrip.com/hotel/202008/qixi/pc.jpg"
  ];
  double appBarAlpha = 0;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;
  GridNavModel gridNavModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
//    loadData();
    _handlerRefresh();
  } //  Scroll滑动距离

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  loadData() async {
//    HomeDao.fetch().then((result) =>{
//      setState((){
//        resultString=json.encode(result);
//      });
//    }).catchError((onError){
//      setState(() {
//        resultString=onError.toString();
//      });
//    });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        gridNavModel = model.gridNav;
        _loading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: [
              MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: RefreshIndicator(
                    onRefresh: _handlerRefresh,
                    child: NotificationListener(
                      onNotification: (ss) {
                        if (ss is ScrollUpdateNotification && ss.depth == 0) {
                          _onScroll(ss.metrics.pixels);
                        }
                      },
                      child: _listView,
                    ),
                  )),
//          自定义appBar(包裹)
              Opacity(opacity: appBarAlpha, child: _appBar)
            ],
          ),
        ));
  }

  /**
   * 下拉刷新
   */
  Future<Null> _handlerRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        bannerList = model.bannerList;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        gridNavModel = model.gridNav;
        _loading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

//  首页内容列表
  Widget get _listView {
    return ListView(
      children: [
        _banner,
//      LocalNav组件
        Padding(
            padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
            child: LocalNav(localNavList: localNavList)),
        Container(
//                    设置内边距
            padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.transparent,
            ),
            child: GridNav(
              gridNavModel: gridNavModel,
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
            child: SubNav(subNavList: subNavList)),
        Padding(
            padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
            child: SalseBox(salseBox: salesBox)),
        Container(
          height: 800.0,
          child: Text("resultString"),
        ),
      ],
    );
  }

//首页AppBar
  Widget get _appBar {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text('首页'),
        ),
      ),
    );
  }
//  首页轮播器
  Widget get _banner {
    return Container(
      height: 160.0,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                CommonModel model = bannerList[index];
                return WebView(
                  url: model.url,
                  title: model.title,
                  hideAppBar: model.hideAppBar,
                );
              }));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}
