import 'package:flutter/material.dart';

import 'CustomColor.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(CustomColor.WhiteLight),
      toolbarHeight: 70.0,
      elevation: 0.0,
      leading: IconButton(
        iconSize: 22.0,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: Color(CustomColor.BlueNormal),
      ),
      leadingWidth: 80.0,
      title: Text(
        title,
        style: TextStyle(
          color: Color(CustomColor.BlueNormal),
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }
}
