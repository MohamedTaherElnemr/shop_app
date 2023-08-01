import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onboardingController = PageController();

  List<BoardingModel> bording = [
    BoardingModel(
        image: 'assets/images/onboarding_2.jpg',
        title: 'on boarding title 1 ',
        body: 'onboarding body 1'),
    BoardingModel(
        image: 'assets/images/onboarding_2.jpg',
        title: 'on boarding title 2 ',
        body: 'onboarding body 2'),
    BoardingModel(
        image: 'assets/images/onboarding_2.jpg',
        title: 'on boarding title 3 ',
        body: 'onboarding body 3')
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEFF1FD),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                child: const Text(
                  'SKIP',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ))
          ],
          elevation: 0,
          backgroundColor: const Color(0xffEFF1FD),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == bording.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: onboardingController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(bording[index]),
                  itemCount: 3,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: onboardingController,
                    count: bording.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.amber,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.amber,
                    onPressed: () {
                      if (isLast == true) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return LoginScreen();
                        //     },
                        //   ),
                        // );

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      }
                      onboardingController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset('${boardingModel.image}')),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${boardingModel.title}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text('${boardingModel.body}',
              style: TextStyle(
                fontSize: 20,
              )),
          const SizedBox(
            height: 50,
          )
        ],
      );
}
