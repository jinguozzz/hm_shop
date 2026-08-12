import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmsuggestion extends StatefulWidget {
  final SpecialRecommend specialRecommend;
  const Hmsuggestion({super.key, required this.specialRecommend});

  @override
  State<Hmsuggestion> createState() => _HmsuggestionState();
}

class _HmsuggestionState extends State<Hmsuggestion> {
  List<GoodsItem> _getdisplayItems() {
    if (widget.specialRecommend.subTypes.isEmpty) return [];
    return widget.specialRecommend.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getdisplayItems();
    return List.generate(list.length, (int index) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'lib/assets/tab/home_cmd_inner.png',
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover,
                );
              },
              list[index].picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color.fromARGB(255, 240, 96, 12),
            ),
            child: Text(
              "￥${list[index].price}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildhandel() {
    return Row(
      children: [
        Text(
          '特惠推荐',
          style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 10),
        Text(
          '精选省攻略',
          style: TextStyle(
            color: Color.fromARGB(255, 124, 63, 58),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          image: AssetImage('lib/assets/tab/home_cmd_inner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 250,
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
          image: DecorationImage(
            image: AssetImage('lib/assets/tab/home_cmd_sm.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildhandel(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
