class ConfigModel {
  final String searchUrl;

  ConfigModel({this.searchUrl});

//  工厂函数factory，动态加载dynamic
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(searchUrl: json['searchUrl']);
  }

  Map<String, dynamic> toJson() {
    return {searchUrl: searchUrl};
  }
}
