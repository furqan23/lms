import 'package:flutter/material.dart';
import 'package:splashapp/res/assets/images_assets.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/res/constants/constants.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({
    super.key,
    required this.userName,
    required this.emaill,
    required this.context,
  });

  final String userName;
  final String emaill;
  final BuildContext context;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 400,
              height: 155,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage(MyImgs.profileImage2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'BandaBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    emaill,
                    style: const TextStyle(
                      fontFamily: 'BandaBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.orangeColor,
                    ),
                  ),
                  const Text(
                    "${Appverison}.0 ",
                    style: TextStyle(
                      fontFamily: 'BandaBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: AppColors.greyshade100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
