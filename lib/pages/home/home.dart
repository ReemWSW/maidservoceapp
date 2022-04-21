import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'card_category.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var header = Container(
      margin: const EdgeInsets.symmetric(vertical: 60),
      child: const Text('Maid Services',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          )),
    );

    var label = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Text(
        'หมวดหมู่',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 20),
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              header,
              label,
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
                  ),
                  CardCategoryies(
                    label: 'ทำความสะอาดบ้าน',
                    image: SvgPicture.asset(
                      'assets/images/clean.svg',
                      height: 100,
                    ),
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
                  ),
                  CardCategoryies(
                    label: 'ทำความสะอาดทั้งหมด',
                    image: SvgPicture.asset(
                      'assets/images/all.svg',
                      height: 100,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
