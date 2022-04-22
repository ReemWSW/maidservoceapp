import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maid/utils/enum.dart';

import '../order.dart';

class CardCategoryies extends StatelessWidget {
  const CardCategoryies({
    Key? key,
    this.color = Colors.white,
    required this.label,
    required this.image,
    required this.categories,
  }) : super(key: key);

  final Color? color;
  final String label;
  final SvgPicture image;
  final Categories categories;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderPage(category: categories),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.width * .4,
        decoration: BoxDecoration(
          color: color!,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              image,
              Text(
                label,
                maxLines: 20,
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
