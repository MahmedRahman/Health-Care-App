class MedicalImage {
  final String id;
  final String imagePath;
  final String category;
  final DateTime date;
  final int imageCount;
  final List<String> pdfPaths;

  MedicalImage({
    required this.id,
    required this.imagePath,
    required this.category,
    required this.date,
    required this.imageCount,
    required this.pdfPaths,
  });

  static List<MedicalImage> getSampleData() {
    return [
      MedicalImage(
        id: '1',
        imagePath: 'assets/images/xray1.png',
        category: 'X-rays',
        date: DateTime(2022, 8, 1),
        imageCount: 2,
        pdfPaths: ['report1.pdf', 'report2.pdf', 'report3.pdf', 'report4.pdf'],
      ),
      MedicalImage(
        id: '2',
        imagePath: 'assets/images/xray2.png',
        category: 'X-rays',
        date: DateTime(2022, 8, 1),
        imageCount: 2,
        pdfPaths: ['report1.pdf', 'report2.pdf', 'report3.pdf', 'report4.pdf'],
      ),
      MedicalImage(
        id: '3',
        imagePath: 'assets/images/sample1.png',
        category: 'Sample',
        date: DateTime(2022, 7, 15),
        imageCount: 1,
        pdfPaths: ['sample_report1.pdf', 'sample_report2.pdf'],
      ),
      MedicalImage(
        id: '4',
        imagePath: 'assets/images/ct_scan1.png',
        category: 'CT Scan',
        date: DateTime(2022, 7, 10),
        imageCount: 3,
        pdfPaths: ['ct_report1.pdf', 'ct_report2.pdf'],
      ),
      MedicalImage(
        id: '5',
        imagePath: 'assets/images/mri1.png',
        category: 'MRI',
        date: DateTime(2022, 6, 25),
        imageCount: 1,
        pdfPaths: ['mri_report1.pdf'],
      ),
    ];
  }
}

class ImageCategory {
  final String name;
  final int count;
  final bool isSelected;

  ImageCategory({
    required this.name,
    required this.count,
    this.isSelected = false,
  });
}