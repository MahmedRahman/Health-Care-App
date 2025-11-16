import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/data/medical_image.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/upload_bottom_sheet.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/upload_controller.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/filter_controller.dart';
import 'package:intl/intl.dart';

class MedicalImagesController extends GetxController with StateMixin {
  // قائمة الصور الطبية
  var medicalImages = [].obs;

  // فئات التصفية
  var categories = <ImageCategory>[].obs;

  // الفئة المحددة حالياً
  var selectedCategoryIndex = 0.obs;

  // حالة التحميل
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initializeData();
  }

  Future<void> initializeData() async {
    change(null, status: RxStatus.loading());
    final response = await ApiRequest().getImages();
    medicalImages.assignAll(response.body);

    if (medicalImages.isEmpty) {
      change(null, status: RxStatus.empty());
      return;
    }

    _createCategories(medicalImages);

    change(medicalImages, status: RxStatus.success());
  }

  RxList<dynamic> categoriesList = ["All"].obs;

  void _createCategories(List<dynamic> medicalImages) {
    categoriesList.clear();
    categoriesList.add("All");
    for (var image in medicalImages) {
      categoriesList.add(image["folderName"]); // no duplicates
      categoriesList.assignAll(categoriesList.toSet().toList());
    }

    update();
  }

  // تغيير الفئة المحددة
  void selectCategory(int index) {
    List<dynamic> ResetMedicalImages;
    selectedCategoryIndex.value = index;
    if (index == 0) {
      ResetMedicalImages = medicalImages;
    } else {
      ResetMedicalImages = medicalImages
          .where((image) => image["folderName"] == categoriesList[index])
          .toList();
    }

    change(ResetMedicalImages, status: RxStatus.success());
  }

  // الحصول على الصور المفلترة
  void filteredImages(res) async {
    change(null, status: RxStatus.loading());
    RxList<dynamic> filteredImagesList = [].obs;

    //try {
    // تحويل التواريخ إلى تنسيق API
    String? dateFrom;
    String? dateTo;
    String? ordering;

    if (res.from != null && res.from.toString().isNotEmpty) {
      try {
        // Parse the date string (format: MM-dd-yyyy) to DateTime
        final dateFormat = DateFormat('MM-dd-yyyy');
        final dateTime = dateFormat.parse(res.from.toString());
        dateFrom =
            "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
      } catch (e) {
        // If parsing fails, use the string as is (assuming it's already in the correct format)
        dateFrom = res.from.toString();
      }
    }

    if (res.to != null && res.to.toString().isNotEmpty) {
      try {
        final dateFormat = DateFormat('MM-dd-yyyy');
        final dateTime = dateFormat.parse(res.to.toString());
        dateTo =
            "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
      } catch (e) {
        // If parsing fails, use the string as is (assuming it's already in the correct format)
        dateTo = res.to.toString();
      }
    }

    if (res.sort.toString() != "") {
      ordering =
          res.sort == SortOrder.newestFirst ? "Newest First" : "Oldest First";
    }

    var response = await ApiRequest().filterImages(
      dateFrom: dateFrom,
      dateTo: dateTo,
      xrayType: null,
      ordering: null,
    );

    if (response.statusCode == 200) {
      print("response.body: ${response.body}");
      if (response.body.isEmpty) {
        Notifier.of.error("No images found", title: "No images found");
        change(medicalImages, status: RxStatus.success());
        return;
      }
      filteredImagesList.assignAll(response.body);
      change(filteredImagesList, status: RxStatus.success());
    } else {
      Notifier.of.error("Failed to filter images");
    }
    // } catch (e) {
    //   Notifier.of.error("Failed to filter images");
    // } finally {
    //   change(filteredImagesList, status: RxStatus.success());
    // }
  }

  // فلترة محلية للبيانات
  void _applyLocalFilter(res) {
    List<dynamic> filtered = List.from(medicalImages);

    // فلترة حسب التاريخ
    if (res.from != null) {
      filtered = filtered.where((image) {
        if (image["date"] != null) {
          DateTime imageDate = DateTime.parse(image["date"]);
          return imageDate.isAfter(res.from) ||
              imageDate.isAtSameMomentAs(res.from);
        }
        return false;
      }).toList();
    }

    if (res.to != null) {
      filtered = filtered.where((image) {
        if (image["date"] != null) {
          DateTime imageDate = DateTime.parse(image["date"]);
          return imageDate.isBefore(res.to.add(const Duration(days: 1))) ||
              imageDate.isAtSameMomentAs(res.to);
        }
        return false;
      }).toList();
    }

    // ترتيب البيانات
    if (res.sort != null) {
      filtered.sort((a, b) {
        if (a["date"] == null || b["date"] == null) return 0;

        DateTime dateA = DateTime.parse(a["date"]);
        DateTime dateB = DateTime.parse(b["date"]);

        if (res.sort == SortOrder.newestFirst) {
          return dateB.compareTo(dateA);
        } else {
          return dateA.compareTo(dateB);
        }
      });
    }

    change(filtered, status: RxStatus.success());
  }

  // إضافة صورة جديدة
  void addNewImage() {
    // مسح الصور المحددة عند فتح الـ upload sheet
    try {
      final uploadController = Get.find<UploadController>();
      uploadController.removeFile();
    } catch (e) {
      // الـ controller غير موجود، لا مشكلة
    }

    Get.bottomSheet(
      const UploadBottomSheet(),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      backgroundColor: Colors.transparent, // we style inside
    );
    // TODO: تنفيذ إضافة صورة جديدة
  }

  Future<void> uploadImage(
    String folderName,
    List<String> images,
  ) async {
    change(null, status: RxStatus.loading());
    try {
      final res = await ApiRequest().addImage(
        folderName: folderName,
        images: images,
      );

      if (res.statusCode == 200) {
        await initializeData();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to upload image: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
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
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
                deleteImage(image);
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
  void deleteImage(image) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Image'),
        content: const Text('Are you sure you want to delete this image?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              //close dialog
              Get.back();
              //change status to loading
              change(null, status: RxStatus.loading());
              try {
                await ApiRequest().deleteImage(
                  imageId: image["id"].toString(),
                );
              } catch (e) {
                Get.snackbar("Erro", e.toString());
              } finally {
                await initializeData();
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
