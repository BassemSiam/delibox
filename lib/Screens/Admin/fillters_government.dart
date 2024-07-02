import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../Models/orderModel.dart';
import '../../components/components.dart';
import '../../generated/l10n.dart';

class FillterScreen extends StatefulWidget {
  const FillterScreen({
    super.key,
    required this.userId,
  });

  final String userId;
  @override
  State<FillterScreen> createState() => _FillterScreenState();
}

class _FillterScreenState extends State<FillterScreen> {
  TextDirection textDirection = TextDirection.LTR;
  TextEditingController searchController = TextEditingController();
  List<OrderModel> searchResults = [];

  String? selectedGovernorate;

  ScrollController scrollController = ScrollController();

  List<String> governorates = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'الإسماعيلية',
    'أسوان',
    'أسيوط',
    'البحر الأحمر',
    'البحيرة',
    'بني سويف',
    'بورسعيد',
    'جنوب سيناء',
    'الدقهلية',
    'دمياط',
    'سوهاج',
    'السويس',
    'الشرقية',
    'شمال سيناء',
    'الغربية',
    'الفيوم',
    'القليوبية',
    'قنا',
    'كفر الشيخ',
    'مطروح',
    'المنوفية',
    'المنيا',
    'الوادي الجديد',
  ];

  Future<void> searchOrdersBygovernorate(String governorate) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('orders')
        .where('governorate',
            isGreaterThanOrEqualTo: governorate,
            isLessThanOrEqualTo: '$governorate\uf8ff')
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
      searchOrdersBygovernorate(value);
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
                height: 70,
                child: SingleChildScrollView(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(15),
                    dropdownColor: Colors.grey[300],
                    iconSize: 18,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                    value: selectedGovernorate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).choose_governorate_validator;
                      }
                      return null;
                    },
                    hint: Text(
                      S.of(context).choose_governorate,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedGovernorate = newValue;
                        print(selectedGovernorate);
                      });
                    },
                    items: governorates
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            value,
                          )),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.userId)
                      .collection('orders')
                      .where('governorate',
                          isGreaterThanOrEqualTo: selectedGovernorate,
                          isLessThanOrEqualTo: '$selectedGovernorate\uf8ff')
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
                                      S.of(context).filter_by_governorate,
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
                                    newshipping = 50;
                                    break;
                                  case == 'الإسكندرية':
                                    newshipping = 60;
                                    break;
                                  case == 'الإسماعيلية':
                                    newshipping = 60;
                                    break;
                                  case == 'أسوان':
                                    newshipping = 150;
                                    break;
                                  case == 'أسيوط':
                                    newshipping = 50;
                                    break;
                                  case == 'البحر الأحمر':
                                    newshipping = 50;
                                    break;
                                  case == 'البحيرة':
                                    newshipping = 95;
                                    break;
                                  case == 'بني سويف':
                                    newshipping = 50;
                                    break;
                                  case == 'بورسعيد':
                                    newshipping = 50;
                                    break;
                                  case == 'جنوب سيناء':
                                    newshipping = 50;
                                    break;
                                  case == 'الدقهلية':
                                    newshipping = 50;
                                    break;
                                  case == 'دمياط':
                                    newshipping = 50;
                                    break;
                                  case == 'سوهاج':
                                    newshipping = 50;
                                    break;
                                  case == 'السويس':
                                    newshipping = 50;
                                    break;
                                  case == 'الشرقية':
                                    newshipping = 50;
                                    break;
                                  case == 'شمال سيناء':
                                    newshipping = 50;
                                    break;
                                  case == 'الغربية':
                                    newshipping = 50;
                                    break;
                                  case == 'الفيوم':
                                    newshipping = 50;
                                    break;
                                  case == 'القليوبية':
                                    newshipping = 50;
                                    break;
                                  case == 'قنا':
                                    newshipping = 50;
                                    break;
                                  case == 'كفر الشيخ':
                                    newshipping = 50;
                                    break;
                                  case == 'مطروح':
                                    newshipping = 50;
                                    break;
                                  case == 'المنوفية':
                                    newshipping = 50;
                                    break;
                                  case == 'المنيا':
                                    newshipping = 50;
                                    break;
                                  case == 'الوادي الجديد':
                                    newshipping = 50;
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
