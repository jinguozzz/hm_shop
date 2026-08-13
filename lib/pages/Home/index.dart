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

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  int _page = 1; //页码
  bool isLoading = false;
  bool _hasMore = true;

  // 获取推荐列表
  void _getRecommendList() async {
    if (isLoading || !_hasMore) return;
    isLoading = true;
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    isLoading = false;
    setState(() {});
    _page++;
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
  }

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
      HmMoreList(recommendList: _recommendList),
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
    _getRecommendList();
    _requestEvent();
  }

  void _requestEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        _getRecommendList();
      }
    });
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

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getSrcollChildren(),
      controller: _controller, //绑定控制器
    );
  }
}
