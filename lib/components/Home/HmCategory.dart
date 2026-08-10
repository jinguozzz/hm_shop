import 'package:flutter/material.dart';

class Hmcategory extends StatefulWidget {
  const Hmcategory({super.key});

  @override
  State<Hmcategory> createState() => _HmcategoryState();
}

class _HmcategoryState extends State<Hmcategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 80,
            height: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.blue,
            child: Text(
              '分类${index}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
