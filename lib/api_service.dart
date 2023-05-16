import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sessionStorage.dart';
import 'package:salonemployee/constants.dart';

class ApiService {
  static Future<String> loginValidate(String username) async {
    final String url = employeeLoginValidate;
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {'phoneNo': username};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    final String status = responseBody['status'];
    final String firstName = responseBody['firstName'] ?? '';
    final String lastName = responseBody['lastName'] ?? '';
    final String fullName = (firstName.isNotEmpty && lastName.isNotEmpty)
        ? '$firstName $lastName'
        : '';
    final String mobileNo = responseBody['phoneNo'] ?? '';
    final String emailId = responseBody['emailId'] ?? '';
    final String gender = responseBody['gender'] ?? '';
    if (status == 'SUCCESS') {
      storeSessionData('fullName', fullName);
      storeSessionData('mobileNo', mobileNo);
      storeSessionData('emailId', emailId);
      storeSessionData('gender', gender);
      return status;
    } else {
      return status;
    }
  }

  static Future<String> getOrderCompleteCount() async {
    final String url = getOrderCompleteCountUrl;
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    final String status = responseBody['status'];
    final String count = responseBody['data'];
    if (status == 'SUCCESS') {
      return count;
    } else {
      return '';
    }
  }

  static Future<String> getOrderPendingCount() async {
    final String url = getOrderPendingCountUrl;
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    final String status = responseBody['status'];
    final String count = responseBody['data'];
    if (status == 'SUCCESS') {
      return count;
    } else {
      return '';
    }
  }
}
