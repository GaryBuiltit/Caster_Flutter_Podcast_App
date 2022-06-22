// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:caster/utilities/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  // List subscriptions = [];

  // @override
  // void initState() {
  //   subscriptions = Provider.of<Subscribe>(context, listen: false).;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[700],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Subscriptions'),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView(
                padding: EdgeInsets.only(
                  top: 2.h,
                  left: 1.w,
                  right: 1.w,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 2.h,
                  // maxCrossAxisExtent: 3,
                  crossAxisCount: 3,
                ),
                children: context.read<Subscribe>().subscriptionCards,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
