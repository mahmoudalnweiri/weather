import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Rain extends StatelessWidget {
  const Rain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      child: Image.asset(
        'assets/images/rainy.png',
        height: 300,
        width: 300,
      ),
      opacity: 0.6,
      color: Colors.black,
      offset: const Offset(5, 5),
      sigma: 7,
    );
  }
}
