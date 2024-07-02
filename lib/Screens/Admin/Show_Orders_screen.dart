import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delibox/Screens/Admin/Search_orders_admin_screen.dart';
import 'package:delibox/Screens/Admin/fillters_government.dart';
import 'package:delibox/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../Models/orderModel.dart';
import '../../generated/l10n.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({
    super.key,
    required this.userId,
    required this.userName,
  });

  final String userId;
  final String userName;
  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  List<OrderModel> ordersResults = [];

  Stream<QuerySnapshot> getOrdersStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('orders')
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                navigatorTo(context, FillterScreen(userId: widget.userId));
              },
              icon: const Icon(
                Icons.filter_list_outlined,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                navigatorTo(context, SearchAdminScreen(userId: widget.userId));
              },
              icon: const Icon(
                Icons.search,
                size: 40,
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          widget.userName.toUpperCase(),
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: getOrdersStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingCar());
            }

            final ordersResults = snapshot.data!.docs.map((doc) {
              return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();
            return ordersResults.isNotEmpty
                ? ListView.separated(
                    itemCount: ordersResults.length,
                    separatorBuilder: (context, index) => const Divider(
                      endIndent: 12,
                      indent: 12,
                      thickness: 3,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final orders = ordersResults[index];
                      String searchMod = '';
                      int newshipping;
                      dynamic iconShipping;
                      dynamic iconColor;

                      void shippingMood() {
                        if (orders.isPanding!) {
                          searchMod = S.of(context).in_waiting;
                          iconShipping = FontAwesomeIcons.spinner;
                          iconColor = Colors.blueAccent;
                        } else if (!orders.isPanding!) {
                          searchMod = S.of(context).is_shipped;
                          iconShipping = FontAwesomeIcons.check;
                          iconColor = Colors.green;
                        }
                        if (!orders.isShipped!) {
                          searchMod = S.of(context).Not_shipped;
                          iconShipping = FontAwesomeIcons.xmark;
                          iconColor = Colors.red;
                        }
                      }

                      switch (orders.governorate) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.calendar,
                                  size: 16,
                                  color: Color(0xffD04848),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  DateFormat('dd-MM-yyy')
                                      .format(orders.date!)
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                  orders.time!.toString(),
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
                                  orders.clientName!,
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
                              '${orders.picesNumber} ${S.of(context).pices} ',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    '${orders.price! + newshipping} ${S.of(context).pound}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.green[400])),
                              ],
                            ),
                            Text(
                              '${orders.clientPhone}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${orders.governorate} - ${orders.region} - ${orders.streetName}\n${S.of(context).building_number} ${orders.bulidingNumber} - ${S.of(context).floor_number} ${orders.levelNumber} - ${S.of(context).apartment_number} ${orders.flatNumber}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '${orders.comments} ',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  searchMod,
                                  style: const TextStyle(
                                      color: Color(0xff19376D), fontSize: 18),
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
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  S.of(context).order_code,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey),
                                ),
                                Text(
                                  ' : ${orders.oId!.substring(0, 10)}',
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
                                        text: orders.oId!.substring(0, 10)));
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
                              height: 15,
                            ),
                            orders.isPanding! && orders.isShipped!
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                            onPressed: () {
                                              showAlert(context,
                                                  continueButtonText:
                                                      S.of(context).cancel,
                                                  title: S
                                                      .of(context)
                                                      .order_cancel,
                                                  content: S
                                                      .of(context)
                                                      .do_the_order_cancel,
                                                  onContinue: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(widget.userId)
                                                    .collection('orders')
                                                    .doc(orders.oId)
                                                    .update({
                                                  'isPanding': true,
                                                  'isShipped': false,
                                                }).then((value) {
                                                  Navigator.pop(context);

                                                  showToast(
                                                      text: S
                                                          .of(context)
                                                          .Not_shipped,
                                                      state:
                                                          ToastStates.success);
                                                });
                                              });
                                            },
                                            child: Text(
                                              S.of(context).Not_shipped,
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
                                                  BorderRadius.circular(8)),
                                          child: TextButton(
                                            onPressed: () {
                                              showAlert(context,
                                                  continueButtonText:
                                                      S.of(context).yes,
                                                  title: S
                                                      .of(context)
                                                      .order_deliverd,
                                                  content: S
                                                      .of(context)
                                                      .do_the_order_delivered,
                                                  onContinue: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(widget.userId)
                                                    .collection('orders')
                                                    .doc(orders.oId)
                                                    .update({
                                                  'isPanding': false,
                                                  'isShipped': true,
                                                }).then((value) {
                                                  Navigator.pop(context);
                                                  showToast(
                                                      text: S
                                                          .of(context)
                                                          .is_shipped,
                                                      state:
                                                          ToastStates.success);
                                                });
                                              });
                                            },
                                            child: Text(
                                              S.of(context).is_shipped,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
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
                          style:
                              const TextStyle(fontSize: 26, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
