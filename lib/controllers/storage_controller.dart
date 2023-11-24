import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserBankController extends GetxController {
  final userBank = GetStorage('UserBank');

  String? get bankName => userBank.read('name');

  void updateUserBank(String name) => userBank.write('name', name);
}
