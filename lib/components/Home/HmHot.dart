import 'package:flutter/material.dart';

class Hmhot extends StatefulWidget {
  const Hmhot({super.key});

  @override
  State<Hmhot> createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 200,
      child: Text('爆款推荐', style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
