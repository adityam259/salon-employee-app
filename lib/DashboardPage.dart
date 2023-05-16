import 'package:flutter/material.dart';
import 'api_service.dart';

class DashboardPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Menu Item 1'),
              onTap: () {
                // Handle menu item 1 tap
              },
            ),
            ListTile(
              title: Text('Menu Item 2'),
              onTap: () {
                // Handle menu item 2 tap
              },
            ),
            // Add more ListTile widgets for additional menu items
          ],
        ),
      ),
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
  String completeCount = '';
  String pendingCount = '';
  @override
  void initState() {
    super.initState();
    getOrderCompleteCount();
    getOrderPendingCount();
  }

  Future<void> getOrderCompleteCount() async {
    final String countComplete = await ApiService.getOrderCompleteCount();
    print(countComplete);
    setState(() {
      completeCount = countComplete;
    });
  }

  Future<void> getOrderPendingCount() async {
    final String countPending = await ApiService.getOrderPendingCount();
    print(countPending);

    setState(() {
      pendingCount = countPending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatusBox(
                    title: 'Complete \n Orders',
                    count: completeCount,
                    color: Colors.blue.shade100,
                  ),
                  StatusBox(
                    title: 'Pending \n Orders',
                    count: pendingCount,
                    color: Colors.blue.shade100,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class StatusBox extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const StatusBox({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
