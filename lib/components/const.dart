import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delibox/Models/orderModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../Models/UserModel.dart';
import 'components.dart';

const Color yellowColor = Color(0xffF1B521);
const Color blueColor = Color(0xff3394B7);

var uId = '';

UserModel? model;
OrderModel? orderM;

getUserData({required sendUid}) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(sendUid)
      .get()
      .then((value) {
    model = UserModel.fromJson(value.data()!);
  }).catchError((onError) {});
}

updateUserData({
  required String brandName,
  required String email,
  required String phone,
}) {
  UserModel userModel = UserModel(
    userName: model!.userName,
    brandName: brandName,
    email: email,
    password: model!.password,
    phone: phone,
    uId: model!.uId,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(model!.uId)
      .update(userModel.toJson())
      .then((value) {
    getUserData(sendUid: uId);
  }).catchError((onError) {
  });
}

void updateEmail(String newEmail, String password, context) async {
  try {
    UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: model!.email!,
      password: model!.password!,
    );

    User? user = credential.user;

    if (user != null) {
      await user.updateEmail(newEmail).then((value) {
        updateUserData(
            brandName: model!.brandName!,
            email: newEmail,
            phone: model!.phone!);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'تم التعديل بنجاح',
          showConfirmBtn: false,
          borderRadius: 30,
          title: 'تم',
          autoCloseDuration: const Duration(seconds: 3),
        );
        getUserData(sendUid: model!.uId);
      });

      // Email update successful
    } else {
      print('error with changing please sing in agian');
      // Handle the case where the user is null
    }
  } on FirebaseAuthException catch (e) {
    print(e);
    if (e.code == 'email-already-in-use') {
      showSnackBar(
          context, 'لا يمكن التعديل عنوان البريد الإلكتروني مستخدم بالفعل ');
    } else if (e.code == 'network-request-failed') {
      showSnackBar(context, 'لا يوجد اتصال بالانترنت');
    }
  } catch (e) {
    // Handle any errors that occur during authentication or email update
    print('Error updating email: $e');
  }
}

Future<int> getLatestOrderId(String userId) async {
  try {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('orderId', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data()['orderId'] + 1;
    } else {
      return 1;
    }
  } catch (e) {
    print(e);
    return 1;
  }
}

Future<void> createUserOrders(
  BuildContext context, {
  required String clientName,
  required String clientPhone,
  required String productName,
  required String piceNumber,
  required int price,
  required int shipingPrice,
  required String? governorate,
  required String region,
  required String streetName,
  required String bulidingNumber,
  required String levelNumber,
  required String flatNumber,
  required String comments,
  required DateTime date,
  required String time,
  required bool isPanding,
  required bool isShipped,
}) async {
  const int maxAttempts = 3; // adjust the number of attempts as needed
  const int initialDelay = 500; // initial delay in milliseconds
  int attempt = 0;
  int delay = initialDelay;

  while (attempt < maxAttempts) {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        String oId = FirebaseFirestore.instance
            .collection('users')
            .doc(model!.uId)
            .collection('orders')
            .doc()
            .id;

        int orderId = await getLatestOrderId(model!.uId!);
        OrderModel orderModel = OrderModel(
            orderId: orderId,
            clientName: clientName.trim(),
            clientPhone: clientPhone.trim(),
            productName: productName.trim(),
            picesNumber: piceNumber.trim(),
            oId: oId,
            price: price,
            shipingPrice: shipingPrice,
            governorate: governorate,
            region: region.trim(),
            streetName: streetName.trim(),
            bulidingNumber: bulidingNumber.trim(),
            levelNumber: levelNumber.trim(),
            flatNumber: flatNumber.trim(),
            comments: comments.trim(),
            isPanding: isPanding,
            isShipped: isShipped,
            date: date,
            time: time);

        transaction.set(
            FirebaseFirestore.instance
                .collection('users')
                .doc(model!.uId)
                .collection('orders')
                .doc(oId),
            orderModel.toJson());
      });
      break; // if the transaction is successful, exit the loop
    } catch (e) {
      if (e is FirebaseException && e.code == 'unavailable') {
        // if the error is "unavailable", retry with backoff
        print('Error: ${e.message}. Retrying in $delay ms...');
        await Future.delayed(Duration(milliseconds: delay));
        delay *= 2; // exponential backoff
        attempt++;
      } else {
        // if the error is not "unavailable", rethrow the error
        rethrow;
      }
    }
  }
  if (attempt >= maxAttempts) {
    // if all attempts fail, throw an error
    throw Exception('Failed to create order after $maxAttempts attempts');
  }
}

void deleteOrder(context, index,
    {List? listorders,
    String? oId,
    int? orderId,
    void Function()? refresh}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('orders')
        .doc(oId)
        .delete()
        .then((value) {
      Navigator.pop(context);
      listorders!.removeAt(index);
      refresh!();
    });

    print('Order deleted with ID: ');
  } catch (e) {
    print(e);
  }
}

updateOrderState({
  required String brandName,
  required String email,
  required String phone,
  required String uIdOrderUp,
}) {
  OrderModel orderModel = OrderModel();

  FirebaseFirestore.instance
      .collection('users')
      .doc(uIdOrderUp)
      .collection('orders')
      .doc()
      .update(orderModel.toJson())
      .then((value) {
    print('success the value was updated ');
  }).catchError((onError) {
    print("error is ${onError}");
  });
}
