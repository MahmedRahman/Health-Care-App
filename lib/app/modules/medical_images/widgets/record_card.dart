import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_app/app/widgets/base_image_card.dart';

class RecordAttachment {
  final IconData icon; // e.g., Icons.picture_as_pdf
  final VoidCallback? onTap;

  const RecordAttachment({required this.icon, this.onTap});
}

class RecordCard extends StatelessWidget {
  final String? thumbnail;
  final String date;
  final String name; // e.g. "X-rays"
  final int imageCount; // number badge on the thumbnail
  final List<RecordAttachment> attachments;
  final VoidCallback? onTap;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onImagesBadgeTap;

  const RecordCard({
    super.key,
    this.thumbnail,
    required this.date,
    required this.name,
    required this.imageCount,
    this.attachments = const [],
    this.onTap,
    this.onDeletePressed,
    this.onImagesBadgeTap,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF0E2A38);
    final theme = Theme.of(context);

    String _fmt(DateTime d) => '${d.day}-${d.month}-${d.year}';

    return InkWell(
      borderRadius: BorderRadius.circular(22.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 16,
              offset: Offset(0, 8),
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
                  Base64ImageCard(
                    base64String: thumbnail,
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: 8.r,
                    // height: double.infinity,
                  ),
                  // Image.asset(
                  //   thumbnail,
                  //   fit: BoxFit.cover,
                  //   height: double.infinity,
                  //   width: double.infinity,
                  // ),
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
                padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // date + menu
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,
                                  size: 14.sp, color: const Color(0xFF6B7C93)),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  date.toString(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF6B7C93),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: onDeletePressed,
                          borderRadius: BorderRadius.circular(4.r),
                          child: Container(
                            width: 32.w,
                            height: 24.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE5E5),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              color: const Color(0xFFE53E3E),
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),

                    // name chip
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F5FA),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: navy,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // attachments row (pdf icons)
                    if (attachments.isNotEmpty)
                      SizedBox(
                        height: 16.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: attachments.length,
                          separatorBuilder: (_, __) => SizedBox(width: 3.w),
                          itemBuilder: (context, i) {
                            final a = attachments[i];
                            return Row(
                              children: [
                                _AttachmentPill(
                                  icon: a.icon,
                                  onTap: a.onTap,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Report',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            );
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
              child: Icon(
                icon,
                size: 14.sp,
                color: const Color(0xFF6B7C93),
              ),
            ),
            // small "PDF" badge like in the mock
            Positioned(
              left: 2.w,
              bottom: 2.h,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6A2A),
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
