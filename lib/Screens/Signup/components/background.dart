import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image(
              width: size.width *0.35,
              image: AssetImage("assets/images/signup_top.png"),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image(
              width: size.width *0.25,
              image: AssetImage("assets/images/main_bottom.png"),
            ),
          ),
          child
        ],
      ),
    );
  }
}
