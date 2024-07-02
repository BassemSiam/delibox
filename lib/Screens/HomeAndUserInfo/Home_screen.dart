import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delibox/Screens/BottomNavigationScreens/Calculation.dart';
import 'package:delibox/Screens/BottomNavigationScreens/New_order_screen.dart';
import 'package:delibox/Screens/HomeAndUserInfo/user_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:delibox/components/components.dart';
import 'package:delibox/components/const.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../BottomNavigationScreens/SearchSreen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? email;

  HomeScreen({super.key, String this.email = ''});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomNavigationBarItem _currentItem = BottomNavigationBarItem.newOrder;

  List<Widget> get _bottomNavigationScreens => [
        const NewOrderScreen(),
        const CalculationScreen(),
      ];

  String get _title {
    switch (_currentItem) {
      case BottomNavigationBarItem.newOrder:
        return S.of(context).New_orders;
      case BottomNavigationBarItem.calculation:
        return S.of(context).accounting;
      default:
        throw Exception('Unknown bottom navigation item');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _bottomNavigationScreens[_currentItem.index],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        _title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Amiri',
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            left: isArabic() ? 12 : 0,
            right: isArabic() ? 0 : 12,
          ),
          child: _buildUserAvatar(),
        ),
      ],
      leading: Padding(
        padding: EdgeInsets.only(
          right: isArabic() ? 12 : 0,
          left: isArabic() ? 0 : 12,
        ),
        child: _buildSearchButton(),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return IconButton(
      onPressed: () {
        navigatorTo(context, const UserScreen());
      },
      icon: Icon(
        Icons.person,
        size: 28.sp,
        color: blueColor,
      ),
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      onPressed: () {
        navigatorTo(context, const SearchScreen());
      },
      icon: Icon(
        Icons.search,
        size: 28.sp,
        color: blueColor,
      ),
    );
  }

  CurvedNavigationBar _buildBottomNavigationBar() {
    return CurvedNavigationBar(
      color: Colors.grey.shade400,
      backgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 500),
      height: 48.h,
      onTap: (index) {
        setState(() {
          _currentItem = BottomNavigationBarItem.values[index];
        });
      },
      items: [
        FaIcon(FontAwesomeIcons.truckFast, size: 22.sp, color: blueColor),
        FaIcon(FontAwesomeIcons.wallet, size: 22.sp, color: blueColor),
      ],
    );
  }
}

enum BottomNavigationBarItem { newOrder, calculation }
