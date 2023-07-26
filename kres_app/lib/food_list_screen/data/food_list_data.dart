class FoodListData {
  final int date;
  final String monthName;
  final String food1;
  final String food2;
  final String food3;
  final String food4;
  final String dayName;
  final String time;

  FoodListData(this.date, this.monthName, this.food1, this.food2, this.food3,
      this.food4, this.dayName, this.time);
}

List<FoodListData> foodlist = [
  FoodListData(10, 'Temmuz', 'haslanmıs yumurta', 'zeytin', 'peynir', 'süt',
      'Pazartesi', '9.00'),
  FoodListData(11, 'Temmuz', 'bal', 'kaymak', 'ekmek', 'süt', 'Salı', '9.00'),
  FoodListData(12, 'Temmuz', 'omlet', 'zeytin', 'peynir', 'ada çayı',
      'Çarşamba', '9.00'),
  FoodListData(13, 'Temmuz', 'simit', 'zeytin', 'peynir', 'yesil çay',
      'Perşembe', '9.00'),
  FoodListData(
      14, 'Temmuz', 'tost', 'domates', 'salatalık', 'süt', 'Cuma', '9.00'),
  // FoodListData(15, 'Temmuz', 'haslanmıs yumurta', 'zeytin', 'peynir', 'süt',
  //     'Pazartesi', '9.00'),
  // FoodListData(16, 'Temmuz', 'çikolatalı ekmek', 'salatalık', 'peynir', 'süt',
  //     'Pazartesi', '9.00'),
];
