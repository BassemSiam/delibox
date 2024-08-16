import 'package:delibox/components/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/cash_helper.dart';
import '../../components/components.dart';
import '../../generated/l10n.dart';
import '../User Login&Register/Login_screen.dart';
import 'package:basic_utils/basic_utils.dart';
import 'Settings_Screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var loginform = GlobalKey<FormState>();

  bool brandClicked = false;
  bool emailClicked = false;
  bool phoneClicked = false;

  var brandNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  String emailDirection = '';
  String brandDirection = '';

  @override
  void initState() {
    super.initState();

    brandNameController.text =
        StringUtils.capitalize(model!.brandName.toString());
    emailController.text = StringUtils.capitalize(model!.email.toString());
    phoneController.text = model!.phone.toString();

    getUserData(sendUid: model!.uId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          brandClicked = false;
          emailClicked = false;
          phoneClicked = false;

          brandNameController.text =
              StringUtils.capitalize(model!.brandName.toString());
          emailController.text =
              StringUtils.capitalize(model!.email.toString());
          phoneController.text = model!.phone.toString();
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.amberAccent,
        //   iconTheme: const IconThemeData(
        //     color: Colors.white,
        //   ),
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [yellowColor, blueColor],
        //         begin: Alignment.topRight,
        //         end: Alignment.bottomLeft,
        //       ),
        //     ),
        //   ),
        //   elevation: 0,
        //   actions: [
        //     TextButton(
        //       onPressed: () {},
        //       child: IconButton(
        //         onPressed: () {
        //           navigatorTo(
        //             context,
        //             const SettingScreen(),
        //           );
        //         },
        //         icon: FaIcon(
        //           FontAwesomeIcons.gear,
        //           color: Colors.white,
        //           size: 20.sp,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body: LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: IntrinsicHeight(
              child: Form(
                key: loginform,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height / 2.5,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [yellowColor, blueColor],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 26.sp,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  navigatorTo(
                                    context,
                                    const SettingScreen(),
                                  );
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 26.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height / 4.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(
                                      child: Text(
                                        model!.userName
                                            .toString()
                                            .toUpperCase()
                                            .trim(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 120.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                              (MediaQuery.sizeOf(context).height / 4) * 2 + 190,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70.sp),
                              topRight: Radius.circular(70.sp),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.sp),
                                      height: 35.h,
                                      child: TextFormField(
                                        textDirection: TextDirection.ltr,
                                        controller: brandNameController,
                                        enabled: brandClicked,
                                        decoration: InputDecoration(
                                          filled: brandClicked ? false : true,
                                          fillColor: Colors.grey[100],
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1)),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 2),
                                            gapPadding: 10,
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 1),
                                            gapPadding: 8,
                                          ),
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.center,
                                          label: Text(
                                            S.of(context).brand_name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 2),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return S
                                                .of(context)
                                                .brand_validator;
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) {
                                          if (loginform.currentState!
                                              .validate()) {
                                            setState(() {
                                              brandClicked = !brandClicked;
                                            });
                                            if (!brandClicked) {
                                              updateUserData(
                                                  brandName:
                                                      brandNameController.text,
                                                  email: emailController.text,
                                                  phone: phoneController.text);
                                              doneAlert(
                                                context,
                                                text: S
                                                    .of(context)
                                                    .Edit_successfully,
                                              );
                                              getUserData(sendUid: model!.uId);

                                              setState(() {
                                                brandClicked = brandClicked;
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        height: 35.h,
                                        child: IconButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                              Colors.grey[200],
                                            ),
                                          ),
                                          onPressed: () {
                                            if (loginform.currentState!
                                                .validate()) {
                                              setState(() {
                                                brandClicked = !brandClicked;
                                              });
                                              if (!brandClicked) {
                                                updateUserData(
                                                    brandName:
                                                        brandNameController
                                                            .text,
                                                    email: emailController.text,
                                                    phone:
                                                        phoneController.text);
                                                doneAlert(
                                                  context,
                                                  text: S
                                                      .of(context)
                                                      .Edit_successfully,
                                                );
                                                getUserData(
                                                    sendUid: model!.uId);

                                                setState(() {
                                                  brandClicked = brandClicked;
                                                });
                                              }
                                            }
                                          },
                                          icon: brandClicked
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 20.sp,
                                                )
                                              : Icon(
                                                  Icons.edit,
                                                  color: blueColor,
                                                  size: 20.sp,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.sp),
                                      height: 35.h,
                                      child: TextFormField(
                                        textDirection: TextDirection.ltr,
                                        controller: emailController,
                                        enabled: emailClicked,
                                        decoration: InputDecoration(
                                            filled: emailClicked ? false : true,
                                            fillColor: Colors.grey[100],
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1)),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 2),
                                              gapPadding: 10,
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 1),
                                              gapPadding: 10,
                                            ),
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.center,
                                            label: Text(
                                              S.of(context).email,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            )),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp),
                                        validator: (value) {
                                          final RegExp regex = RegExp(
                                              r'^[\w-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,4}$');
                                          if (value!.isEmpty) {
                                            return S
                                                .of(context)
                                                .email_validator;
                                          } else if (!regex.hasMatch(value)) {
                                            return S
                                                .of(context)
                                                .email_fasle_validator;
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) {
                                          if (loginform.currentState!
                                              .validate()) {
                                            setState(() {});
                                            emailClicked = !emailClicked;
                                            if (!emailClicked) {
                                              updateEmail(emailController.text,
                                                  model!.password!, context);

                                              setState(() {
                                                emailClicked = emailClicked;
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        height: 35.h,
                                        child: IconButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.grey[200])),
                                          onPressed: () {
                                            if (loginform.currentState!
                                                .validate()) {
                                              setState(() {});
                                              emailClicked = !emailClicked;
                                              if (!emailClicked) {
                                                updateEmail(
                                                    emailController.text,
                                                    model!.password!,
                                                    context);

                                                setState(() {
                                                  emailClicked = emailClicked;
                                                });
                                              }
                                            }
                                          },
                                          icon: emailClicked
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 20.sp,
                                                )
                                              : Icon(
                                                  Icons.edit,
                                                  color: blueColor,
                                                  size: 20.sp,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.sp),
                                      height: 35.h,
                                      child: TextFormField(
                                        textDirection: TextDirection.ltr,
                                        controller: phoneController,
                                        enabled: phoneClicked,
                                        decoration: InputDecoration(
                                            filled: phoneClicked ? false : true,
                                            fillColor: Colors.grey[100],
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1)),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 2),
                                              gapPadding: 10,
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: const BorderSide(
                                                  color: Colors.grey, width: 1),
                                              gapPadding: 10,
                                            ),
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.center,
                                            label: Text(
                                              S.of(context).phone_number,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            )),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                            decimal: true, signed: true),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        ),
                                        validator: (value) {
                                          final RegExp regex = RegExp(
                                              r'^01[0|1|2|5]{1}[0-9]{8}$');
                                          if (value!.isEmpty) {
                                            return S
                                                .of(context)
                                                .phone_validator;
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
                                        onFieldSubmitted: (value) {
                                          if (loginform.currentState!
                                              .validate()) {
                                            setState(() {});
                                            phoneClicked = !phoneClicked;
                                            if (!phoneClicked) {
                                              updateUserData(
                                                  brandName:
                                                      brandNameController.text,
                                                  email: emailController.text,
                                                  phone: phoneController.text);
                                              getUserData(sendUid: model!.uId);
                                              doneAlert(
                                                context,
                                                text: S
                                                    .of(context)
                                                    .Edit_successfully,
                                              );
                                              phoneClicked = phoneClicked;
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        height: 35.h,
                                        child: IconButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.grey[200])),
                                          onPressed: () {
                                            if (loginform.currentState!
                                                .validate()) {
                                              setState(() {});
                                              phoneClicked = !phoneClicked;
                                              if (!phoneClicked) {
                                                updateUserData(
                                                    brandName:
                                                        brandNameController
                                                            .text,
                                                    email: emailController.text,
                                                    phone:
                                                        phoneController.text);
                                                getUserData(
                                                    sendUid: model!.uId);
                                                doneAlert(
                                                  context,
                                                  text: S
                                                      .of(context)
                                                      .Edit_successfully,
                                                );
                                                phoneClicked = phoneClicked;
                                              }
                                            }
                                          },
                                          icon: phoneClicked
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 20.sp,
                                                )
                                              : Icon(
                                                  Icons.edit,
                                                  color: blueColor,
                                                  size: 20.sp,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    showAlert(context,
                                        continueButtonText:
                                            S.of(context).logout,
                                        title: S.of(context).log_out,
                                        content:
                                            S.of(context).do_you_want_to_logout,
                                        onContinue: () async {
                                      await FirebaseAuth.instance.signOut();
                                      CacheHelper.removeData(key: 'uId');
                                      CacheHelper.removeData(key: 'loggedIn');
                                      navigateAndFinish(
                                          context, const LoginScreen());
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 150.w,
                                      padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 20,
                                          right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
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
                                        child: Text(S.of(context).logout,
                                            style: TextStyle(
                                                fontFamily: 'Amiri',
                                                fontSize: 18.sp,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: (MediaQuery.sizeOf(context).height / 6) * 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.black26,
                                  radius: 41.5.sp,
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40.sp,
                                  child: Text(
                                    model!.userName
                                        .toString()
                                        .toUpperCase()
                                        .substring(0, 1),
                                    style: TextStyle(
                                        color: blueColor,
                                        fontSize: 60.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
