import 'package:delibox/components/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../generated/l10n.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.brandName,
  });
  final String userId;
  final String userName;
  final String email;
  final String phone;
  final String brandName;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.userName.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      FaIcon(
                        FontAwesomeIcons.user,
                        color: Color(0xff387ADF),
                        size: 14.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.brandName,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      FaIcon(
                        FontAwesomeIcons.brandsFontAwesome,
                        color: Colors.blue,
                        size: 14.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.email,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Icon(
                        Icons.email,
                        color: Colors.red,
                        size: 14.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.phone,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      FaIcon(
                        FontAwesomeIcons.phone,
                        color: Colors.green,
                        size: 14.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          '${S.of(context).order_code} : ',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        Text(
                          widget.userId.substring(0, 15),
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
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
    );
  }
}
