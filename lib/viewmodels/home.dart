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

// 特惠推荐主类型
class SpecialRecommend {
  String id;
  String title;
  List<SubType> subTypes;

  SpecialRecommend({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommend.fromJson(Map<String, dynamic> json) {
    return SpecialRecommend(
      id: json['id'] ?? ' ',
      title: json['title'] ?? ' ',
      subTypes: json['subTypes'] == null
          ? []
          : (json['subTypes'] as List)
                .map((item) => SubType.fromJson(item as Map<String, dynamic>))
                .toList(),
    );
  }
}

// 子类型
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'] ?? ' ',
      title: json['title'] ?? ' ',
      goodsItems: json['goodsItems'] == null
          ? GoodsItems()
          : GoodsItems.fromJson(json['goodsItems'] as Map<String, dynamic>),
    );
  }
}

// 商品列表项
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    this.counts = 0,
    this.pageSize = 10,
    this.pages = 0,
    this.page = 1,
    this.items = const [],
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 10,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 1,
      items: json['items'] == null
          ? []
          : (json['items'] as List)
                .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
                .toList(),
    );
  }
}

// 商品详情
class GoodsItem {
  String id;
  String name;
  String desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] ?? ' ',
      name: json['name'] ?? ' ',
      desc: json['desc'] ?? ' ',
      price: json['price'] ?? '0.00',
      picture: json['picture'] ?? ' ',
      orderNum: json['orderNum'] ?? 0,
    );
  }
}
