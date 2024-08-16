import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({super.key});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

FirebaseAuth auth = FirebaseAuth.instance;
String? userId = auth.currentUser!.uid;

class _CalculationScreenState extends State<CalculationScreen> {
  List<Map<String, dynamic>> _ordersByDay = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? userId = auth.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('date', descending: true)
        .get();

    List<Map<String, dynamic>> orderedOrders = querySnapshot.docs
        .map((e) => ({
              ...e.data(),
              'id': e.id,
              'dateTimestamp': e.data()['date'],
            }))
        .toList();

    List<Map<String, dynamic>> ordersByDay = [];
    Map<String, Map<String, dynamic>> daysOrders = {};
    for (Map<String, dynamic> order in orderedOrders) {
      DateTime orderDate = order['dateTimestamp'].toDate();
      String dateIdentifier =
          '${orderDate.day}-${orderDate.month}-${orderDate.year}';
      if (daysOrders.containsKey(dateIdentifier)) {
        daysOrders[dateIdentifier]!['orders'].add(order);
        daysOrders[dateIdentifier]!['totalPrice'] += order['price'];
      } else {
        daysOrders[dateIdentifier] = {
          'orders': [order],
          'totalPrice': order['price'],
        };
      }
    }

    for (MapEntry<String, Map<String, dynamic>> entry in daysOrders.entries) {
      ordersByDay.add({
        'date': entry.key,
        'orders': entry.value['orders'],
        'totalPrice': entry.value['totalPrice'],
      });
    }

    setState(() {
      _ordersByDay = ordersByDay;
    });

    if (mounted) {
      setState(() {
        _ordersByDay = ordersByDay;
      });
    }

    @override
    void dispose() {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ordersByDay.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/accounting.png',
                    width: 200.w,
                  ),
                  Text(
                    S.of(context).add_accountin_order,
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                  Text(
                    S.of(context).no_accounting_now,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff2B2A4C)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        S.of(context).date,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      Text(S.of(context).count,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                      Text(S.of(context).price,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> orderDay = _ordersByDay[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 25.h,
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color(0xff9FBB73)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    orderDay['date'],
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  Text(
                                    '${orderDay['orders'].length}',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  Text(
                                    '${orderDay['totalPrice']}',
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: _ordersByDay.length),
                  ),
                ),
              ],
            ),
    );
  }
}
