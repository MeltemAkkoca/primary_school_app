class FeeData {
  final String receiptNo;
  final String month;
  final String date;
  final String paymentStatus;
  final String totalAmount;

  FeeData(this.receiptNo, this.month, this.date, this.paymentStatus,
      this.totalAmount);
}

List<FeeData> fee = [
  FeeData('90871', 'Mayıs', '14 Mayıs 2023', 'Ödendi', '300 tl'),
  FeeData('90872', 'Haziran', '14 Haziran 2023', 'Ödendi', '300 tl'),
  FeeData('90873', 'Temmuz', '14 Temmuz 2023', 'Bekleniyor', '300 tl')
];
