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
