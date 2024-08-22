import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:delibox/components/cash_helper.dart';
import 'package:delibox/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../generated/l10n.dart';
import '../main.dart';
import 'package:intl/intl.dart';
class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.buttonText, required this.onClick});

  final String? buttonText;
  final void Function()? onClick;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 35.sp,
      ),
      child: Container(
        height: 37.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.sp),
          gradient: const LinearGradient(
            colors: [yellowColor, blueColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: MaterialButton(
          onPressed: onClick,
          child: Text('$buttonText',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

void navigatorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

void showSnackBar(BuildContext context, String message) {
  AwesomeDialog dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: message,
      width: 350.w,
      titleTextStyle: TextStyle(fontSize: 14.sp));
  dialog.show();
  Timer(const Duration(seconds: 3), () {
    dialog.dismiss();
  });
}

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        webShowClose: false,
        fontSize: 20);

enum ToastStates { success, error, warning }

Color? chooseToastColor(ToastStates state) {
  // ignore: unused_local_variable
  Color color;
  if (state == ToastStates.success) {
    color = Colors.green;
  }
  if (state == ToastStates.error) {
    color = Colors.red;
  }
  if (state == ToastStates.warning) {
    color = Colors.amber;
  }
  return null;
}

showAlert(
  context, {
  required String continueButtonText,
  required String title,
  required String content,
  required void Function() onContinue,
}) {
  AwesomeDialog(
    showCloseIcon: true,
    descTextStyle: TextStyle(fontSize: 14.sp),
    titleTextStyle: TextStyle(fontSize: 16.sp),
    context: context,
    dialogType: DialogType.question,
    desc: content,
    title: title,
    btnOkText: continueButtonText,
    btnOkOnPress: onContinue,
    btnOkColor: Colors.black,
    width: 350.w,
    btnCancel: TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        S.of(context).No,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  ).show();
}

class TextFiledOrder extends StatefulWidget {
  const TextFiledOrder({
    Key? key,
    required this.controller,
    required this.text,
    this.icon,
    required this.keybordType,
    required this.validator,
    this.textDics = '',
    this.onChange,
    this.textDirection = '',
    this.isExpanded = false,
    this.enabled = true,
    this.maxline = 1,
    this.border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
  }) : super(key: key);

  final TextEditingController? controller;
  final Icon? icon;
  final TextInputType? keybordType;
  final String? Function(String?)? validator;
  final String? text;
  final String textDirection;
  final String textDics;
  final InputBorder border;
  final int? maxline;
  final bool isExpanded;
  final bool enabled;
  final void Function(String)? onChange;

  @override
  State<TextFiledOrder> createState() => _TextFiledOrderState();
}

class _TextFiledOrderState extends State<TextFiledOrder> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.text}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ' ${widget.textDics}',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Expanded(
            child: TextFormField(
              textAlign: getTextAlign(widget.controller!.text),
              enabled: widget.enabled,
              onChanged: widget.onChange,
              expands: widget.isExpanded,
              maxLines: null,
              controller: widget.controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                prefixIcon: widget.icon,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  gapPadding: 2,
                ),
                border: widget.border,
              ),
              keyboardType: widget.keybordType,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}

Widget loadingCar() => Center(
      child: SizedBox(
        height: 70.h,
        width: 70.w,
        child: Lottie.asset('assets/Animation/Animation - 1714053112413.json',
            fit: BoxFit.contain, repeat: true),
      ),
    );

doneAlert(
  context, {
  required String text,
}) {
  AwesomeDialog dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: text,
      width: 350.w,
      titleTextStyle: TextStyle(fontSize: 14.sp));
  dialog.show();
  Timer(const Duration(seconds: 5), () {
    dialog.dismiss();
  });
}

cancelAlert(
  context, {
  required String text,
}) {
  AwesomeDialog(
          titleTextStyle: TextStyle(fontSize: 14.sp),
          context: context,
          dialogType: DialogType.error,
          title: text,
          width: 350.w,
          showCloseIcon: true,
          btnOkOnPress: () => Navigator.pop,
          btnOkColor: Colors.black,
          btnOkText: S.of(context).ok)
      .show();
}

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/nointernet.jpg',
          ),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Please check your internet connection and try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red)),
            onPressed: () async {
              final Connectivity connectivity = Connectivity();
              connectivity.onConnectivityChanged
                  .listen((ConnectivityResult result) async {
                if (result == ConnectivityResult.none) {
                  // Show no internet connection message
                  runApp(const NoInternetApp());
                } else {
                  runApp(MyApp(
                    selectLan: await CacheHelper.getData(key: 'lang'),
                  ));
                }
              });
            },
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

// final pound = Currency.create('EGP', 2,
//     symbol: isArabic() ? 'ج.م' : '£E',
//     groupSeparator: ',',
//     decimalSeparator: '.',
//     pattern: '#,##0.00 S');


// showTimeAlertDone(context, {required String text}) {
//   Timer timer = Timer(const Duration(milliseconds: 1500), () {
//     Navigator.of(context, rootNavigator: true).pop();
//   });
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Column(
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Text(text,
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontFamily: 'Amiri',
//                 )),
//             const Icon(
//               Icons.check,
//               color: Colors.green,
//               size: 60,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//         backgroundColor: Colors.grey[200],
//       );
//     },
//   ).then((value) {
//     timer.cancel();
//     getUserData(sendUid: model!.uId);
//   });
// }

// showTimeAlertError(context, {required String text}) {
//   Timer timer = Timer(const Duration(milliseconds: 1500), () {
//     Navigator.of(context, rootNavigator: true).pop();
//   });
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Column(
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Text(text,
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontFamily: 'Amiri',
//                 )),
//             const Icon(
//               Icons.close,
//               color: Colors.red,
//               size: 60,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//         backgroundColor: Colors.grey[200],
//       );
//     },
//   ).then((value) {
//     timer.cancel();
//   });
// }
