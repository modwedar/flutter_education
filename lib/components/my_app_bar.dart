import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_education/size_config.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildAppBar();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: (){},
        icon: SvgPicture.asset("assets/icons/menu.svg"),
      ),
      centerTitle: true,
      title: Image.asset("assets/images/logo.png"),
      actions: [
        IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"), onPressed: () {}
        ),
        SizedBox(
          width: SizeConfig.defaultSize * 0.5,
        )
      ],
    );
  }

}
