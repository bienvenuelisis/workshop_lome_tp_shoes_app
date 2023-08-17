// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:workshop_demo_app/animation/fade_animation.dart';
import 'package:workshop_demo_app/models/shoe.dart';
import 'package:workshop_demo_app/theme/custom_app_theme.dart';
import 'package:workshop_demo_app/utils/constants.dart';
import 'package:workshop_demo_app/utils/int_extension.dart';
import 'package:workshop_demo_app/utils/shoes_data.dart';
import 'package:workshop_demo_app/view/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndexOfCategory = 0;
  int selectedIndexOfFeatured = 1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstantsColor.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("Flutter WorkShop TP", style: AppThemes.homeAppBar),
            ),
          ),
        ),
        body: Column(
          children: [
            _CategoriesTitle(title: "Mises en avant"),
            SizedBox(height: 10),
            _FeaturedShoes(width: width, height: height),
            SizedBox(height: 5),
            _CategoriesTitle(title: "Autres modèles"),
            _SecondaryShoes(width: width, height: height),
          ],
        ),
      ),
    );
  }
}

class _SecondaryShoes extends StatelessWidget {
  const _SecondaryShoes({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height / 3.5,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: availableShoes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          Shoe model = availableShoes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => DetailScreen(
                    model: model,
                    isComeFromMoreSection: true,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: width / 2.24,
              height: height / 4.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 5,
                    child: FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: width / 13,
                        height: height / 9,
                        color: Colors.red,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Center(
                            child: FadeAnimation(
                              delay: 1.5,
                              child: Text(
                                "NOUVEAU",
                                style: AppThemes.homeGridNewText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 57,
                    left: 25,
                    child: FadeAnimation(
                      delay: 1.5,
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(-15 / 360),
                        child: Container(
                          width: width / 3,
                          height: height / 9,
                          child: Hero(
                            tag: model.model,
                            child: Image(
                              image: AssetImage(model.imgAddress),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 171,
                    left: 45,
                    child: FadeAnimation(
                      delay: 2,
                      child: Container(
                        width: width / 4,
                        height: height / 42,
                        child: FittedBox(
                          child: Text(
                            "${model.name} ${model.model}",
                            style: AppThemes.homeGridNameAndModel,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 195,
                    left: 45,
                    child: FadeAnimation(
                      delay: 2.2,
                      child: Container(
                        width: width / 4,
                        height: height / 42,
                        child: FittedBox(
                          child: Text(
                            model.price.formatted,
                            style: AppThemes.homeGridPrice,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoriesTitle extends StatelessWidget {
  const _CategoriesTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(title, style: AppThemes.homeMoreText),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

class _FeaturedShoes extends StatelessWidget {
  const _FeaturedShoes({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width / 1.2,
          height: height / 2.4,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: availableShoes.length,
            itemBuilder: (ctx, index) {
              Shoe model = availableShoes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                        model: model,
                        isComeFromMoreSection: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  width: width / 1.5,
                  child: Stack(
                    children: [
                      Container(
                        width: width / 1.81,
                        decoration: BoxDecoration(
                          color: model.modelColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: FadeAnimation(
                          delay: 1,
                          child: Row(
                            children: [
                              Text(
                                model.name,
                                style: AppThemes.homeProductName,
                              ),
                              SizedBox(
                                width: 120,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        left: 10,
                        child: FadeAnimation(
                          delay: 1.5,
                          child: Text(
                            model.model,
                            style: AppThemes.homeProductModel,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 10,
                        child: FadeAnimation(
                          delay: 2,
                          child: Text(
                            model.price.formatted,
                            style: AppThemes.homeProductPrice,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 60,
                        child: FadeAnimation(
                          delay: 2,
                          child: Hero(
                            tag: model.imgAddress,
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(-30 / 360),
                              child: Container(
                                width: 250,
                                height: 230,
                                child: Image(
                                  image: AssetImage(model.imgAddress),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
