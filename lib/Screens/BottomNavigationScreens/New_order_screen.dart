import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delibox/components/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../Models/orderModel.dart';
import '../../components/components.dart';
import '../../generated/l10n.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  var clientNameController = TextEditingController();
  var clientPhoneController = TextEditingController();
  var piceNumberController = TextEditingController();
  var priceController = TextEditingController();
  var regionController = TextEditingController();
  var streetNameController = TextEditingController();
  var bulidingNumberController = TextEditingController();
  var levelNumberController = TextEditingController();
  var flatNumberController = TextEditingController();
  var commentsController = TextEditingController();
  var searchController = TextEditingController();

  String clientNameDirection = '';
  String regionDirection = '';
  String streetNameDirection = '';
  String bulidingNumberDirection = '';
  String commentsDirection = '';

  bool isLoading = false;

  GlobalKey<FormState> bottomSheetKey = GlobalKey<FormState>();

  String? selectedGovernorate;

  ScrollController scrollController = ScrollController();

  final FirebaseFirestore db = FirebaseFirestore.instance;

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

  List<OrderModel> orders = [];

  int currentStep = 0;

  void refreshList() {
    setState(() {});
  }

  TextAlign getTextAlign(String text) {
    final hasArabic = RegExp(
            r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
            unicode: true)
        .hasMatch(text);
    return hasArabic ? TextAlign.right : TextAlign.left;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? userId = auth.currentUser!.uid;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('orders')
              .orderBy('orderId', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingCar());
            }
            final List<DocumentSnapshot> orderDocs = snapshot.data!.docs;

            // Convert the order documents to OrderModel objects
            orders = orderDocs
                .map((doc) =>
                    OrderModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            return orders.isNotEmpty
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    child: Column(
                      children: [
                        orders.isNotEmpty
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey[300],
                                        ),
                                        child: Center(
                                          child: Text(
                                            ' ${S.of(context).count_orders} (${orders.length.toString()})',
                                            style: const TextStyle(
                                                color: blueColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 30.h,
                            ),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              final order = orders[index];

                              var clintNameCon = TextEditingController(
                                  text: StringUtils.capitalize(
                                      order.clientName.toString()));

                              var clintPhoneCon = TextEditingController(
                                  text: order.clientPhone!);

                              var clintPiceCon = TextEditingController(
                                  text: order.picesNumber!);

                              var clintAddresCon = TextEditingController(
                                  text:
                                      ' ${S.of(context).governorate} ${order.governorate!} \n ${S.of(context).region} ${order.region!} \n ${S.of(context).street_name} ${order.streetName!} \n ${S.of(context).building_number} ${order.bulidingNumber!} \n ${S.of(context).floor_number} ${order.levelNumber!} \n ${S.of(context).apartment_number} ${order.flatNumber!}');

                              var clintCommentsCon = TextEditingController(
                                text: order.comments!,
                              );

                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                    ),
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    S.of(context).order_number,
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: blueColor),
                                                  ),
                                                  Text(
                                                    ': ${order.orderId.toString()}',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const Spacer(),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        DateFormat('dd-MM-yyy')
                                                            .format(order.date!)
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        order.time!,
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextFiledOrder(
                                              enabled: false,
                                              textDirection:
                                                  clientNameDirection,
                                              onChange: (value) {
                                                setState(() {
                                                  clientNameDirection = value;
                                                });
                                              },
                                              controller: clintNameCon,
                                              text:
                                                  '${S.of(context).customer_name} : ',
                                              keybordType: TextInputType.name,
                                              validator: (p0) {
                                                return null;
                                              },
                                            ),
                                            TextFiledOrder(
                                              enabled: false,
                                              controller: clintPhoneCon,
                                              text:
                                                  '${S.of(context).customer_Phone} : ',
                                              keybordType: TextInputType.phone,
                                              validator: (p0) {
                                                return null;
                                              },
                                            ),
                                            TextFiledOrder(
                                              enabled: false,
                                              controller: clintPiceCon,
                                              text:
                                                  '${S.of(context).number_of_pieces} : ',
                                              keybordType: const TextInputType
                                                  .numberWithOptions(
                                                  decimal: true, signed: true),
                                              validator: (p0) {
                                                return null;
                                              },
                                            ),
                                            TextFiledOrder(
                                              enabled: false,
                                              textDirection: regionDirection,
                                              onChange: (value) {
                                                setState(() {
                                                  regionDirection = value;
                                                });
                                              },
                                              controller: clintAddresCon,
                                              text:
                                                  '${S.of(context).the_address} : ',
                                              keybordType: TextInputType.name,
                                              validator: (p0) {
                                                return null;
                                              },
                                            ),
                                            TextFiledOrder(
                                              enabled: false,
                                              textDirection: commentsDirection,
                                              onChange: (value) {
                                                setState(() {
                                                  commentsDirection = value;
                                                });
                                              },
                                              controller: clintCommentsCon,
                                              text: '${S.of(context).Notes} : ',
                                              keybordType: TextInputType.name,
                                              validator: (p0) {
                                                return null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${S.of(context).total_amount} + ',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  S.of(context).shipping_price,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                  (' = ${order.price! + order.shipingPrice!}')
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 25.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  S.of(context).order_code,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  ' : ${order.oId!.substring(0, 10).toUpperCase()}',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 100.h,
                                    color: Colors.white,
                                    child: order.isShipped!
                                        ? Stepper(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            steps: [
                                              Step(
                                                isActive: true,
                                                state: StepState.complete,
                                                title: Text(
                                                  S.of(context).in_waiting,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                content: Container(),
                                              ),
                                              Step(
                                                isActive: order.isPanding!
                                                    ? false
                                                    : true,
                                                state: order.isPanding!
                                                    ? StepState.disabled
                                                    : StepState.complete,
                                                title: Text(
                                                  S.of(context).is_shipped,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                content: Container(),
                                              ),
                                            ],
                                            type: StepperType.horizontal,
                                            onStepTapped: (index) {},
                                            currentStep: currentStep,
                                            controlsBuilder:
                                                (context, details) {
                                              return const SizedBox.shrink();
                                            },
                                          )
                                        : Stepper(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            steps: [
                                              Step(
                                                isActive: true,
                                                state: StepState.complete,
                                                title: Text(
                                                  S.of(context).in_waiting,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                content: Container(),
                                              ),
                                              Step(
                                                isActive: order.isPanding!
                                                    ? false
                                                    : true,
                                                state: order.isPanding!
                                                    ? StepState.error
                                                    : StepState.complete,
                                                title: Text(
                                                  S.of(context).Not_shipped,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                content: Container(),
                                              ),
                                            ],
                                            type: StepperType.horizontal,
                                            onStepTapped: (index) {},
                                            currentStep: currentStep,
                                            controlsBuilder:
                                                (context, details) {
                                              return const SizedBox.shrink();
                                            },
                                          ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/remove_box.png',
                        ),
                        Text(
                          S.of(context).no_orders,
                          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                        ),
                        Text(
                          S.of(context).add_orders,
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.grey[200],
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Form(
                    key: bottomSheetKey,
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      int newshipping;

                      switch (selectedGovernorate) {
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

                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 2 + 150,
                        child: ModalProgressHUD(
                          progressIndicator: loadingCar(),
                          inAsyncCall: isLoading,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 40.sp,
                                left: 20.sp,
                                right: 20.sp,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      S.of(context).add_order,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextFiledOrder(
                                      textDirection: clientNameDirection,
                                      onChange: (value) {
                                        setState(() {
                                          clientNameDirection = value;
                                        });
                                      },
                                      controller: clientNameController,
                                      icon: const Icon(Icons.person),
                                      keybordType: TextInputType.name,
                                      text: '${S.of(context).customer_name}:  ',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S
                                              .of(context)
                                              .add_customer_name;
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFiledOrder(
                                      controller: clientPhoneController,
                                      icon: const Icon(Icons.phone),
                                      keybordType: TextInputType.phone,
                                      text:
                                          '${S.of(context).customer_Phone}:  ',
                                      validator: (value) {
                                        final RegExp regex =
                                            RegExp(r'^01[0|1|2|5]{1}[0-9]{8}$');
                                        if (value!.isEmpty) {
                                          return S.of(context).phone_validator;
                                        } else if (value.length != 11) {
                                          return S
                                              .of(context)
                                              .phone_count_validator;
                                        } else if (!regex.hasMatch(value)) {
                                          return S
                                              .of(context)
                                              .phone_fasle_validator;
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFiledOrder(
                                      controller: piceNumberController,
                                      icon: const Icon(Icons.numbers),
                                      keybordType: TextInputType.number,
                                      text:
                                          '${S.of(context).number_of_pieces} :  ',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S
                                              .of(context)
                                              .numer_order_validator;
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFiledOrder(
                                      controller: priceController,
                                      icon: const Icon(Icons.money),
                                      keybordType: TextInputType.number,
                                      text: '${S.of(context).total_amount} :',
                                      textDics:
                                          '${S.of(context).without_shipping}  ',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S
                                              .of(context)
                                              .price_order_validator;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).address_Detailed,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${S.of(context).governorate} : ',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          Colors.grey[100],
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    isExpanded: true,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    dropdownColor:
                                                        Colors.grey[300],
                                                    iconSize: 20.sp,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                    value: selectedGovernorate,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return S
                                                            .of(context)
                                                            .choose_governorate_validator;
                                                      }
                                                      return null;
                                                    },
                                                    hint: Text(
                                                      S
                                                          .of(context)
                                                          .choose_governorate,
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedGovernorate =
                                                            newValue;
                                                        print(
                                                            selectedGovernorate);
                                                      });
                                                    },
                                                    items: governorates.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: SizedBox(
                                                          width:
                                                              double.infinity,
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
                                            ],
                                          ),
                                        ),
                                        TextFiledOrder(
                                          textDirection: regionDirection,
                                          controller: regionController,
                                          icon: const Icon(Icons.home),
                                          keybordType: TextInputType.text,
                                          text: '${S.of(context).region} : ',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return S
                                                  .of(context)
                                                  .region_validator;
                                            }
                                            return null;
                                          },
                                          onChange: (value) {
                                            setState(() {
                                              regionDirection = value;
                                            });
                                          },
                                        ),
                                        TextFiledOrder(
                                          textDirection: streetNameDirection,
                                          controller: streetNameController,
                                          icon: const Icon(Icons.add_road),
                                          keybordType: TextInputType.text,
                                          text:
                                              '${S.of(context).street_name} : ',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return S
                                                  .of(context)
                                                  .street_name_validator;
                                            }
                                            return null;
                                          },
                                          onChange: (value) {
                                            setState(() {
                                              streetNameDirection = value;
                                            });
                                          },
                                        ),
                                        TextFiledOrder(
                                          textDirection:
                                              bulidingNumberDirection,
                                          controller: bulidingNumberController,
                                          icon: const Icon(Icons.add_home_work),
                                          keybordType: TextInputType.text,
                                          text:
                                              '${S.of(context).building_number} : ',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return S
                                                  .of(context)
                                                  .building_validator;
                                            }
                                            return null;
                                          },
                                          onChange: (value) {
                                            setState(() {
                                              bulidingNumberDirection = value;
                                            });
                                          },
                                        ),
                                        TextFiledOrder(
                                          controller: levelNumberController,
                                          keybordType: TextInputType.number,
                                          icon: const Icon(Icons
                                              .format_list_numbered_outlined),
                                          text:
                                              '${S.of(context).floor_number} : ',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return S
                                                  .of(context)
                                                  .flor_validator;
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFiledOrder(
                                          controller: flatNumberController,
                                          keybordType: const TextInputType
                                              .numberWithOptions(
                                              decimal: true, signed: true),
                                          icon: const Icon(
                                              Icons.onetwothree_rounded),
                                          text:
                                              '${S.of(context).apartment_number} : ',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return S
                                                  .of(context)
                                                  .appartment_validator;
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 20),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 80.h,
                                        child: TextFormField(
                                          controller: commentsController,
                                          textAlign: getTextAlign(
                                              commentsController.text),
                                          expands: true,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            hintStyle:
                                                TextStyle(fontSize: 12.sp),
                                            hintText:
                                                S.of(context).comments_chose,
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 4.w),
                                              gapPadding: 3,
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                strokeAlign: BorderSide
                                                    .strokeAlignOutside,
                                                color: Colors.red,
                                                width: 3,
                                              ),
                                            ),
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.center,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (bottomSheetKey.currentState!
                                              .validate()) {
                                            isLoading = true;
                                            setState(() {});

                                            try {
                                              await createUserOrders(
                                                context,
                                                clientName:
                                                    clientNameController.text,
                                                clientPhone:
                                                    clientPhoneController.text,
                                                piceNumber:
                                                    piceNumberController.text,
                                                price: int.parse(
                                                    priceController.text),
                                                shipingPrice: newshipping,
                                                governorate:
                                                    selectedGovernorate,
                                                region: regionController.text,
                                                bulidingNumber:
                                                    bulidingNumberController
                                                        .text,
                                                levelNumber:
                                                    levelNumberController.text,
                                                flatNumber:
                                                    flatNumberController.text,
                                                streetName:
                                                    streetNameController.text,
                                                comments:
                                                    commentsController.text,
                                                date: DateTime.now(),
                                                time: DateFormat('KK:mm a')
                                                    .format(DateTime.now())
                                                    .toString(),
                                                isPanding:
                                                    OrderModel().isPanding!,
                                                isShipped:
                                                    OrderModel().isShipped!,
                                              ).then((value) {
                                                clearOrdersData();
                                                doneAlert(
                                                  context,
                                                  text: S
                                                      .of(context)
                                                      .new_requast_added,
                                                );
                                              });
                                            } catch (e) {
                                              cancelAlert(context,
                                                  text: S
                                                      .of(context)
                                                      .error_network);
                                            } finally {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          } else {
                                            cancelAlert(context,
                                                text: S.of(context).data_error);
                                          }
                                        },
                                        child: Container(
                                          width: 250,
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: 20,
                                              right: 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            gradient: const LinearGradient(
                                              colors: [
                                                yellowColor,
                                                blueColor,
                                              ],
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(S.of(context).add_order,
                                                style: const TextStyle(
                                                    fontFamily: 'Amiri',
                                                    fontSize: 20,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            );
          },
          backgroundColor: Colors.grey[400],
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: blueColor,
          ),
        ),
      ),
    );
  }

  clearOrdersData() {
    clientNameController.text = '';
    clientPhoneController.text = '';
    piceNumberController.text = '';
    priceController.text = '';
    regionController.text = '';
    streetNameController.text = '';
    bulidingNumberController.text = '';
    levelNumberController.text = '';
    flatNumberController.text = '';
    commentsController.text = '';
    selectedGovernorate = null;
  }
}
