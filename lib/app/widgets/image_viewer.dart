import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/widgets/base_image_card.dart';

class ImageViewer extends StatefulWidget {
  final List<dynamic> images;
  final int initialIndex;

  const ImageViewer({
    Key? key,
    required this.images,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentIndex < widget.images.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // إذا لم تكن هناك صور، أغلق العارض
    if (widget.images.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        // print("back");
        // Get.back();
      }, // إغلاق عند الضغط على الخلفية
      child: Container(
        height: Get.height,
        width: double.infinity,
        color: Colors.black.withOpacity(0.8), // خلفية شفافة
        child: GestureDetector(
          onTap: () {
            print("back");
            Get.back();
          }, // منع الإغلاق عند الضغط على المحتوى
          child: Stack(
            children: [
              // Close button
              Positioned(
                top: 50.h,
                right: 20.w,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),

              // Image counter
              if (widget.images.length > 1)
                Positioned(
                  top: 50.h,
                  left: 20.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${widget.images.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              // PageView for images
              Center(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(32.w),
                      child: Center(
                        child: Base64ImageCard(
                          base64String: widget.images[index]["imgs"],
                          width: Get.width * 0.9,
                          height: Get.height * 0.7,
                          borderRadius: 8.r,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Navigation buttons
              if (widget.images.length > 1) ...[
                // Previous button
                if (_currentIndex > 0)
                  Positioned(
                    left: 20.w,
                    top: Get.height / 2 - 25.h,
                    child: GestureDetector(
                      onTap: _previousImage,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ),

                // Next button
                if (_currentIndex < widget.images.length - 1)
                  Positioned(
                    right: 20.w,
                    top: Get.height / 2 - 25.h,
                    child: GestureDetector(
                      onTap: _nextImage,
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ),
              ],

              // Dots indicator
              if (widget.images.length > 1)
                Positioned(
                  bottom: 50.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.images.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
