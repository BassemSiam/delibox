// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the data and create a new account`
  String get words_rigster {
    return Intl.message(
      'Fill in the data and create a new account',
      name: 'words_rigster',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get user_name {
    return Intl.message(
      'User Name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Brand Name`
  String get brand_name {
    return Intl.message(
      'Brand Name',
      name: 'brand_name',
      desc: '',
      args: [],
    );
  }

  /// `Pickup Address`
  String get pickup_Address {
    return Intl.message(
      'Pickup Address',
      name: 'pickup_Address',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get rigister {
    return Intl.message(
      'Register',
      name: 'rigister',
      desc: '',
      args: [],
    );
  }

  /// `Already have an Account?`
  String get thare_are_account {
    return Intl.message(
      'Already have an Account?',
      name: 'thare_are_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signin {
    return Intl.message(
      'Sign in',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the user name`
  String get user_validator {
    return Intl.message(
      'You must enter the user name',
      name: 'user_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the brand name`
  String get brand_validator {
    return Intl.message(
      'You must enter the brand name',
      name: 'brand_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the pickup Address`
  String get pickup_Address_validator {
    return Intl.message(
      'You must enter the pickup Address',
      name: 'pickup_Address_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the phone Number`
  String get phone_validator {
    return Intl.message(
      'You must enter the phone Number',
      name: 'phone_validator',
      desc: '',
      args: [],
    );
  }

  /// `The phone number must be 11 valid digits`
  String get phone_count_validator {
    return Intl.message(
      'The phone number must be 11 valid digits',
      name: 'phone_count_validator',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is incorrect`
  String get phone_fasle_validator {
    return Intl.message(
      'Phone number is incorrect',
      name: 'phone_fasle_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter an email`
  String get email_validator {
    return Intl.message(
      'You must enter an email',
      name: 'email_validator',
      desc: '',
      args: [],
    );
  }

  /// `This email is incorrect`
  String get email_fasle_validator {
    return Intl.message(
      'This email is incorrect',
      name: 'email_fasle_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the Password`
  String get password_validator {
    return Intl.message(
      'You must enter the Password',
      name: 'password_validator',
      desc: '',
      args: [],
    );
  }

  /// `The email address is already in use`
  String get email_already_in_use {
    return Intl.message(
      'The email address is already in use',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `The password must be at least 6 characters`
  String get weak_password {
    return Intl.message(
      'The password must be at least 6 characters',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `There is no internet connection`
  String get network_request_failed {
    return Intl.message(
      'There is no internet connection',
      name: 'network_request_failed',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the data to log in`
  String get words_login {
    return Intl.message(
      'Fill in the data to log in',
      name: 'words_login',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_are_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_are_account',
      desc: '',
      args: [],
    );
  }

  /// `User not found, try with another account`
  String get user_not_found {
    return Intl.message(
      'User not found, try with another account',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect`
  String get wrong_password {
    return Intl.message(
      'The password is incorrect',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Try Again later`
  String get too_many_requests {
    return Intl.message(
      'Try Again later',
      name: 'too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `New orders`
  String get New_orders {
    return Intl.message(
      'New orders',
      name: 'New_orders',
      desc: '',
      args: [],
    );
  }

  /// `Orders history`
  String get accounting {
    return Intl.message(
      'Orders history',
      name: 'accounting',
      desc: '',
      args: [],
    );
  }

  /// `Number of orders`
  String get count_orders {
    return Intl.message(
      'Number of orders',
      name: 'count_orders',
      desc: '',
      args: [],
    );
  }

  /// `Order number `
  String get order_number {
    return Intl.message(
      'Order number ',
      name: 'order_number',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete order number `
  String get ask_delete_orders {
    return Intl.message(
      'Do you want to delete order number ',
      name: 'ask_delete_orders',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete order `
  String get delete_order {
    return Intl.message(
      'Delete order ',
      name: 'delete_order',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name `
  String get customer_name {
    return Intl.message(
      'Customer Name ',
      name: 'customer_name',
      desc: '',
      args: [],
    );
  }

  /// `Customer Phone`
  String get customer_Phone {
    return Intl.message(
      'Customer Phone',
      name: 'customer_Phone',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Number of pieces`
  String get number_of_pieces {
    return Intl.message(
      'Number of pieces',
      name: 'number_of_pieces',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get the_address {
    return Intl.message(
      'Address',
      name: 'the_address',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get governorate {
    return Intl.message(
      'Governorate',
      name: 'governorate',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street_name {
    return Intl.message(
      'Street',
      name: 'street_name',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get building_number {
    return Intl.message(
      'Building',
      name: 'building_number',
      desc: '',
      args: [],
    );
  }

  /// `floor`
  String get floor_number {
    return Intl.message(
      'floor',
      name: 'floor_number',
      desc: '',
      args: [],
    );
  }

  /// `apartment`
  String get apartment_number {
    return Intl.message(
      'apartment',
      name: 'apartment_number',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get Notes {
    return Intl.message(
      'Notes',
      name: 'Notes',
      desc: '',
      args: [],
    );
  }

  /// `(shipping price ) `
  String get shipping_price {
    return Intl.message(
      '(shipping price ) ',
      name: 'shipping_price',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get total_amount {
    return Intl.message(
      'Total Price',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Order Code`
  String get order_code {
    return Intl.message(
      'Order Code',
      name: 'order_code',
      desc: '',
      args: [],
    );
  }

  /// `Shipped`
  String get is_shipped {
    return Intl.message(
      'Shipped',
      name: 'is_shipped',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Not_shipped {
    return Intl.message(
      'Cancel',
      name: 'Not_shipped',
      desc: '',
      args: [],
    );
  }

  /// `There are no Orders`
  String get no_orders {
    return Intl.message(
      'There are no Orders',
      name: 'no_orders',
      desc: '',
      args: [],
    );
  }

  /// `Click on '+' to add a new Orders`
  String get add_orders {
    return Intl.message(
      'Click on \'+\' to add a new Orders',
      name: 'add_orders',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the customer's name`
  String get add_customer_name {
    return Intl.message(
      'You must enter the customer\'s name',
      name: 'add_customer_name',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the product Name`
  String get productName_validator {
    return Intl.message(
      'You must enter the product Name',
      name: 'productName_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the number of pieces`
  String get numer_order_validator {
    return Intl.message(
      'You must enter the number of pieces',
      name: 'numer_order_validator',
      desc: '',
      args: [],
    );
  }

  /// ` (without shipping)`
  String get without_shipping {
    return Intl.message(
      ' (without shipping)',
      name: 'without_shipping',
      desc: '',
      args: [],
    );
  }

  /// `You must enter the price`
  String get price_order_validator {
    return Intl.message(
      'You must enter the price',
      name: 'price_order_validator',
      desc: '',
      args: [],
    );
  }

  /// `Detailed address`
  String get address_Detailed {
    return Intl.message(
      'Detailed address',
      name: 'address_Detailed',
      desc: '',
      args: [],
    );
  }

  /// `Choose Governorate `
  String get choose_governorate {
    return Intl.message(
      'Choose Governorate ',
      name: 'choose_governorate',
      desc: '',
      args: [],
    );
  }

  /// `you must Choose Governorate`
  String get choose_governorate_validator {
    return Intl.message(
      'you must Choose Governorate',
      name: 'choose_governorate_validator',
      desc: '',
      args: [],
    );
  }

  /// `Notes (optional)`
  String get comments_chose {
    return Intl.message(
      'Notes (optional)',
      name: 'comments_chose',
      desc: '',
      args: [],
    );
  }

  /// `A new Order has been added`
  String get new_requast_added {
    return Intl.message(
      'A new Order has been added',
      name: 'new_requast_added',
      desc: '',
      args: [],
    );
  }

  /// `Data error`
  String get data_error {
    return Intl.message(
      'Data error',
      name: 'data_error',
      desc: '',
      args: [],
    );
  }

  /// `Add Order`
  String get add_order {
    return Intl.message(
      'Add Order',
      name: 'add_order',
      desc: '',
      args: [],
    );
  }

  /// `You must enter a Region`
  String get region_validator {
    return Intl.message(
      'You must enter a Region',
      name: 'region_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter a Street Name`
  String get street_name_validator {
    return Intl.message(
      'You must enter a Street Name',
      name: 'street_name_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter building Number`
  String get building_validator {
    return Intl.message(
      'You must enter building Number',
      name: 'building_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must enter floor Number`
  String get flor_validator {
    return Intl.message(
      'You must enter floor Number',
      name: 'flor_validator',
      desc: '',
      args: [],
    );
  }

  /// `You must ente apartment Number`
  String get appartment_validator {
    return Intl.message(
      'You must ente apartment Number',
      name: 'appartment_validator',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get count {
    return Intl.message(
      'Number',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `There are no orders for the account now`
  String get no_accounting_now {
    return Intl.message(
      'There are no orders for the account now',
      name: 'no_accounting_now',
      desc: '',
      args: [],
    );
  }

  /// `Add New Orders`
  String get add_accountin_order {
    return Intl.message(
      'Add New Orders',
      name: 'add_accountin_order',
      desc: '',
      args: [],
    );
  }

  /// `Search by Name`
  String get search_by_name {
    return Intl.message(
      'Search by Name',
      name: 'search_by_name',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get there_are_no_data_found {
    return Intl.message(
      'No results found',
      name: 'there_are_no_data_found',
      desc: '',
      args: [],
    );
  }

  /// `Search by customer name to view order information`
  String get search_by_customer_name {
    return Intl.message(
      'Search by customer name to view order information',
      name: 'search_by_customer_name',
      desc: '',
      args: [],
    );
  }

  /// `pices`
  String get pices {
    return Intl.message(
      'pices',
      name: 'pices',
      desc: '',
      args: [],
    );
  }

  /// `L.E`
  String get pound {
    return Intl.message(
      'L.E',
      name: 'pound',
      desc: '',
      args: [],
    );
  }

  /// `In waiting`
  String get in_waiting {
    return Intl.message(
      'In waiting',
      name: 'in_waiting',
      desc: '',
      args: [],
    );
  }

  /// `Edit successfully`
  String get Edit_successfully {
    return Intl.message(
      'Edit successfully',
      name: 'Edit_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get log_out {
    return Intl.message(
      'Logout',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to Logout?`
  String get do_you_want_to_logout {
    return Intl.message(
      'Do you want to Logout?',
      name: 'do_you_want_to_logout',
      desc: '',
      args: [],
    );
  }

  /// `customers`
  String get customers {
    return Intl.message(
      'customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `brand`
  String get brand {
    return Intl.message(
      'brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `orders`
  String get orders {
    return Intl.message(
      'orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `order shipped`
  String get order_deliverd {
    return Intl.message(
      'order shipped',
      name: 'order_deliverd',
      desc: '',
      args: [],
    );
  }

  /// `Has the order been shipped?`
  String get do_the_order_delivered {
    return Intl.message(
      'Has the order been shipped?',
      name: 'do_the_order_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Order Cancel`
  String get order_cancel {
    return Intl.message(
      'Order Cancel',
      name: 'order_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Has the order been rejected?`
  String get do_the_order_cancel {
    return Intl.message(
      'Has the order been rejected?',
      name: 'do_the_order_cancel',
      desc: '',
      args: [],
    );
  }

  /// `The order code has been copied`
  String get code_copy {
    return Intl.message(
      'The order code has been copied',
      name: 'code_copy',
      desc: '',
      args: [],
    );
  }

  /// `filter by governorate to view order information`
  String get filter_by_governorate {
    return Intl.message(
      'filter by governorate to view order information',
      name: 'filter_by_governorate',
      desc: '',
      args: [],
    );
  }

  /// `add new order`
  String get add_new_order_t {
    return Intl.message(
      'add new order',
      name: 'add_new_order_t',
      desc: '',
      args: [],
    );
  }

  /// `to add new order click on '+' `
  String get add_new_order_b {
    return Intl.message(
      'to add new order click on \'+\' ',
      name: 'add_new_order_b',
      desc: '',
      args: [],
    );
  }

  /// `Add order`
  String get Add_order_t {
    return Intl.message(
      'Add order',
      name: 'Add_order_t',
      desc: '',
      args: [],
    );
  }

  /// `enter all information for the customer and the order`
  String get Add_order_b {
    return Intl.message(
      'enter all information for the customer and the order',
      name: 'Add_order_b',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get Orders_t {
    return Intl.message(
      'Orders',
      name: 'Orders_t',
      desc: '',
      args: [],
    );
  }

  /// `track all orders and status`
  String get Orders_b {
    return Intl.message(
      'track all orders and status',
      name: 'Orders_b',
      desc: '',
      args: [],
    );
  }

  /// `Orders Search `
  String get Orders_Search_t {
    return Intl.message(
      'Orders Search ',
      name: 'Orders_Search_t',
      desc: '',
      args: [],
    );
  }

  /// `you can search for orders by customer name to get all information for the order`
  String get Orders_Search_b {
    return Intl.message(
      'you can search for orders by customer name to get all information for the order',
      name: 'Orders_Search_b',
      desc: '',
      args: [],
    );
  }

  /// `Accounting`
  String get Accounting_t {
    return Intl.message(
      'Accounting',
      name: 'Accounting_t',
      desc: '',
      args: [],
    );
  }

  /// `Accounting for all you orders day by day`
  String get Accounting_b {
    return Intl.message(
      'Accounting for all you orders day by day',
      name: 'Accounting_b',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_t {
    return Intl.message(
      'Profile',
      name: 'profile_t',
      desc: '',
      args: [],
    );
  }

  /// `your profile and you can update brand name , email or phone of your infromation`
  String get profile_b {
    return Intl.message(
      'your profile and you can update brand name , email or phone of your infromation',
      name: 'profile_b',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us_t {
    return Intl.message(
      'Contact us',
      name: 'contact_us_t',
      desc: '',
      args: [],
    );
  }

  /// `you can change the langauge of the app and you can contact us anytime`
  String get contact_us_b {
    return Intl.message(
      'you can change the langauge of the app and you can contact us anytime',
      name: 'contact_us_b',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Select Language : `
  String get Select_Language {
    return Intl.message(
      'Select Language : ',
      name: 'Select_Language',
      desc: '',
      args: [],
    );
  }

  /// `There is a problem with the Internet , try again later`
  String get error_network {
    return Intl.message(
      'There is a problem with the Internet , try again later',
      name: 'error_network',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Price List`
  String get Price_List {
    return Intl.message(
      'Price List',
      name: 'Price_List',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account ?`
  String get confirm_delete_account {
    return Intl.message(
      'Are you sure you want to delete your account ?',
      name: 'confirm_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully delete your account`
  String get account_deleted_successfully {
    return Intl.message(
      'You have successfully delete your account',
      name: 'account_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `There are error try again`
  String get error_deleting_account {
    return Intl.message(
      'There are error try again',
      name: 'error_deleting_account',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
