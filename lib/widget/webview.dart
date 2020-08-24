import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backFrobid;

  const WebView({Key key,
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backFrobid})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    防止页面重新打开
    webviewReference.close();
//    注册监听
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged changed) {
          switch (changed.type) {
            case WebViewState.startLoad:
              break;
            default:
              break;
          }
        });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError httpError) {
          print(httpError);
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusbarColorStr=widget.statusBarColor??'ffffff';
    Color backButtonColor;
    if(statusbarColorStr=='ffffff'){
      backButtonColor=Colors.black;
    }else{
      backButtonColor=Colors.white;
    }
    return Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff'+statusbarColorStr)), backButtonColor),
          Expanded(
              child: WebviewScaffold(
                url: widget.url,
//                是否可以缩放
                withZoom:true,
//                是否启用缓存
                withLocalStorage: true,
//              是否隐藏
              hidden: true,
//              初始化页面
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('wwwww'),
                ),
              ),
              ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30.0,
      );
    }
    return Container(
//      内容充满
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.close, color: backgroundColor, size: 26.0,),
              ),
            ),
            Positioned(
                left: 0.0,
                child: Center(
                  child: Text(widget.title ?? '',
                    style: TextStyle(
                        color: backButtonColor, fontSize: 20.0
                    ),),
                ))
          ],
        ),
      ),
    );
  }
}