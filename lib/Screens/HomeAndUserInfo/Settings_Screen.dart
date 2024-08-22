import 'package:delibox/components/cash_helper.dart';
import 'package:delibox/components/components.dart';
import 'package:delibox/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/l10n.dart';
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Color? engSelectColor;
  Color? arSelectColor;

  @override
  void initState() {
    super.initState();
    initLang();
  }

  initLang() async {
    String selectLan = await CacheHelper.getData(key: 'lang');
    if (selectLan == 'ENG') {
      setState(() {
        engSelectColor = Colors.black;
        arSelectColor = Colors.grey;
      });
    } else if (selectLan == 'AR') {
      setState(() {
        arSelectColor = Colors.black;
        engSelectColor = Colors.grey;
      });
    } else {
      setState(() {
        engSelectColor = Colors.grey;
        arSelectColor = Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/word_image.png',
                height: 70.h,
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    S.of(context).Select_Language,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: engSelectColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (await CacheHelper.getData(key: 'lang') != 'ENG') {
                          await CacheHelper.saveData(key: 'lang', value: 'ENG');
                          navigateAndFinish(
                              context,
                              MyApp(
                                selectLan: 'en',
                              ));

                          setState(() {
                            engSelectColor = Colors.black;
                            arSelectColor = Colors.grey;
                          });
                        } else {
                          setState(() {});
                        }
                      },
                      child: Text(
                        'English',
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: arSelectColor,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (await CacheHelper.getData(key: 'lang') != 'AR') {
                          await CacheHelper.saveData(key: 'lang', value: 'AR');
                          navigateAndFinish(
                              context,
                              MyApp(
                                selectLan: 'ar',
                              ));

                          setState(() {
                            arSelectColor = Colors.black;
                            engSelectColor = Colors.grey;
                          });
                        } else {
                          setState(() {});
                        }
                      },
                      child: Text(
                        'العربية',
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // PDF(
                  //   enableSwipe: true,
                  //   swipeHorizontal: true,
                  //   autoSpacing: false,
                  //   pageFling: false,
                  //   onError: (error) {
                  //     print(error.toString());
                  //   },
                  //   onPageError: (page, error) {
                  //     print('$page: ${error.toString()}');
                  //   },
                  //   onPageChanged: (int page, int total) {
                  //     print('page change: $page/$total');
                  //   },
                  // ).fromAsset('assets/pdf/file-example.pdf');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    )
                  ],
                )),
            const Spacer(),
            Text(
              S.of(context).contact_us_t,
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(
              height: 25.h,
            ),
            isArabic()
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse('https://wa.me/+201122908268'),
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.whatsapp,
                            color: Colors.green, size: 25.sp),
                      ),
                      IconButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse('tel:+201122908268'));
                        },
                        icon: FaIcon(FontAwesomeIcons.phone,
                            color: Colors.green, size: 25.sp),
                      ),
                      IconButton(
                        onPressed: () async {
                          await launchUrl(
                              Uri.parse('https://www.facebook.com/deliiboxx'));
                        },
                        icon: FaIcon(FontAwesomeIcons.facebook,
                            color: Color.fromARGB(255, 14, 72, 172),
                            size: 25.sp),
                      ),
                      IconButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse(
                              'https://www.instagram.com/deliiboxx_'));
                        },
                        icon: FaIcon(FontAwesomeIcons.instagram,
                            color: Colors.pink, size: 25.sp),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse(
                              'https://www.instagram.com/deliiboxx_'));
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.pink,
                          size: 25.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await launchUrl(
                              Uri.parse('https://www.facebook.com/deliiboxx'));
                        },
                        icon: FaIcon(FontAwesomeIcons.facebook,
                            color: Color.fromARGB(255, 14, 72, 172),
                            size: 25.sp),
                      ),
                      IconButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse('tel:+201122908268'));
                        },
                        icon: FaIcon(FontAwesomeIcons.phone,
                            color: Colors.green, size: 25.sp),
                      ),
                      IconButton(
                        onPressed: () async {
                          await launchUrl(
                              Uri.parse('https://wa.me/+201122908268'));
                        },
                        icon: FaIcon(FontAwesomeIcons.whatsapp,
                            color: Colors.green, size: 25.sp),
                      ),
                    ],
                  ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }
}
