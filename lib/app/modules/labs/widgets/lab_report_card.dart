import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_app/app/widgets/base_image_card.dart';

class LabReportAttachment {
  final IconData icon; // e.g., Icons.picture_as_pdf
  final VoidCallback? onTap;

  const LabReportAttachment({required this.icon, this.onTap});
}

class LabReportCard extends StatelessWidget {
  final String? thumbnail;
  final String date;
  final String labName; // e.g. "Blood Test"
  final int imageCount; // number badge on the thumbnail
  final List<LabReportAttachment> attachments;
  final VoidCallback? onTap;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onImagesBadgeTap;

  const LabReportCard({
    super.key,
    this.thumbnail,
    required this.date,
    required this.labName,
    required this.imageCount,
    this.attachments = const [],
    this.onTap,
    this.onDeletePressed,
    this.onImagesBadgeTap,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF0E2A38);

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thumbnail + image count badge
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                    child: Base64ImageCard(
                      base64String: thumbnail,
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: 0.r,
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: InkWell(
                      onTap: onImagesBadgeTap,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              size: 14.sp,
                              color: navy,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '$imageCount',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: navy,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Lab name
                    Row(
                      children: [
                        Text(
                          labName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: onDeletePressed,
                          borderRadius: BorderRadius.circular(4.r),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE5E5),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete_outline,
                                size: 20.sp,
                                color: const Color(0xFFE53E3E),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Report info
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Report-1",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    // Attachments row (pdf icons)
                    if (attachments.isNotEmpty)
                      SizedBox(
                        height: 16.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: attachments.length,
                          separatorBuilder: (_, __) => SizedBox(width: 3.w),
                          itemBuilder: (context, i) {
                            final a = attachments[i];
                            return _AttachmentPill(
                                icon: a.icon, onTap: a.onTap);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentPill extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _AttachmentPill({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 26.w,
        height: 26.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
                child: Icon(icon, size: 14.sp, color: const Color(0xFF6B7C93))),
            // small "PDF" badge
            Positioned(
              left: 2.w,
              bottom: 2.h,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xffDC61E0),
                  borderRadius: BorderRadius.circular(1.5.r),
                ),
                child: Text(
                  'PDF',
                  style: TextStyle(
                    fontSize: 5.sp,
                    height: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
