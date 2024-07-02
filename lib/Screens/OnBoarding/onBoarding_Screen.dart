import 'package:delibox/Screens/User%20Login&Register/Register_Screen.dart';
import 'package:delibox/components/const.dart';
import 'package:flutter/material.dart';
import '../../Models/onBoardingScreen.dart';
import '../../components/cash_helper.dart';
import '../../generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardControlar = PageController();

  bool isFinsh = false;
  List<BoardingModel>? boardings;

  @override
  Widget build(BuildContext context) {
    boardings = [
      BoardingModel(
          image: 'assets/images/onBoardingImage/onB1.png',
          title: S.of(context).add_new_order_t,
          body: S.of(context).add_new_order_b),
      BoardingModel(
          image: 'assets/images/onBoardingImage/addBoring.jpg',
          title: S.of(context).Add_order_t,
          body: S.of(context).Add_order_b),
      BoardingModel(
          image: 'assets/images/onBoardingImage/orderOnBord.jpg',
          title: S.of(context).Orders_t,
          body: S.of(context).Orders_b),
      BoardingModel(
          image: 'assets/images/onBoardingImage/onB5.png',
          title: S.of(context).Orders_Search_t,
          body: S.of(context).Orders_Search_b),
      BoardingModel(
          image: 'assets/images/onBoardingImage/onB6.png',
          title: S.of(context).Accounting_t,
          body: S.of(context).Accounting_b),
      BoardingModel(
          image: 'assets/images/onBoardingImage/onB7.png',
          title: S.of(context).profile_t,
          body: S.of(context).profile_b),
      BoardingModel(
          image: 'assets/images/onBoardingImage/onB8.png',
          title: S.of(context).contact_us_t,
          body: S.of(context).contact_us_b),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextButton(
          onPressed: () {
            CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
              if (value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                    (route) => false);
              }
            });
          },
          child: Text(
            S.of(context).skip,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26, bottom: 26),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    onPageChanged: (value) {
                      if (value == boardings!.length - 1) {
                        setState(() {
                          isFinsh = true;
                        });
                      } else
                        setState(() {
                          isFinsh = false;
                        });
                    },
                    controller: boardControlar,
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boardings![index]),
                    itemCount: boardings!.length)),
            const SizedBox(height: 60),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardControlar,
                  count: boardings!.length,
                  effect: const JumpingDotEffect(
                      spacing: 6,
                      dotColor: Colors.grey,
                      activeDotColor: yellowColor),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: blueColor,
                  onPressed: () {
                    if (isFinsh) {
                      CacheHelper.saveData(key: 'onBoarding', value: true)
                          .then((value) {
                        if (value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                              (route) => false);
                        }
                      });
                    } else {
                      boardControlar.nextPage(
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${BoardingModel.image}'),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text('${BoardingModel.title}',
              style:
                  const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Text('${BoardingModel.body}',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      );
}
