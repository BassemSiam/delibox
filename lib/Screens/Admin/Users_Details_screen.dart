import 'package:flutter/material.dart';
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.brandName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const FaIcon(
                        FontAwesomeIcons.brandsFontAwesome,
                        color: Color(0xff211951),
                        size: 17,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.email,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.email,
                        color: Color(0xff211951),
                        size: 17,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.phone,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const FaIcon(
                        FontAwesomeIcons.phone,
                        color: Color(0xff211951),
                        size: 17,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          '${S.of(context).order_code} : ',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        Text(
                          widget.userId.substring(0, 15),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
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
