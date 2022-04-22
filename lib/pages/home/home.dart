import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maid/utils/enum.dart';

import 'widgets/card_category.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 60),
          child: const Text('Maid Services',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          child: const Text(
            'หมวดหมู่',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardCategoryies(
              label: 'ซักผ้า',
              image: SvgPicture.asset(
                'assets/images/wash.svg',
                height: 100,
              ),
              categories: Categories.wash,
            ),
            CardCategoryies(
              label: 'ทำความสะอาดบ้าน',
              image: SvgPicture.asset(
                'assets/images/clean.svg',
                height: 100,
              ),
              categories: Categories.clean,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardCategoryies(
              label: 'ทำความสะอาดเฟอร์นิเจอร์',
              image: SvgPicture.asset(
                'assets/images/furniture.svg',
                height: 100,
              ),
              categories: Categories.furniture,
            ),
            CardCategoryies(
              label: 'ทำความสะอาดทั้งหมด',
              image: SvgPicture.asset(
                'assets/images/all.svg',
                height: 100,
              ),
              categories: Categories.all,
            ),
          ],
        )
      ],
    );
  }
}
