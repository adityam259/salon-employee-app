import 'package:flutter/material.dart';
import 'package:salonemployee/Order.dart';
import 'MyDrawer.dart';
import 'api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'sessionStorage.dart';
import 'MyDrawer.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      drawer: MyDrawer(),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Order> orders = [];
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });
    String? mobileNumberFromSession = await getSessionData('mobileNo');
    String mobileNumber = mobileNumberFromSession ?? '';
    final response =
        await ApiService.getCompletedOrdersForEmployee(mobileNumber);

    setState(() {
      isLoading = false;
      orders.clear();
      orders.addAll(response);
      currentPage++;
    });
  }

  void loadOrderDetails(String orderId) {
    //print(orderId);
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/showOrder',
      arguments: orderId,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: orders.length + 1,
                    itemBuilder: (context, index) {
                      if (index < orders.length) {
                        final order = orders[index];
                        return ListTile(
                          title: Text(
                              'Name: ${order.fullName} \nOrder ID: ${order.orderTrackingId}'),
                          subtitle:
                              Text('Total Amount: \u20B9${order.totalAmount}'),
                          onTap: () {
                            // Handle order item tap
                            loadOrderDetails(order.orderTrackingId);
                          },
                        );
                      } else if (!isLoading) {
                        return ListTile(
                          title: Text('Load More'),
                          onTap: fetchOrders,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
