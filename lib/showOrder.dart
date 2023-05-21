import 'package:flutter/material.dart';
import 'package:salonemployee/OrderDetails.dart';
import 'package:salonemployee/api_service.dart';
import 'MyDrawer.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_html/flutter_html.dart';

class ShowOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      drawer: MyDrawer(),
      body: MyStatefulWidget(orderId: orderId),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final String? orderId;

  const MyStatefulWidget({Key? key, required this.orderId}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isLoading = false;
  OrderDetails? orderDetails;
  @override
  void initState() {
    super.initState();
    final orderId = widget.orderId;
    if (orderId != null) {
      fetchOrders(orderId);
    }
  }

  Future<void> fetchOrders(String orderId) async {
    setState(() {
      isLoading = true;
    });
    final response = await ApiService.getOrderDetailsData(orderId);
    orderDetails = response;

    setState(() {
      isLoading = false;
    });
  }

  Future<void> statusUpdate(String orderId) async {
    setState(() {
      isLoading = true;
    });
    final response = await ApiService.updateOrderStatus(orderId);

    setState(() {
      isLoading = false;
    });
  }

  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: label == 'Description' ? Html(data: value) : Text(value),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (orderDetails != null && orderDetails!.frontEndBase64 != null)
              Image.memory(orderDetails!.frontEndBase64!),
            if (orderDetails != null)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1), // Width of the first column
                    1: FlexColumnWidth(2), // Width of the second column
                  },
                  children: [
                    buildTableRow('Full Name', orderDetails!.fullName),
                    buildTableRow('Total Amount', orderDetails!.totalAmount),
                    buildTableRow('User Address', orderDetails!.userAddress),
                    buildTableRow('User Email', orderDetails!.userEmail),
                    buildTableRow('User Mobile', orderDetails!.userMobile),
                    buildTableRow('Quantity', orderDetails!.quantity),
                    buildTableRow('Status', orderDetails!.status),
                    buildTableRow('Type', orderDetails!.type),
                    buildTableRow(
                        'Order Tracking ID', orderDetails!.orderTrackingId),
                    buildTableRow('Title', orderDetails!.title),
                    buildTableRow(
                        'Original Price', orderDetails!.originalPirce),
                    buildTableRow('Description', orderDetails!.description),
                    TableRow(
                      children: [
                        TableCell(
                          child: SizedBox.shrink(),
                        ),
                        TableCell(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                                orderDetails!.status = 'completed';
                              });

                              try {
                                await statusUpdate(
                                    orderDetails!.orderTrackingId);
                                // Status updated successfully
                              } catch (error) {
                                // Handle error
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Text('Change Status'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (orderDetails == null)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
