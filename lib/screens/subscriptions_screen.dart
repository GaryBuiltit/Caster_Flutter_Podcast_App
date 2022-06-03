// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables

import 'package:caster/utilities/nav_menu.dart';
import 'package:caster/utilities/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
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
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 15),
            //   child: Text(
            //     "Subscriptions",
            //     style: TextStyle(
            //       fontSize: 30,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            Expanded(
              child: GridView(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  // maxCrossAxisExtent: 3,
                  crossAxisCount: 3,
                ),
                children: context.watch<Subscribe>().addsubscriptionCard(),
              ),
            ),
            NavMenu(),
          ],
        ),
      ),
    );
  }
}
