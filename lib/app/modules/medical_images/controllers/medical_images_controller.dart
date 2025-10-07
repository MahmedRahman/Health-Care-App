import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../models/image_model.dart';
import '../services/image_service.dart';
import 'package:http/http.dart' as http;


class MedicalImagesController extends GetxController with StateMixin<List<ImageModel>> {
  final ImageService _service = ImageService();
  final picker = ImagePicker();

  List<ImageModel> images = [];

  var categories = <ImageCategory>[].obs;
  var selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
    _initCategories();
  }

  void _initCategories() {
    categories.value = [
      ImageCategory(name: 'All', count: 0),
      ImageCategory(name: 'X-rays', count: 3),
      ImageCategory(name: 'Scans', count: 2),
      ImageCategory(name: 'Reports', count: 1),
    ];
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  Future<void> fetchImages() async {
    try {
      change(null, status: RxStatus.loading());
      images = await _service.fetchImages();
      change(images, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addNewImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);

    try {
      const token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJlaXNhYWJkYWxsYWg0OTkxMEBnbWFpbC5jb20iLCJpYXQiOjE3NTk2NjE5NDAsImV4cCI6MTg2NzY2MTk0MH0.VtPhcjVq_pvQPDS3i6nnxx49B2_ALPzu1EcaQav-RR4';

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://159.198.36.67:8080/add/images'),
      );

      request.files.add(await http.MultipartFile.fromPath(
        'image', // اسم الحقل في الـ backend
        file.path,
      ));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar(
          'Upload Successful 🎉',
          'Your image has been uploaded.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        await fetchImages(); // تحديث الصور بعد الرفع
      } else {
        Get.snackbar(
          'Upload Failed 😞',
          'Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        print('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Error ⚠️',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      print(e);
    }
  }





  List<ImageModel> get filteredImages => images;
}

class ImageCategory {
  final String name;
  final int count;
  ImageCategory({required this.name, required this.count});
}


// class MedicalImagesController extends GetxController with StateMixin {
//   // قائمة الصور الطبية
//   var medicalImages = <MedicalImage>[].obs;
//
//   // فئات التصفية
//   var categories = <ImageCategory>[].obs;
//
//   // الفئة المحددة حالياً
//   var selectedCategoryIndex = 0.obs;
//
//   // حالة التحميل
//   var isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeData();
//     change(null, status: RxStatus.empty());
//   }
//
//   void _initializeData() {
//     // تحميل البيانات التجريبية
//     medicalImages.value = MedicalImage.getSampleData();
//
//     // إنشاء فئات التصفية
//     _createCategories();
//   }
//
//   void _createCategories() {
//     // حساب عدد الصور لكل فئة
//     Map<String, int> categoryCounts = {};
//     for (var image in medicalImages) {
//       categoryCounts[image.category] =
//           (categoryCounts[image.category] ?? 0) + 1;
//     }
//
//     // إضافة فئة "All"
//     categories.add(ImageCategory(
//       name: 'All',
//       count: medicalImages.length,
//       isSelected: true,
//     ));
//
//     // إضافة الفئات الأخرى
//     categoryCounts.forEach((category, count) {
//       categories.add(ImageCategory(
//         name: category,
//         count: count,
//         isSelected: false,
//       ));
//     });
//   }
//
//   // تغيير الفئة المحددة
//   void selectCategory(int index) {
//     // إلغاء تحديد جميع الفئات
//     for (int i = 0; i < categories.length; i++) {
//       categories[i] = ImageCategory(
//         name: categories[i].name,
//         count: categories[i].count,
//         isSelected: i == index,
//       );
//     }
//
//     selectedCategoryIndex.value = index;
//     categories.refresh();
//   }
//
//   // الحصول على الصور المفلترة
//   List<MedicalImage> get filteredImages {
//     return [];
//     // if (selectedCategoryIndex.value == 0) {
//     //   return medicalImages; // عرض جميع الصور
//     // } else {
//     //   String selectedCategory = categories[selectedCategoryIndex.value].name;
//     //   return medicalImages.where((image) => image.category == selectedCategory).toList();
//     // }
//   }
//
//   // إضافة صورة جديدة
//   void addNewImage() {
//     Get.bottomSheet(
//       const UploadBottomSheet(),
//       isScrollControlled: true,
//       enableDrag: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//       ),
//       backgroundColor: Colors.transparent, // we style inside
//     );
//     // TODO: تنفيذ إضافة صورة جديدة
//   }
//
//   // عرض خيارات الصورة
//   void showImageOptions(MedicalImage image) {
//     Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.visibility),
//               title: const Text('عرض'),
//               onTap: () {
//                 Get.back();
//                 // TODO: عرض الصورة
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.download),
//               title: const Text('تحميل'),
//               onTap: () {
//                 Get.back();
//                 // TODO: تحميل الصورة
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.share),
//               title: const Text('مشاركة'),
//               onTap: () {
//                 Get.back();
//                 // TODO: مشاركة الصورة
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete, color: Colors.red),
//               title: const Text('حذف', style: TextStyle(color: Colors.red)),
//               onTap: () {
//                 Get.back();
//                 _deleteImage(image);
//               },
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//     );
//   }
//
//   // حذف صورة
//   void _deleteImage(MedicalImage image) {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('تأكيد الحذف'),
//         content: const Text('هل أنت متأكد من حذف هذه الصورة؟'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('إلغاء'),
//           ),
//           TextButton(
//             onPressed: () {
//               medicalImages.remove(image);
//               _createCategories(); // إعادة إنشاء الفئات
//               Get.back();
//             },
//             child: const Text('حذف', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }
