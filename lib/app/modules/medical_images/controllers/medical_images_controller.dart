import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/data/medical_image.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/upload_bottom_sheet.dart';

class MedicalImagesController extends GetxController with StateMixin {
  // قائمة الصور الطبية
  var medicalImages = <MedicalImage>[].obs;

  // فئات التصفية
  var categories = <ImageCategory>[].obs;

  // الفئة المحددة حالياً
  var selectedCategoryIndex = 0.obs;

  // حالة التحميل
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    change(null, status: RxStatus.empty());
  }

  void _initializeData() {
    // تحميل البيانات التجريبية
    medicalImages.value = MedicalImage.getSampleData();

    // إنشاء فئات التصفية
    _createCategories();
  }

  void _createCategories() {
    // حساب عدد الصور لكل فئة
    Map<String, int> categoryCounts = {};
    for (var image in medicalImages) {
      categoryCounts[image.category] =
          (categoryCounts[image.category] ?? 0) + 1;
    }

    // إضافة فئة "All"
    categories.add(ImageCategory(
      name: 'All',
      count: medicalImages.length,
      isSelected: true,
    ));

    // إضافة الفئات الأخرى
    categoryCounts.forEach((category, count) {
      categories.add(ImageCategory(
        name: category,
        count: count,
        isSelected: false,
      ));
    });
  }

  // تغيير الفئة المحددة
  void selectCategory(int index) {
    // إلغاء تحديد جميع الفئات
    for (int i = 0; i < categories.length; i++) {
      categories[i] = ImageCategory(
        name: categories[i].name,
        count: categories[i].count,
        isSelected: i == index,
      );
    }

    selectedCategoryIndex.value = index;
    categories.refresh();
  }

  // الحصول على الصور المفلترة
  List<MedicalImage> get filteredImages {
    return [];
    // if (selectedCategoryIndex.value == 0) {
    //   return medicalImages; // عرض جميع الصور
    // } else {
    //   String selectedCategory = categories[selectedCategoryIndex.value].name;
    //   return medicalImages.where((image) => image.category == selectedCategory).toList();
    // }
  }

  // إضافة صورة جديدة
  void addNewImage() {
    Get.bottomSheet(
      const UploadBottomSheet(),
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      backgroundColor: Colors.transparent, // we style inside
    );
    // TODO: تنفيذ إضافة صورة جديدة
  }

  // عرض خيارات الصورة
  void showImageOptions(MedicalImage image) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('عرض'),
              onTap: () {
                Get.back();
                // TODO: عرض الصورة
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('تحميل'),
              onTap: () {
                Get.back();
                // TODO: تحميل الصورة
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('مشاركة'),
              onTap: () {
                Get.back();
                // TODO: مشاركة الصورة
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('حذف', style: TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
                _deleteImage(image);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  // حذف صورة
  void _deleteImage(MedicalImage image) {
    Get.dialog(
      AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذه الصورة؟'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              medicalImages.remove(image);
              _createCategories(); // إعادة إنشاء الفئات
              Get.back();
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
