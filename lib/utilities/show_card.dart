import 'package:caster/providers/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShowCard extends StatelessWidget {
  const ShowCard({
    Key? key,
    this.showTitle,
    this.showPic,
    this.onTap,
  }) : super(key: key);
  final String? showPic;
  final String? showTitle;
  final onTap;

  picCheck(var pic){
    if (pic != null){
      return NetworkImage(pic);
    } else {
      return const AssetImage('assets/images/image_error.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 150,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                image: picCheck(showPic),
              ),
            ),
            SizedBox(
              height: .3.h,
            ),
            Expanded(
              child: Text(
                showTitle!,
                maxLines: 2,
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
      ),
    );
  }
}
