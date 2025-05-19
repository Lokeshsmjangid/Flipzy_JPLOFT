import 'package:flipzy/resources/app_assets.dart';
import 'package:flipzy/resources/app_color.dart';
import 'package:flipzy/resources/text_utility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget1 extends StatelessWidget {
  const OnBoardingWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           Column(
            children: [
              SizedBox(),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.6,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //   image: AssetImage(AppAssets.onboarding1,),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(AppAssets.dashboard1Img, fit: BoxFit.cover,),
                  // child: SvgPicture.asset(AppAssets.onboarding1,fit: BoxFit.cover)
                    // child: Image.network(AppAssets.demoIphoneImageUrl, fit: BoxFit.cover,)
                ),
                // child: SvgPicture.asset(AppAssets.onboarding1,),
              ),

              addHeight(20),

              addText700('Welcome To Flipzy',fontSize: 30,
                  fontFamily: 'Manrope').marginSymmetric(horizontal: 16),


              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: addText500('“Your one-stop marketplace to buy, sell, and discover!”',
                    fontSize: 13,color: AppColors.textColor1,textAlign: TextAlign.center),
              ),



              const SizedBox(height: 20),
            ],
          ),
        ],

      ),
    );
  }
}

class OnBoardingWidget2 extends StatelessWidget {
  const OnBoardingWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           Column(
            children: [

              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.6,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //   image: AssetImage(AppAssets.onboarding1,),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    // child: Image.network(AppAssets.demoIphoneImageUrl, fit: BoxFit.cover,)),
                // child: SvgPicture.asset(AppAssets.onboarding2, fit: BoxFit.cover) ),
                  child: Image.asset(AppAssets.dashboard2Img, fit: BoxFit.cover,), ),
              ),
              // const Text(
              //   "Welcome To Levicon",
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),

              addHeight(20),

              addText700('Buy & Sell with Ease',fontSize: 30,
                  fontFamily: 'Manrope').marginSymmetric(horizontal: 16),


              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: addText500('“Find what you need or list what you don’t! Simple. Fast. Secure.” ',
                    fontSize: 13,color: AppColors.textColor1,textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],

      ),
    );
  }
}

class OnBoardingWidget3 extends StatelessWidget {
  const OnBoardingWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.6,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: DecorationImage(
                  //   image: AssetImage(AppAssets.onboarding1,),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          // child: Image.network(AppAssets.demoIphoneImageUrl, fit: BoxFit.cover,)),
                      // child: SvgPicture.asset(AppAssets.onboarding3, fit: BoxFit.cover,),),
                      child: Image.asset(AppAssets.dashboard3Img, fit: BoxFit.cover,),),
                    ),

                    Positioned(
                      bottom: 10, left: 100,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: addText700("Local Listing", fontSize: 20, fontFamily: "Manrope"),
                      ),
                    ),
                  ],
                ),
              ),

              addHeight(20),

              addText700('Explore Local Listings',fontSize: 30,
                  fontFamily: 'Manrope').marginSymmetric(horizontal: 16),


              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: addText500('“Browse through thousands of local listings—just a tap away.”',
                    fontSize: 13,color: AppColors.textColor1,textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],

      ),
    );
  }
}

class InvertedCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    final double controlPointHeight = size.height * 1;
    final double curveHeight = size.height * 0.80;

    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      controlPointHeight, // Control point for the curve
      size.width,
      curveHeight,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

