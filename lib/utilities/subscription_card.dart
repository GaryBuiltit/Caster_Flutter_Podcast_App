import 'package:flutter/material.dart';

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
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          child: SizedBox(
            child: Image(
              image: NetworkImage(showPic!),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          showTitle!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
