class BankModel {
  String? name;
  String? image;

  BankModel({
    required this.name,
    this.image,
  });
}

List<BankModel> bankLists = [
  BankModel(name: 'Bank BCA', image: 'assets/banks/Logo_BCA.png'),
  BankModel(name: 'Bank Mandiri', image: 'assets/banks/Logo_mandiri.png'),
  BankModel(name: 'Bank BNI', image: 'assets/banks/Logo_BNI.png'),
  BankModel(name: 'Bank BRI', image: 'assets/banks/Logo_BRI.png'),
  BankModel(name: 'Bank BTN', image: 'assets/banks/Logo_BTN.png'),
  BankModel(name: 'Permata Bank', image: 'assets/banks/Logo_Permata.png'),
  BankModel(name: 'BSI', image: 'assets/banks/Logo_BSI.png'),
];
