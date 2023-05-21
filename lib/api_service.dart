import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:salonemployee/Order.dart';
import 'package:salonemployee/OrderDetails.dart';
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
    //print(responseBody);
    final String status = responseBody['status'];
    final String firstName = responseBody['data']['firstName'] ?? '';
    final String lastName = responseBody['data']['lastName'] ?? '';
    final String fullName = (firstName.isNotEmpty && lastName.isNotEmpty)
        ? '$firstName $lastName'
        : '';
    final String mobileNo = responseBody['data']['phoneNo'] ?? '';
    final String emailId = responseBody['data']['emailId'] ?? '';
    final String gender = responseBody['data']['gender'] ?? '';
    if (status == 'SUCCESS') {
      await storeSessionData('fullName', fullName);
      await storeSessionData('mobileNo', mobileNo);
      await storeSessionData('emailId', emailId);
      await storeSessionData('gender', gender);
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

  static Future<List<Order>> getPendingOrdersForEmployee(
      String mobileNumber) async {
    //print(mobileNumber);
    final String url =
        getPendingOrdersForEmployeeUrl + '?mobileNumber=$mobileNumber';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url), headers: headers);
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    final String status = responseBody['status'];

    if (status == 'SUCCESS') {
      final List<dynamic> orderData = responseBody['data'];
      final List<Order> orders = orderData.map((data) {
        return Order(
          id: data['id'],
          totalAmount: double.parse(data['totalAmount'] ?? ''),
          orderTrackingId: data['orderTrackingId'] ?? '',
          status: data['status'] ?? '',
          fullName: data['fullName'] ?? '',
        );
      }).toList();
      return orders;
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  static Future<OrderDetails> getOrderDetailsData(String orderId) async {
    final String url = getOrderDetailsDataUrl + '?orderId=$orderId';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url), headers: headers);
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    //print(responseBody);
    final String status = responseBody['status'];

    if (status == 'SUCCESS') {
      final dynamic orderData = responseBody['data'];
      final dynamic frontEndBase64 = orderData['frontEndBase64'];
      Uint8List? imageData;
      if (frontEndBase64 != null) {
        imageData = base64Decode(frontEndBase64);
      }
      final OrderDetails order = OrderDetails(
        fullName: orderData['fullName'] ?? '',
        totalAmount: orderData['totalAmount'] ?? '',
        userAddress: orderData['userAddress'] ?? '',
        userEmail: orderData['userEmail'] ?? '',
        userMobile: orderData['userMobile'] ?? '',
        quantity: orderData['quantity'] ?? '',
        status: orderData['status'] ?? '',
        type: orderData['type'] ?? '',
        orderTrackingId: orderData['orderTrackingId'] ?? '',
        frontEndBase64: imageData,
        title: orderData['title'] ?? '',
        originalPirce: orderData['originalPirce'] ?? '',
        description: orderData['description'] ?? '',
      );
      return order;
    } else {
      throw Exception('Failed to fetch order');
    }
  }

  static Future<void> updateOrderStatus(String orderId) async {
    try {
      // Make the API request to update the order status
      final String url = changeStatusUrl + '?orderId=$orderId';
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.post(Uri.parse(url), headers: headers);

      // Check the response status code
      if (response.statusCode == 200) {
        // Order status updated successfully
        // You can handle the response data if needed
      } else {
        // Request failed, handle the error
        throw Exception('Failed to update order status');
      }
    } catch (error) {
      // Handle any exceptions or network errors
      throw Exception('Error updating order status: $error');
    }
  }

  static Future<List<Order>> getCompletedOrdersForEmployee(
      String mobileNumber) async {
    //print(mobileNumber);
    final String url =
        getCompletedOrdersForEmployeeUrl + '?mobileNumber=$mobileNumber';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url), headers: headers);
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    final String status = responseBody['status'];

    if (status == 'SUCCESS') {
      final List<dynamic> orderData = responseBody['data'];
      //print(orderData);
      final List<Order> orders = orderData.map((data) {
        return Order(
          id: data['id'],
          totalAmount: double.parse(data['totalAmount'] ?? ''),
          orderTrackingId: data['orderTrackingId'] ?? '',
          status: data['status'] ?? '',
          fullName: data['fullName'] ?? '',
        );
      }).toList();
      return orders;
    } else {
      throw Exception('Failed to fetch orders');
    }
  }
}
