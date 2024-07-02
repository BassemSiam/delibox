import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delibox/Screens/HomeAndUserInfo/Home_screen.dart';
import 'package:delibox/Screens/User%20Login&Register/Login_screen.dart';
import 'package:delibox/components/components.dart';
import 'package:delibox/components/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../components/cash_helper.dart';
import '../../generated/l10n.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var userController = TextEditingController();
  var brandNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  bool isLoading = false;
  bool isHide = true;

  String userDirection = '';
  String brandDirection = '';
  String phoneDirection = '';
  String emailDirection = '';
  String passDirection = '';

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: GestureDetector(
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
                      height: (MediaQuery.sizeOf(context).height / 3) - 30,
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
                                    S.of(context).create_account,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    S.of(context).words_rigster,
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
                              (MediaQuery.sizeOf(context).height / 3) * 2 + 100,
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
                                    height: 20.h,
                                  ),
                                  Image(
                                    image: const AssetImage(
                                        'assets/images/car_image.png'),
                                    width: (MediaQuery.sizeOf(context).width /
                                        1.8),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TextFormField(
                                      textDirection: TextDirection.ltr,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.person,
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
                                          S.of(context).user_name,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S.of(context).user_validator;
                                        }
                                        return null;
                                      },
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: userController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TextFormField(
                                      textDirection: TextDirection.ltr,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.branding_watermark_outlined,
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
                                          S.of(context).brand_name,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S.of(context).brand_validator;
                                        }
                                        return null;
                                      },
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: brandNameController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TextFormField(
                                      textDirection: TextDirection.ltr,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s'))
                                      ],
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.phone,
                                          size: 22.sp,
                                        ),
                                        alignLabelWithHint: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 2,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                        ),
                                        label: Text(
                                          S.of(context).phone_number,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                        ),
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true, signed: true),
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: phoneController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TextFormField(
                                      textDirection: TextDirection.ltr,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s'))
                                      ],
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.email_rounded,
                                          size: 22.sp,
                                        ),
                                        alignLabelWithHint: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 2,
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
                                          textDirection: TextDirection.rtl,
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
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    child: TextFormField(
                                      textDirection: TextDirection.ltr,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'\s'))
                                      ],
                                      obscureText: isHide,
                                      onFieldSubmitted: (value) async {
                                        if (formKey.currentState!.validate()) {
                                          isLoading = true;
                                          setState(() {});
                                          try {
                                            await createUserUsingEmailAndPassword(
                                              email: emailController.text,
                                              userName: userController.text,
                                              brandName:
                                                  brandNameController.text,
                                              phone: phoneController.text,
                                              password: passController.text,
                                            ).then((value) {
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
                                            if (e.code ==
                                                'email-already-in-use') {
                                              showSnackBar(
                                                  context,
                                                  S
                                                      .of(context)
                                                      .email_already_in_use);
                                            } else if (e.code ==
                                                'weak-password') {
                                              showSnackBar(context,
                                                  S.of(context).weak_password);
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
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                        ),
                                        label: Text(
                                          S.of(context).password,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: passController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  CustomButton(
                                    onClick: () async {
                                      if (formKey.currentState!.validate()) {
                                        isLoading = true;
                                        setState(() {});
                                        try {
                                          await createUserUsingEmailAndPassword(
                                            email: emailController.text,
                                            userName: userController.text,
                                            brandName: brandNameController.text,
                                            phone: phoneController.text,
                                            password: passController.text,
                                          ).then((value) {
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
                                          if (e.code ==
                                              'email-already-in-use') {
                                            showSnackBar(
                                                context,
                                                S
                                                    .of(context)
                                                    .email_already_in_use);
                                          } else if (e.code ==
                                              'weak-password') {
                                            showSnackBar(context,
                                                S.of(context).weak_password);
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
                                    buttonText: S.of(context).rigister,
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
                                        S.of(context).thare_are_account,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          navigatorTo(
                                              context, const LoginScreen());
                                        },
                                        child: Text(
                                          S.of(context).signin,
                                          style: const TextStyle(
                                            color: blueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
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

  Future<void> createUserUsingEmailAndPassword({
    required String userName,
    required String brandName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      // User created successfully
      User? user = userCredential.user;
      print(user!.email);
      print(user.uid);
      // Save additional user data (name and phone) to Firestore
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users.doc(user.uid).set({
        'email': email.trim(),
        'userName': userName.trim(),
        'brandName': brandName.trim(),
        'phone': phone.trim(),
        'password': password.trim(),
        'uId': user.uid,
      }).then((value) {
        CacheHelper.saveData(key: 'uId', value: user.uid).then((value) {
          getUserData(sendUid: user.uid);
        }).catchError((error) {
          print(error.toString());
        });
      }).catchError((e) {});
    } catch (error) {
      rethrow;
    }
  }
}
