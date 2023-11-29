import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init('UserBank');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: GetMaterialApp.router(
        routerDelegate: GetDelegate(
            preventDuplicateHandlingMode:
                PreventDuplicateHandlingMode.PopUntilOriginalRoute),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        getPages: getPages,
        theme: ThemeData().copyWith(
          visualDensity: VisualDensity.standard,
        ),

        // home: Wrapper(),
      ),
    );
  }
}
