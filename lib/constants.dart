import 'package:flutter/material.dart';

const String localUrl = 'http://localhost:8080/';
const String prodUrl = 'http://103.163.204.206:8080/';

const String title = 'HeyKudi Employee Portal';
const String loginTitle = 'Employee Login';
const String mobileNolabel = 'Mobile No';
const String signIn = 'Sign in';
const String login = 'Login';
const String dontHaveAccount = 'Does not have account? Contact Admin!';

//Production Server
final String employeeLoginValidate = prodUrl + 'salonApp/employeeLoginValidate';

final String getOrderCompleteCountUrl =
    prodUrl + 'salonApp/getOrderCompleteCount';

final String getOrderPendingCountUrl =
    prodUrl + 'salonApp/getOrderPendingCount';

final String getPendingOrdersForEmployeeUrl =
    prodUrl + 'salonApp/getPendingOrdersForEmployee';

final String getCompletedOrdersForEmployeeUrl =
    prodUrl + 'salonApp/getCompletedOrdersForEmployee';

final String getOrderDetailsDataUrl = prodUrl + 'salonApp/getOrderDetailsData';

final String changeStatusUrl = prodUrl + 'salonApp/changeStatus';
