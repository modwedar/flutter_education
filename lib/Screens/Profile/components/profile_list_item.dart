import 'package:flutter/material.dart';
import 'package:flutter_education/constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigation;
  final Function onTap;

  const ProfileListItem({
    Key key,
    @required this.icon,
    @required this.text,
    this.hasNavigation = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 40).copyWith(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Color(0xFFF3F7FB)),
        child: Row(children: [
          Icon(
            this.icon,
            size: 25,
          ),
          SizedBox(width: 25),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(fontWeight: FontWeight.w500),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
            ),
        ]),
      ),
    );
  }
}
