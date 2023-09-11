import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/values/my_imgs.dart';
import 'package:splashapp/view/home/home_screen.dart';
import '../main.dart';
import '../values/dimens.dart';
import 'auth/login/login_view.dart';


// Define your onboarding pages and content here
final List<Widget> onboardingPages = [
  const OnboardingPage(
      photo: MyImgs.onBoardingOne,
      headline: 'Quality Education',
      subtitle: "Welcome to the Quality Education and Training with QCA"),
  const OnboardingPage(
      photo: MyImgs.onBoardingtwo,
      headline: 'Prepare you ETEA and MDCAT Test',
      subtitle: 'Prepare for all competative test ETEA and MDCAT with highly tranined staff'),
  const OnboardingPage(
      photo: MyImgs.onBoardingthree,
      headline: 'Online',
      subtitle: 'Online test preparation is available using this app'),
];

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 10),
      margin: const EdgeInsets.symmetric(horizontal: Dimens.size4),
      height: Dimens.size10,
      width: isActive ? Dimens.size10 : Dimens.size10,
      decoration: BoxDecoration(
        //shape: BoxShape.circle,

        color: isActive ? Get.theme.colorScheme.primary : AppColors.blackColor,
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.size10)),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onGetStartedPressed() async {
    final settingsBox = await Hive.openBox(HiveBoxes.settingsBox);
    await settingsBox.put('hasSeenOnboarding', true);

    if (isUserLoggedIn) {
      Get.to(() => const HomeScreen());
      print('User is in the Home screen');
    } else {
      Get.to(() =>   LoginView());
      print('User is in the Login screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    itemCount: onboardingPages.length,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      return onboardingPages[index];
                    },
                  ),
                ),
                _currentPage == _numPages - 1
                    ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildPageIndicator(),
                        ),
                        if (_currentPage == onboardingPages.length - 1)
                          SizedBox(
                            height: 48,
                            child: FloatingActionButton(
                              onPressed: _onGetStartedPressed,
                              backgroundColor: AppColors.blackColor,
                              child: Icon(
                                Icons.arrow_forward,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
                    : Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                          if (_currentPage != onboardingPages.length - 1)
                            SizedBox(
                              height: 48,
                              child: FloatingActionButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration:
                                    const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                backgroundColor: AppColors.blackColor,
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}

// Example OnboardingPage widget
class OnboardingPage extends StatelessWidget {
  final String photo;
  final String headline;
  final String subtitle;

  const OnboardingPage(
      {required this.photo, required this.headline, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              //  borderRadius: BorderRadius.only(
              // //   bottomLeft: Radius.circular(120),
              // //   bottomRight:  Radius.circular(120),
              //  ),
                image: DecorationImage(
                  image: AssetImage(
                    photo,
                  ),
                  fit: BoxFit.fill,
                )),
          ),
          SizedBox(height: Dimens.size30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
            child: Text(
              headline,
              textScaleFactor: 1.0,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontFamily: 'Matter-Regular',
                  color: AppColors.blackColor,
                  fontSize: 29),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Dimens.size10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
            child: Text(
              subtitle,
              textScaleFactor: 1.0,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 19,
                  fontFamily: 'Gill Sans MT',
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
