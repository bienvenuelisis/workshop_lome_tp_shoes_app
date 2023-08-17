// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:workshop_lome_tp_shoes_app/animation/fade_animation.dart';
import 'package:workshop_lome_tp_shoes_app/models/shoe.dart';
import 'package:workshop_lome_tp_shoes_app/theme/custom_app_theme.dart';
import 'package:workshop_lome_tp_shoes_app/utils/constants.dart';
import 'package:workshop_lome_tp_shoes_app/utils/int_extension.dart';
import 'package:workshop_lome_tp_shoes_app/view/pay_shoe_screen.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({required this.model, required this.isComeFromMoreSection});

  bool isComeFromMoreSection;
  Shoe model;

  @override
  Details createState() => Details();
}

class Details extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 1.1,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _TopInformation(
              width: width,
              height: height,
              shoe: widget.model,
              isComeFromMoreSection: widget.isComeFromMoreSection,
            ),
            _ShoesImages(width: width, height: height, shoe: widget.model),
            SizedBox(
              height: 20,
              width: width / 1.1,
              child: Divider(
                thickness: 1.4,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      FadeAnimation(
                        delay: 1,
                        child: Row(
                          children: [
                            Text(
                              widget.model.model,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: AppConstantsColor.darkTextColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              widget.model.price.formatted,
                              style: AppThemes.detailsProductPrice,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      FadeAnimation(
                        delay: 1.5,
                        child: Container(
                          width: width,
                          height: height / 9,
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tincidunt laoreet enim, eget sodales ligula semper at. Sed id aliquet eros, nec vestibulum felis. Nunc maximus aliquet aliquam. Quisque eget sapien at velit cursus tincidunt. Duis tempor lacinia erat eget fermentum.",
                              style: AppThemes.detailsProductDescriptions),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    height: 50,
                    child: FadeAnimation(
                      delay: 3.5,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minWidth: width / 1.2,
                        height: height / 15,
                        color: Colors.pink,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) {
                                return PayShoeScreen(shoe: widget.model);
                              },
                            ),
                          );
                        },
                        child: Text(
                          "PAYER ${widget.model.price.formatted}",
                          style: TextStyle(
                            color: AppConstantsColor.lightTextColor,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TopInformation extends StatelessWidget {
  const _TopInformation({
    required this.width,
    required this.height,
    required this.shoe,
    required this.isComeFromMoreSection,
  });

  final double height;
  final bool isComeFromMoreSection;
  final Shoe shoe;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height / 2.3,
      child: Stack(
        children: [
          Positioned(
            left: 50,
            bottom: 20,
            child: FadeAnimation(
              delay: 0.5,
              child: Container(
                width: 1000,
                height: height / 2.2,
                decoration: BoxDecoration(
                  color: shoe.modelColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(1500),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 30,
            child: Hero(
              tag: isComeFromMoreSection ? shoe.model : shoe.imgAddress,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(-25 / 360),
                child: Container(
                  width: width / 1.3,
                  height: height / 4.3,
                  child: Image(image: AssetImage(shoe.imgAddress)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ShoesImages extends StatelessWidget {
  const _ShoesImages({
    required this.width,
    required this.height,
    required this.shoe,
  });

  final double height;
  final Shoe shoe;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 0.5,
      child: Container(
        padding: EdgeInsets.all(2),
        width: width,
        height: height / 11,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedImage(width: width, height: height, shoe: shoe),
            RoundedImage(width: width, height: height, shoe: shoe),
            RoundedImage(width: width, height: height, shoe: shoe),
            Container(
              padding: EdgeInsets.all(2),
              width: width / 5,
              height: height / 14,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage(shoe.imgAddress),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.grey.withOpacity(1),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: AppConstantsColor.lightTextColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    required this.width,
    required this.height,
    required this.shoe,
  });

  final double height;
  final Shoe shoe;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      width: width / 5,
      height: height / 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: Image(
        image: AssetImage(shoe.imgAddress),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({required this.model, required this.isComeFromMoreSection});

  bool isComeFromMoreSection;
  Shoe model;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppConstantsColor.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("Nike", style: AppThemes.detailsAppBar),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppConstantsColor.darkTextColor,
              ),
            ),
          ),
        ),
        body: DetailsScreen(
          model: model,
          isComeFromMoreSection: isComeFromMoreSection,
        ),
      ),
    );
  }
}
