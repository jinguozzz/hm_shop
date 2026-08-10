import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmslider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const Hmslider({super.key, required this.bannerList});

  @override
  State<Hmslider> createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  Widget _getSlider() {
    final double screen = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          width: screen,
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
        );
      }),
      options: CarouselOptions(viewportFraction: 1, autoPlay: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider()]);
    // Container(
    //   height: 300,
    //   alignment: Alignment.center,
    //   color: Colors.blue,
    //   child: Text('轮播图', style: TextStyle(fontSize: 20, color: Colors.white)),
    // );
  }
}
