import 'package:delibox/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [yellowColor, blueColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {},
              child: IconButton(
                onPressed: () {
                  navigatorTo(
                    context,
                    const SettingScreen(),
                  );
                },
                icon: FaIcon(
                  FontAwesomeIcons.gear,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: IntrinsicHeight(
                child: Form(
                  key: loginform,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: (MediaQuery.sizeOf(context).height / 4) - 10,
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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 1),
                                        child: Text(
                                          model!.userName
                                              .toString()
                                              .toUpperCase()
                                              .trim(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 120.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
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
                                (MediaQuery.sizeOf(context).height / 3) * 2 +
                                    130,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                topRight: Radius.circular(80),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 40.h,
                                              child: TextFormField(
                                                textDirection:
                                                    TextDirection.ltr,
                                                controller: brandNameController,
                                                enabled: brandClicked,
                                                decoration: InputDecoration(
                                                  filled: brandClicked
                                                      ? false
                                                      : true,
                                                  fillColor: Colors.grey[100],
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey,
                                                            width: 2),
                                                    gapPadding: 10,
                                                  ),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey,
                                                            width: 1),
                                                    gapPadding: 10,
                                                  ),
                                                  floatingLabelAlignment:
                                                      FloatingLabelAlignment
                                                          .center,
                                                  label: Text(
                                                    S.of(context).brand_name,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey,
                                                            width: 2),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                style: const TextStyle(
                                                    color: Colors.black),
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
                                                      brandClicked =
                                                          !brandClicked;
                                                    });
                                                    if (!brandClicked) {
                                                      updateUserData(
                                                          brandName:
                                                              brandNameController
                                                                  .text,
                                                          email: emailController
                                                              .text,
                                                          phone: phoneController
                                                              .text);
                                                      doneAlert(
                                                        context,
                                                        text: S
                                                            .of(context)
                                                            .Edit_successfully,
                                                      );
                                                      getUserData(
                                                          sendUid: model!.uId);

                                                      setState(() {
                                                        brandClicked =
                                                            brandClicked;
                                                      });
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: OutlinedButton(
                                                style: ButtonStyle(
                                                  fixedSize:
                                                      const WidgetStatePropertyAll(
                                                          Size(65, 45)),
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                    Colors.grey[200],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  if (loginform.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      brandClicked =
                                                          !brandClicked;
                                                    });
                                                    if (!brandClicked) {
                                                      updateUserData(
                                                          brandName:
                                                              brandNameController
                                                                  .text,
                                                          email: emailController
                                                              .text,
                                                          phone: phoneController
                                                              .text);
                                                      doneAlert(
                                                        context,
                                                        text: S
                                                            .of(context)
                                                            .Edit_successfully,
                                                      );
                                                      getUserData(
                                                          sendUid: model!.uId);

                                                      setState(() {
                                                        brandClicked =
                                                            brandClicked;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: brandClicked
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                        size: 18.sp,
                                                      )
                                                    : Icon(
                                                        Icons.edit,
                                                        color: blueColor,
                                                        size: 18.sp,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 80,
                                              width: 290,
                                              child: TextFormField(
                                                textDirection:
                                                    TextDirection.ltr,
                                                controller: emailController,
                                                enabled: emailClicked,
                                                decoration: InputDecoration(
                                                    filled: emailClicked
                                                        ? false
                                                        : true,
                                                    fillColor: Colors.grey[100],
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1)),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 2),
                                                      gapPadding: 10,
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                      gapPadding: 10,
                                                    ),
                                                    floatingLabelAlignment:
                                                        FloatingLabelAlignment
                                                            .center,
                                                    label: Text(
                                                      S.of(context).email,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.sp),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    )),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                validator: (value) {
                                                  final RegExp regex = RegExp(
                                                      r'^[\w-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,4}$');
                                                  if (value!.isEmpty) {
                                                    return S
                                                        .of(context)
                                                        .email_validator;
                                                  } else if (!regex
                                                      .hasMatch(value)) {
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
                                                    emailClicked =
                                                        !emailClicked;
                                                    if (!emailClicked) {
                                                      updateEmail(
                                                          emailController.text,
                                                          model!.password!,
                                                          context);

                                                      setState(() {
                                                        emailClicked =
                                                            emailClicked;
                                                      });
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: OutlinedButton(
                                                style: ButtonStyle(
                                                    fixedSize:
                                                        const WidgetStatePropertyAll(
                                                            Size(65, 45)),
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.grey[200])),
                                                onPressed: () {
                                                  if (loginform.currentState!
                                                      .validate()) {
                                                    setState(() {});
                                                    emailClicked =
                                                        !emailClicked;
                                                    if (!emailClicked) {
                                                      updateEmail(
                                                          emailController.text,
                                                          model!.password!,
                                                          context);

                                                      setState(() {
                                                        emailClicked =
                                                            emailClicked;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: emailClicked
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                        size: 18.sp,
                                                      )
                                                    : Icon(
                                                        Icons.edit,
                                                        color: blueColor,
                                                        size: 18.sp,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              height: 80,
                                              width: 290,
                                              child: TextFormField(
                                                textDirection:
                                                    TextDirection.ltr,
                                                controller: phoneController,
                                                enabled: phoneClicked,
                                                decoration: InputDecoration(
                                                    filled: phoneClicked
                                                        ? false
                                                        : true,
                                                    fillColor: Colors.grey[100],
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1)),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 2),
                                                      gapPadding: 10,
                                                    ),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                      gapPadding: 10,
                                                    ),
                                                    floatingLabelAlignment:
                                                        FloatingLabelAlignment
                                                            .center,
                                                    label: Text(
                                                      S
                                                          .of(context)
                                                          .phone_number,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.sp),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    )),
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                        decimal: true,
                                                        signed: true),
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                validator: (value) {
                                                  final RegExp regex = RegExp(
                                                      r'^01[0|1|2|5]{1}[0-9]{8}$');
                                                  if (value!.isEmpty) {
                                                    return S
                                                        .of(context)
                                                        .phone_validator;
                                                  } else if (value.length !=
                                                      11) {
                                                    return S
                                                        .of(context)
                                                        .phone_count_validator;
                                                  } else if (!regex
                                                      .hasMatch(value)) {
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
                                                    phoneClicked =
                                                        !phoneClicked;
                                                    if (!phoneClicked) {
                                                      updateUserData(
                                                          brandName:
                                                              brandNameController
                                                                  .text,
                                                          email: emailController
                                                              .text,
                                                          phone: phoneController
                                                              .text);
                                                      getUserData(
                                                          sendUid: model!.uId);
                                                      doneAlert(
                                                        context,
                                                        text: S
                                                            .of(context)
                                                            .Edit_successfully,
                                                      );
                                                      phoneClicked =
                                                          phoneClicked;
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: OutlinedButton(
                                                style: ButtonStyle(
                                                    fixedSize:
                                                        const WidgetStatePropertyAll(
                                                            Size(65, 45)),
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.grey[200])),
                                                onPressed: () {
                                                  if (loginform.currentState!
                                                      .validate()) {
                                                    setState(() {});
                                                    phoneClicked =
                                                        !phoneClicked;
                                                    if (!phoneClicked) {
                                                      updateUserData(
                                                          brandName:
                                                              brandNameController
                                                                  .text,
                                                          email: emailController
                                                              .text,
                                                          phone: phoneController
                                                              .text);
                                                      getUserData(
                                                          sendUid: model!.uId);
                                                      doneAlert(
                                                        context,
                                                        text: S
                                                            .of(context)
                                                            .Edit_successfully,
                                                      );
                                                      phoneClicked =
                                                          phoneClicked;
                                                    }
                                                  }
                                                },
                                                child: phoneClicked
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                        size: 18.sp,
                                                      )
                                                    : Icon(
                                                        Icons.edit,
                                                        color: blueColor,
                                                        size: 18.sp,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 90.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlert(context,
                                              continueButtonText:
                                                  S.of(context).logout,
                                              title: S.of(context).log_out,
                                              content: S
                                                  .of(context)
                                                  .do_you_want_to_logout,
                                              onContinue: () {
                                            CacheHelper.removeData(key: 'uId');

                                            CacheHelper.removeData(
                                                key: 'loggedIn');
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
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: (MediaQuery.sizeOf(context).height / 6) * 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Stack(
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
