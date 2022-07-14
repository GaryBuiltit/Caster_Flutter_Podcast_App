import 'package:caster/providers/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    Key? key,
    this.showTitle,
    this.showPic,
  }) : super(key: key);
  final String? showPic;
  final String? showTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Subscribe().unsubscribe(showTitle!);
      },
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Image(
            height: 100,
            width: 100,
            image: NetworkImage(showPic!),
          ),
           SizedBox(
            height: .3.h,
          ),
          Expanded(
            child: Text(
              showTitle!,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
