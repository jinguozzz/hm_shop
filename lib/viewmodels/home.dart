// 每一个轮播图的类型
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  // 用来对返回的数据进行类型转换
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? " ", imgUrl: json['imgUrl'] ?? " ");
  }
}

// 定义分类函数
class categoryItem {
  String id;
  String name;
  String picture;
  List<categoryItem>? children;

  categoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  factory categoryItem.fromJson(Map<String, dynamic> json) {
    return categoryItem(
      id: json['id'] ?? ' ',
      name: json['name'] ?? ' ',
      picture: json['picture'] ?? ' ',
      children: json['children'] == null
          ? null
          : (json['children'] as List)
                .map(
                  (item) => categoryItem.fromJson(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}
