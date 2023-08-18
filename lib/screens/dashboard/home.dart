import 'package:flutter/material.dart';
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
    );
  }
}
