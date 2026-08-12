import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  return (await dioRequest.get(HttpConstants.BANNER_LIST) as List).map((item) {
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

Future<List<categoryItem>> getCategoryApi() async {
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return categoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}

// 特惠推荐
Future<SpecialRecommend> getProductListApi() async {
  return SpecialRecommend.fromJson(
    await dioRequest.get(HttpConstants.PRODUCT_lIST),
  );
}

// 爆款推荐
Future<SpecialRecommend> getInvorgeApi() async {
  return SpecialRecommend.fromJson(
    await dioRequest.get(HttpConstants.STUGGENT_LIST),
  );
}

// 一站式全买
Future<SpecialRecommend> getAllApi() async {
  return SpecialRecommend.fromJson(
    await dioRequest.get(HttpConstants.ALLSHOP_LIST),
  );
}
