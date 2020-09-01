import 'package:flutter/material.dart';


enum SearchBarType{
  home,normal,homeLight
}

class SearchBar extends StatefulWidget {


  final bool enabled;
  final bool hideLeft;
  final SearchBarType searchBarType;

  const SearchBar({Key key, this.enabled, this.hideLeft, this.searchBarType}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

}
class _SearchBarState extends State<SearchBar>{
  bool showClear=false;
  final TextEditingController _controller=TextEditingController();

  @override
  void initState() {

      super.initState();
      if(widget.defaultText)

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
