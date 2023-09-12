import 'package:flutter/material.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
          onPressed: () async {
            await _auth.signOut();
          },
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          label: const Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ]),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView(children: [
            Container(
                // padding: EdgeInsets.symmetric(
                //     horizontal: width * .045, vertical: height * .018),
                color: CusColors.bg,
                alignment: Alignment.centerLeft,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    height: 4000,
                    width: 400,
                    color: const Color(0xFFF6F7F9),
                    child: Column(children: [
                      Image.asset(
                        'assets/images/logo_dac.png',
                        width: width * .14,
                      ),
                    ]),
                  )
                ]))
          ])),
    );
  }
}
