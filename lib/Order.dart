class Order {
  final int id;
  final double totalAmount;
  final String orderTrackingId;
  final String status;
  final String fullName;

  Order({
    required this.id,
    required this.totalAmount,
    required this.orderTrackingId,
    required this.status,
    required this.fullName,
  });
}
