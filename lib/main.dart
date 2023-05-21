import 'package:flutter/material.dart';
import 'package:salonemployee/constants.dart';
import 'package:flutter/services.dart';
import 'package:salonemployee/orderHistory.dart';
import 'package:salonemployee/showOrder.dart';
import 'OngoingOrder.dart';
import 'api_service.dart';
import 'DashboardPage.dart'; // Import the dashboard_page.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      initialRoute: '/',
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/orderHistory': (context) => OrderHistory(),
        '/ongoingOrders': (context) => OngoingOrder(),
        '/showOrder': (context) => ShowOrder(),
        '/logout': (context) => MyApp(),
      },
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String loginErrorMessage = '';

  Future<void> loginValidate() async {
    final String status = await ApiService.loginValidate(
      nameController.text,
    );

    if (status == 'SUCCESS') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashboard',
        (route) => false,
      );
    } else {
      setState(() {
        loginErrorMessage = 'Login Validation Failed.! Invalid MobileNo';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  loginTitle,
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  signIn,
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: mobileNolabel,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Container(
              height: 20,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(loginErrorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  )),
            )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text(login),
                  onPressed: loginValidate,
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                const Text(dontHaveAccount),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
