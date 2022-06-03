// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  final Widget? icon;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          onPressed: () {},
          child: IconButton(
            color: Colors.white,
            iconSize: 30,
            icon: icon!,
            onPressed: onPressed,
          )),
    );
  }
}
