import 'package:delibox/Screens/Admin/Show_users_screen.dart';
import 'package:delibox/Screens/HomeAndUserInfo/Home_screen.dart';
import 'package:delibox/Screens/User%20Login&Register/Register_Screen.dart';
import 'package:delibox/components/cash_helper.dart';
import 'package:delibox/components/components.dart';
import 'package:delibox/components/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  bool isLoading = false;
  bool isHide = true;
  String directionEmail = '';
  String directionPass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        blur: 10,
        progressIndicator: loadingCar(),
        inAsyncCall: isLoading,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: (MediaQuery.sizeOf(context).height / 3) - 10,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [yellowColor, blueColor],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 20,
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).login,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    S.of(context).words_login,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.sp),
                                  ),
                                  SizedBox(
                                    height: 70.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          height:
                              (MediaQuery.sizeOf(context).height / 3) * 2 + 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70.sp),
                              topRight: Radius.circular(70.sp),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Image(
                                    image: const AssetImage(
                                        'assets/images/car-removelogooo.png'),
                                    width: (MediaQuery.sizeOf(context).width /
                                        1.5),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TextFormField(
                                      textDirection: TextDirection.ltr,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.email_rounded,
                                          size: 22.sp,
                                        ),
                                        alignLabelWithHint: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.w,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                        ),
                                        label: Text(
                                          S.of(context).email,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        final RegExp regex = RegExp(
                                            r'^[\w-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,4}$');
                                        if (value!.isEmpty) {
                                          return S.of(context).email_validator;
                                        } else if (!regex.hasMatch(value)) {
                                          return S
                                              .of(context)
                                              .email_fasle_validator;
                                        }
                                        return null;
                                      },
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: emailController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TextFormField(
                                      textDirection: TextDirection.ltr,
                                      obscureText: isHide,
                                      onFieldSubmitted: (value) async {
                                        if (emailController.text ==
                                                'deliboxadmin@delibox.com' &&
                                            passController.text ==
                                                'deliboxadmin123123') {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          CacheHelper.saveData(
                                              key: 'uId',
                                              value:
                                                  'mOTL1blgW3coJCCI2hCWmKD4mjX2');
                                          navigateAndFinish(
                                              context, const ShowUsersScreen());
                                          setState(() {
                                            isLoading = false;
                                          });
                                          CacheHelper.saveData(
                                              key: 'loggedIn', value: true);
                                        } else if (formKey.currentState!
                                            .validate()) {
                                          isLoading = true;
                                          setState(() {});
                                          try {
                                            await signInUsingEmailAndPAssword()
                                                .then((value) {
                                              CacheHelper.saveData(
                                                      key: 'loggedIn',
                                                      value: true)
                                                  .then((value) {
                                                if (value) {
                                                  navigateAndFinish(
                                                      context, HomeScreen());
                                                }
                                              });
                                            });
                                          } on FirebaseAuthException catch (e) {
                                            print(e);
                                            if (e.code == 'user-not-found') {
                                              showSnackBar(context,
                                                  S.of(context).user_not_found);
                                            } else if (e.code ==
                                                'wrong-password') {
                                              showSnackBar(context,
                                                  S.of(context).wrong_password);
                                            } else if (e.code ==
                                                'too-many-requests') {
                                              showSnackBar(
                                                  context,
                                                  S
                                                      .of(context)
                                                      .too_many_requests);
                                            } else if (e.code ==
                                                'network-request-failed') {
                                              showSnackBar(
                                                  context,
                                                  S
                                                      .of(context)
                                                      .network_request_failed);
                                            }
                                          }
                                          isLoading = false;
                                          setState(() {});
                                        }
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {});
                                              isHide = !isHide;
                                            },
                                            icon: !isHide
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    size: 22.sp,
                                                  )
                                                : Icon(
                                                    Icons.visibility,
                                                    size: 22.sp,
                                                  )),
                                        alignLabelWithHint: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2.sp, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                        ),
                                        label: Text(
                                          S.of(context).password,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S
                                              .of(context)
                                              .password_validator;
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: passController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  CustomButton(
                                    onClick: () async {
                                      if (emailController.text ==
                                              'deliboxadmin@delibox.com' &&
                                          passController.text ==
                                              'deliboxadmin123123') {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        CacheHelper.saveData(
                                            key: 'uId',
                                            value:
                                                'mOTL1blgW3coJCCI2hCWmKD4mjX2');
                                        navigateAndFinish(
                                            context, const ShowUsersScreen());
                                        setState(() {
                                          isLoading = false;
                                        });
                                        CacheHelper.saveData(
                                            key: 'loggedIn', value: true);
                                      } else if (formKey.currentState!
                                          .validate()) {
                                        isLoading = true;
                                        setState(() {});
                                        try {
                                          await signInUsingEmailAndPAssword()
                                              .then((value) {
                                            CacheHelper.saveData(
                                                    key: 'loggedIn',
                                                    value: true)
                                                .then((value) {
                                              if (value) {
                                                navigateAndFinish(
                                                    context, HomeScreen());
                                              }
                                            });
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          print(e);
                                          if (e.code == 'user-not-found') {
                                            showSnackBar(context,
                                                S.of(context).user_not_found);
                                          } else if (e.code ==
                                              'wrong-password') {
                                            showSnackBar(context,
                                                S.of(context).wrong_password);
                                          } else if (e.code ==
                                              'too-many-requests') {
                                            showSnackBar(
                                                context,
                                                S
                                                    .of(context)
                                                    .too_many_requests);
                                          } else if (e.code ==
                                              'network-request-failed') {
                                            showSnackBar(
                                                context,
                                                S
                                                    .of(context)
                                                    .network_request_failed);
                                          } else if (e.code == 'unknown') {
                                            print(
                                                'An internal error has occurred: ${e.message}');
                                            showSnackBar(
                                                context,
                                                S
                                                    .of(context)
                                                    .network_request_failed);
                                          }
                                        }
                                        isLoading = false;
                                        setState(() {});
                                      }
                                    },
                                    buttonText: S.of(context).login,
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Divider(
                                    endIndent: 20.sp,
                                    thickness: 1,
                                    indent: 20.sp,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).dont_are_account,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigatorTo(
                                              context, const RegisterScreen());
                                        },
                                        child: Text(
                                          S.of(context).rigister,
                                          style: const TextStyle(
                                            color: blueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUsingEmailAndPAssword() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text.trim());
    CacheHelper.saveData(key: 'uId', value: user.user!.uid).then((value) {
      getUserData(sendUid: user.user!.uid);
    }).catchError((onError) {
      print(onError.toString());
    });

    print(uId);
  }
}
