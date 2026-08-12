import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HMSuggestion.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SpecialRecommend _specialRecommend = SpecialRecommend(
    id: ' ',
    title: ' ',
    subTypes: [],
  );
  // 爆款推荐数据列表
  SpecialRecommend _HotList = SpecialRecommend(
    id: ' ',
    title: ' ',
    subTypes: [],
  );
  // 一站式全买列表
  SpecialRecommend _allList = SpecialRecommend(
    id: ' ',
    title: ' ',
    subTypes: [],
  );
  List<categoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    // BannerItem(
    //   id: "1",
    //   imgUrl:
    //       "https://aihanguo.oss-cn-beijing.aliyuncs.com/一手托腮美女白鹿2K电脑壁纸_彼岸壁纸.jpg",
    // ),
    // BannerItem(
    //   id: "2",
    //   imgUrl:
    //       "https://aihanguo.oss-cn-beijing.aliyuncs.com/校园清纯美女田曦薇2K高清电脑壁纸_彼岸壁纸.jpg",
    // ),
    // BannerItem(
    //   id: "3",
    //   imgUrl:
    //       "https://aihanguo.oss-cn-beijing.aliyuncs.com/长发侧脸美女孟子义2K超清壁纸_彼岸壁纸.jpg",
    // ),
  ];
  List<Widget> _getSrcollChildren() {
    return [
      SliverToBoxAdapter(child: Hmslider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: Hmcategory(categorylist: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Hmsuggestion(specialRecommend: _specialRecommend),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Hmhot(result: _HotList, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Hmhot(result: _allList, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      Hmmorelist(),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getProductList();
    _getHotlist();
    _getAlllist();
  }

  void _getBannerList() async {
    _bannerList = await getBannerListApi();
    setState(() {});
  }

  void _getCategoryList() async {
    _categoryList = await getCategoryApi();
    setState(() {});
  }

  void _getProductList() async {
    _specialRecommend = await getProductListApi();
    setState(() {});
  }

  void _getHotlist() async {
    _HotList = await getInvorgeApi();
    setState(() {});
  }

  void _getAlllist() async {
    _allList = await getAllApi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getSrcollChildren());
  }
}
