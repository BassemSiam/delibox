import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delibox/Screens/Admin/Show_Orders_screen.dart';
import 'package:delibox/Screens/Admin/Users_Details_screen.dart';
import 'package:delibox/components/components.dart';
import 'package:flutter/material.dart';
import '../../Models/orderModel.dart';
import '../../components/cash_helper.dart';
import '../../generated/l10n.dart';
import '../User Login&Register/Login_screen.dart';

class ShowUsersScreen extends StatefulWidget {
  const ShowUsersScreen({super.key});

  State<ShowUsersScreen> createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {
  List<String> usernames = [];
  List<String> brandnames = [];
  List<String> email = [];
  List<String> phone = [];
  List<String> idForUser = [];
  List<OrderModel> orders = [];
  bool isLoading = true;
  List<Stream<QuerySnapshot>> ordersStreams = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((querySnapshot) {
      setState(() {
        usernames.clear();
        brandnames.clear();
        email.clear();
        phone.clear();
        idForUser.clear();
        ordersStreams.clear();
        querySnapshot.docs.forEach((result) {
          usernames.add(result.data()['userName']);
          brandnames.add(result.data()['brandName']);
          email.add(result.data()['email']);
          phone.add(result.data()['phone']);
          idForUser.add(result.data()['uId']);
          ordersStreams.add(FirebaseFirestore.instance
              .collection('users')
              .doc(result.id)
              .collection('orders')
              .where('isPanding', isEqualTo: true)
              .where('isShipped', isEqualTo: true)
              .snapshots());
        });
        isLoading = false; // Set _isLoading to false when data is loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).customers,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                showAlert(context,
                    continueButtonText: S.of(context).logout,
                    title: S.of(context).log_out,
                    content: S.of(context).do_you_want_to_logout,
                    onContinue: () {
                  CacheHelper.removeData(key: 'uId');

                  CacheHelper.removeData(key: 'loggedIn');
                  navigateAndFinish(context, const LoginScreen());
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: isLoading
          ? Center(
              child: loadingCar(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff0C2D57)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        S.of(context).customers,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        S.of(context).brand,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(S.of(context).orders,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return StreamBuilder<QuerySnapshot>(
                              stream: ordersStreams[index],
                              builder: (context, snapshot) {
                                int orderCount = snapshot.hasData
                                    ? snapshot.data!.docs.length
                                    : 0;

                                return GestureDetector(
                                  onTap: () {
                                    navigatorTo(
                                      context,
                                      UserDetailsScreen(
                                        userId: idForUser[index],
                                        userName: usernames[index],
                                        email: email[index],
                                        phone: phone[index],
                                        brandName: brandnames[index],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xffEFECEC)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: SingleChildScrollView(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                usernames[index].toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                brandnames[index],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Stack(
                                              children: [
                                                TextButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Color.fromARGB(
                                                                  255,
                                                                  156,
                                                                  173,
                                                                  182))),
                                                  child: Text(
                                                    orderCount.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    print(idForUser[index]);
                                                    navigatorTo(
                                                      context,
                                                      OrdersAdmin(
                                                        userId:
                                                            idForUser[index],
                                                        userName:
                                                            usernames[index],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                orderCount == 0
                                                    ? Container()
                                                    : CircleAvatar(
                                                        radius: 7.5,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                orderCount == 0
                                                    ? Container()
                                                    : CircleAvatar(
                                                        radius: 7,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 3),
                        itemCount: usernames.length),
                  ),
                ),
              ],
            ),
    );
  }
}
