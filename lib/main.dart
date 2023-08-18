import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/screens/wrapper.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
