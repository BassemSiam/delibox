import 'package:delibox/components/cash_helper.dart';
import 'package:delibox/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';

class ChooseLang extends StatefulWidget {
  const ChooseLang({super.key});

  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> {
  Color engSelectColor = Colors.grey;
  Color arSelectColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            engSelectColor = Colors.grey;
            arSelectColor = Colors.grey;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250.h,
              width: 300.w,
              child: Image.asset(
                'assets/images/delibox_image.png',
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Select language',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        engSelectColor = Colors.black;
                        arSelectColor = Colors.grey;
                      });
                    },
                    child: Container(
                      width: 270.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: engSelectColor,
                        borderRadius: BorderRadiusDirectional.circular(20),
                        border: Border.all(),
                      ),
                      child: const Center(
                        child: Text(
                          'English',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        arSelectColor = Colors.black;
                        engSelectColor = Colors.grey;
                      });
                      String lang = 'AR';
                      CacheHelper.saveData(key: 'lang', value: lang);
                    },
                    child: Container(
                      width: 270.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: arSelectColor,
                        borderRadius: BorderRadiusDirectional.circular(20),
                        border: Border.all(),
                      ),
                      child: const Center(
                        child: Text(
                          'العربية',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  engSelectColor == Colors.black ||
                          arSelectColor == Colors.black
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22.sp,
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: yellowColor),
                            child: MaterialButton(
                              onPressed: () {
                                if (engSelectColor == Colors.black) {
                                  CacheHelper.saveData(
                                          key: 'lang', value: 'ENG')
                                      .then((value) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyApp(
                                          selectLan: 'en',
                                        ),
                                      ),
                                    );
                                  });
                                } else if (arSelectColor == Colors.black) {
                                  CacheHelper.saveData(key: 'lang', value: 'AR')
                                      .then((value) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const MyApp(
                                                selectLan: 'ar',
                                              )),
                                    );
                                  });
                                }
                              },
                              child: const Text('Next',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
