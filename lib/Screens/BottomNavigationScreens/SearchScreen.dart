import 'package:delibox/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../Models/orderModel.dart';
import '../../generated/l10n.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextDirection textDirection = TextDirection.LTR;
  TextEditingController searchController = TextEditingController();
  List<OrderModel> searchResults = [];

  Future<void> searchOrdersByClientName(String clientName) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .where('clientName',
            isGreaterThanOrEqualTo: clientName,
            isLessThanOrEqualTo: '$clientName\uf8ff')
        .get();

    setState(() {
      searchResults = querySnapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data());
      }).toList();
    });
  }

  void onSearchChanged(String value) {
    setState(() {
      textDirection = value.contains(RegExp(r'[\u0600-\u06FF]'))
          ? TextDirection.RTL
          : TextDirection.LTR;
    });

    if (value.isNotEmpty) {
      searchOrdersByClientName(value);
    } else {
      searchResults = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 38.h,
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(12),
                  onChanged: onSearchChanged,
                  borderRadius: BorderRadius.circular(20),
                  keyboardType: TextInputType.name,
                  placeholder: S.of(context).search_by_name,
                  controller: searchController,
                  style: TextStyle(fontSize: 14.sp),
                  placeholderStyle: TextStyle(fontSize: 12.sp),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('orders')
                      .where('clientName',
                          isGreaterThanOrEqualTo: searchController.text,
                          isLessThanOrEqualTo: '${searchController.text}\uf8ff')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: loadingCar());
                    }

                    final searchResults = snapshot.data!.docs.map((doc) {
                      return OrderModel.fromJson(
                          doc.data() as Map<String, dynamic>);
                    }).toList();
                    return Expanded(
                      child: searchResults.isEmpty
                          ? Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/search_re.png',
                                    ),
                                    Text(
                                      S.of(context).there_are_no_data_found,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      S.of(context).search_by_customer_name,
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: searchResults.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                endIndent: 12,
                                indent: 12,
                                thickness: 2,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final searchOrder = searchResults[index];
                                String searchMod = '';
                                int newshipping;
                                dynamic iconShipping;
                                dynamic iconColor;

                                void shippingMood() {
                                  if (searchOrder.isPanding!) {
                                    searchMod = S.of(context).in_waiting;
                                    iconShipping = FontAwesomeIcons.spinner;
                                    iconColor = Colors.blueAccent;
                                  } else if (!searchOrder.isPanding!) {
                                    searchMod = S.of(context).is_shipped;
                                    iconShipping = FontAwesomeIcons.check;
                                    iconColor = Colors.green;
                                  }
                                  if (!searchOrder.isShipped!) {
                                    searchMod = S.of(context).Not_shipped;
                                    iconShipping = FontAwesomeIcons.xmark;
                                    iconColor = Colors.red;
                                  }
                                }

                                switch (searchOrder.governorate) {
                                  case == 'القاهرة':
                                    newshipping = 55;
                                  case == 'القاهرة - القاهرة الجديدة و الرحاب':
                                    newshipping = 50;
                                    break;
                                  case == 'القاهرة - مدينتى':
                                    newshipping = 60;
                                    break;
                                  case == 'القاهرة - الشروق و بدر':
                                    newshipping = 70;
                                    break;
                                  case == 'الجيزة':
                                    newshipping = 60;
                                    break;
                                  case == 'الإسكندرية':
                                    newshipping = 70;
                                    break;
                                  case == 'الإسماعيلية':
                                    newshipping = 65;
                                    break;
                                  case == 'أسوان':
                                    newshipping = 90;
                                    break;
                                  case == 'أسيوط':
                                    newshipping = 80;
                                    break;
                                  case == 'البحر الأحمر':
                                    newshipping = 110;
                                    break;
                                  case == 'البحيرة':
                                    newshipping = 70;
                                    break;
                                  case == 'بني سويف':
                                    newshipping = 70;
                                    break;
                                  case == 'بورسعيد':
                                    newshipping = 70;
                                    break;
                                  case == 'جنوب سيناء':
                                    newshipping = 110;
                                    break;
                                  case == 'الدقهلية':
                                    newshipping = 70;
                                    break;
                                  case == 'دمياط':
                                    newshipping = 70;
                                    break;
                                  case == 'سوهاج':
                                    newshipping = 80;
                                    break;
                                  case == 'السويس':
                                    newshipping = 70;
                                    break;
                                  case == 'الشرقية':
                                    newshipping = 70;
                                    break;
                                  case == 'شمال سيناء':
                                    newshipping = 110;
                                    break;
                                  case == 'الغربية':
                                    newshipping = 70;
                                    break;
                                  case == 'الفيوم':
                                    newshipping = 80;
                                    break;
                                  case == 'القليوبية':
                                    newshipping = 70;
                                    break;
                                  case == 'قنا':
                                    newshipping = 80;
                                    break;
                                  case == 'كفر الشيخ':
                                    newshipping = 70;
                                    break;
                                  case == 'مطروح':
                                    newshipping = 110;
                                    break;
                                  case == 'المنوفية':
                                    newshipping = 70;
                                    break;
                                  case == 'المنيا':
                                    newshipping = 80;
                                    break;
                                  case == 'الوادي الجديد':
                                    newshipping = 110;
                                    break;
                                  default:
                                    newshipping = 0;
                                }

                                shippingMood();
                                return Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.calendar,
                                            size: 12.sp,
                                            color: Color(0xffD04848),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text(
                                            DateFormat('dd-MM-yyy')
                                                .format(searchOrder.date!)
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            searchOrder.clientName!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.user,
                                            color: const Color(0xff387ADF),
                                            size: 12.sp,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Text(
                                        searchOrder.productName!,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Text(
                                        '${searchOrder.picesNumber} ${S.of(context).pices} ',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${searchOrder.price! + newshipping} ${S.of(context).pound}',
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.green[400]),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        '${searchOrder.clientPhone}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.h,
                                      ),
                                      Text(
                                        '${searchOrder.governorate} - ${searchOrder.region} - ${searchOrder.streetName}\n${S.of(context).building_number} ${searchOrder.bulidingNumber} - ${S.of(context).floor_number} ${searchOrder.levelNumber} - ${S.of(context).apartment_number} ${searchOrder.flatNumber}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.h,
                                      ),
                                      Text(
                                        '${searchOrder.comments}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            searchMod,
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          FaIcon(
                                            iconShipping,
                                            color: iconColor,
                                            size: 14.sp,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            S.of(context).order_code,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            ' : ${searchOrder.oId!.substring(0, 10).toUpperCase()}',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
