import 'dart:math';
import 'package:flutter/material.dart';

class BootcampPage extends StatefulWidget {
  const BootcampPage({Key? key}) : super(key: key);

  @override
  _BootcampPageState createState() => _BootcampPageState();
}

class _BootcampPageState extends State<BootcampPage> {
  final TextEditingController _controller = TextEditingController();
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: width * 0.8,
                child: Image.asset('assets/images/SLIDE 3.png'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              onChanged: (val) {
                print(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
