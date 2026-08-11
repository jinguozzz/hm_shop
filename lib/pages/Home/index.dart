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
      SliverToBoxAdapter(child: Hmcategory()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: Hmsuggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: Hmhot()),
              SizedBox(width: 10),
              Expanded(child: Hmhot()),
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
  }

  void _getBannerList() async {
    _bannerList = await getBannerListApi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getSrcollChildren());
  }
}
