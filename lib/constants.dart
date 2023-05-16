import 'package:flutter/material.dart';

const String title = 'HeyKudi Employee Portal';
const String loginTitle = 'Employee Login';
const String mobileNolabel = 'Mobile No';
const String signIn = 'Sign in';
const String login = 'Login';
const String dontHaveAccount = 'Does not have account? Contact Admin!';

//localhost
//const String employeeLoginValidate =
//  'http://localhost:8080/employeeLoginValidate';

//const String getOrderCompleteCount =
//  'http://localhost:8080/getOrderCompleteCount';

//const String getOrderPendingCount =
//'http://localhost:8080/getOrderPendingCount';

//Production Server
final String employeeLoginValidate =
    'http://103.163.204.206:8080/salonApp/employeeLoginValidate';

final String getOrderCompleteCountUrl =
    'http://103.163.204.206:8080/salonApp/getOrderCompleteCount';

final String getOrderPendingCountUrl =
    'http://103.163.204.206:8080/salonApp/getOrderPendingCount';
