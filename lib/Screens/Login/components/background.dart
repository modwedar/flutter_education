import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image(
                width: size.width * 0.35,
                image: AssetImage("assets/images/main_top.png")),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image(
                width: size.width * 0.4,
                image: AssetImage("assets/images/login_bottom.png")),
          ),
          child
        ],
      ),
    );
  }
}
