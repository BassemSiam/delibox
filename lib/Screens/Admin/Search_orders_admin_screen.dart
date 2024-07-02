import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../Models/orderModel.dart';
import '../../components/components.dart';
import '../../generated/l10n.dart';

class SearchAdminScreen extends StatefulWidget {
  const SearchAdminScreen({
    super.key,
    required this.userId,
  });

  final String userId;
  @override
  State<SearchAdminScreen> createState() => _SearchAdminScreenState();
}

class _SearchAdminScreenState extends State<SearchAdminScreen> {
  TextDirection textDirection = TextDirection.LTR;
  TextEditingController searchController = TextEditingController();
  List<OrderModel> searchResults = [];

  Future<void> searchOrdersByClientName(String clientName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
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
                height: 60,
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(12),
                  onChanged: onSearchChanged,
                  borderRadius: BorderRadius.circular(20),
                  keyboardType: TextInputType.name,
                  placeholder: S.of(context).search_by_name,
                  controller: searchController,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userId)
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
                                  children: [
                                    Image.asset(
                                      'assets/images/search_re.png',
                                    ),
                                    Text(
                                      S.of(context).there_are_no_data_found,
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.grey),
                                    ),
                                    Text(
                                      S.of(context).search_by_customer_name,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
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
                                thickness: 3,
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
                                    newshipping = 50;
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
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.calendar,
                                            size: 16,
                                            color: Color(0xffD04848),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            DateFormat('dd-MM-yyy')
                                                .format(searchOrder.date!)
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.clock,
                                            size: 16,
                                            color: Color(0xff124076),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            searchOrder.time!.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            searchOrder.clientName!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const FaIcon(
                                            FontAwesomeIcons.user,
                                            color: Color(0xff387ADF),
                                            size: 17,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${searchOrder.picesNumber} ${S.of(context).pices} ',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              '${searchOrder.price! + newshipping} ${S.of(context).pound}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green[400])),
                                        ],
                                      ),
                                      Text(
                                        '${searchOrder.clientPhone}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${searchOrder.governorate} - ${searchOrder.region} - ${searchOrder.streetName}\n${S.of(context).building_number} ${searchOrder.bulidingNumber} - ${S.of(context).floor_number} ${searchOrder.levelNumber} - ${S.of(context).apartment_number} ${searchOrder.flatNumber}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        '${searchOrder.comments}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            searchMod,
                                            style: const TextStyle(
                                                color: Color(0xff19376D),
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          FaIcon(
                                            iconShipping,
                                            color: iconColor,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            S.of(context).order_code,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            ' : ${searchOrder.oId!.substring(0, 10)}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: searchOrder.oId!
                                                      .substring(0, 10)));
                                              showToast(
                                                  text: S.of(context).code_copy,
                                                  state: ToastStates.success);
                                            },
                                            child: const Icon(
                                              Icons.copy,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      searchOrder.isPanding! &&
                                              searchOrder.isShipped!
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        showAlert(context,
                                                            continueButtonText: S
                                                                .of(context)
                                                                .Not_shipped,
                                                            title: S
                                                                .of(context)
                                                                .order_cancel,
                                                            content: S
                                                                .of(context)
                                                                .do_the_order_cancel,
                                                            onContinue:
                                                                () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(
                                                                  widget.userId)
                                                              .collection(
                                                                  'orders')
                                                              .doc(searchOrder
                                                                  .oId)
                                                              .update({
                                                            'isPanding': true,
                                                            'isShipped': false,
                                                          }).then((value) {
                                                            Navigator.pop(
                                                                context);

                                                            showToast(
                                                                text: S
                                                                    .of(context)
                                                                    .Not_shipped,
                                                                state: ToastStates
                                                                    .success);
                                                          });
                                                        });
                                                      },
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .Not_shipped,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        showAlert(context,
                                                            continueButtonText:
                                                                S
                                                                    .of(context)
                                                                    .yes,
                                                            title: S
                                                                .of(context)
                                                                .order_deliverd,
                                                            content: S
                                                                .of(context)
                                                                .do_the_order_delivered,
                                                            onContinue:
                                                                () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(
                                                                  widget.userId)
                                                              .collection(
                                                                  'orders')
                                                              .doc(searchOrder
                                                                  .oId)
                                                              .update({
                                                            'isPanding': false,
                                                            'isShipped': true,
                                                          }).then((value) {
                                                            Navigator.pop(
                                                                context);
                                                            showToast(
                                                                text: S
                                                                    .of(context)
                                                                    .is_shipped,
                                                                state: ToastStates
                                                                    .success);
                                                          });
                                                        });
                                                      },
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .is_shipped,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container()
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
