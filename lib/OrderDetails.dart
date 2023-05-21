import 'dart:typed_data';

class OrderDetails {
  final String fullName;
  final String totalAmount;
  final String userAddress;
  final String userEmail;
  final String userMobile;
  final String quantity;
  String status;
  final String type;
  final String orderTrackingId;
  //final String frontEndBase64;
  final Uint8List? frontEndBase64;
  final String title;
  final String originalPirce;
  final String description;

  OrderDetails({
    required this.fullName,
    required this.totalAmount,
    required this.userAddress,
    required this.userEmail,
    required this.userMobile,
    required this.quantity,
    required this.status,
    required this.type,
    required this.orderTrackingId,
    required this.frontEndBase64,
    required this.title,
    required this.originalPirce,
    required this.description,
  });
}
