class AssignmentData {
  final String subjectName;
  final String topicName;
  final String assignDate;
  final String lastDate;
  final String status;

  AssignmentData(this.subjectName, this.topicName, this.assignDate,
      this.lastDate, this.status);
}

List<AssignmentData> assignment = [
  AssignmentData(
      'Oyun Hamuru Etkinliği',
      'Çocuklar oyun hamuruyla sekiller yaptı',
      '10 Temmuz 2023-10.00',
      '10 Temmuz 2023-10.30',
      'Tamamlandı'),
  AssignmentData(
      'Masal Anlatımı Etkinliği',
      'Utku saati öncesi masal anlatımı yapıldı',
      '10 Temmuz 2023-10.30',
      '10 Temmuz 2023-11.00',
      'Tamamlandı'),
  AssignmentData('Boyama Etkinliği', 'Renk temasına göre boyama yapılıyor',
      '10 Temmuz 2023-11.00', '10 Temmuz 2023-11.30', 'Tamamlanıyor'),
  AssignmentData('Bil Bakalım Oyunu', 'Bil bakalım oyunu oynatılacak',
      '10 Temmuz 2023-11.30', '10 Temmuz 2023-12.00', 'Tamamlanacak'),
];
