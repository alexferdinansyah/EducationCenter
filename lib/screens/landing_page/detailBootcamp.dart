import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tc/routes/routes.dart';

class DetailBootcamp extends StatefulWidget {
  const DetailBootcamp({super.key});

  @override
  State<DetailBootcamp> createState() => _DetailBootcampState();
}

class _DetailBootcampState extends State<DetailBootcamp> {

  @override
  Widget build(BuildContext context) {
  Get.toNamed('$routeBootcamp/$bootcampId');
    return const Placeholder();
  }
}