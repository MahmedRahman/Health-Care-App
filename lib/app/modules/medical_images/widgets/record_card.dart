import 'package:flutter/material.dart';

class RecordAttachment {
  final IconData icon; // e.g., Icons.picture_as_pdf
  final VoidCallback? onTap;

  const RecordAttachment({required this.icon, this.onTap});
}

class RecordCard extends StatelessWidget {
  final String thumbnail;
  final DateTime date;
  final String name; // e.g. "X-rays"
  final int imageCount; // number badge on the thumbnail
  final List<RecordAttachment> attachments;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;
  final VoidCallback? onImagesBadgeTap;

  const RecordCard({
    super.key,
    required this.thumbnail,
    required this.date,
    required this.name,
    required this.imageCount,
    this.attachments = const [],
    this.onTap,
    this.onMorePressed,
    this.onImagesBadgeTap,
  });

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFFF6A2A);
    const navy = Color(0xFF0E2A38);
    final theme = Theme.of(context);

    String _fmt(DateTime d) => '${d.day}-${d.month}-${d.year}';

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
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
            Stack(
              children: [
                Image.asset(
                  thumbnail,
                  fit: BoxFit.cover,
                  height: 150,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: onImagesBadgeTap,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.photo_library_outlined,
                            size: 16,
                            color: navy,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$imageCount',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: navy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Body
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // date + menu
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 16, color: Color(0xFF6B7C93)),
                          const SizedBox(width: 6),
                          Text(
                            _fmt(date),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF6B7C93),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: onMorePressed,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 36,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF1F7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.more_horiz,
                              color: navy, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // name chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F5FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: navy,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // attachments row (pdf icons)
                  if (attachments.isNotEmpty)
                    SizedBox(
                      height: 24,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: attachments.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, i) {
                          final a = attachments[i];
                          return _AttachmentPill(icon: a.icon, onTap: a.onTap);
                        },
                      ),
                    ),
                ],
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
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(child: Icon(icon, size: 24, color: const Color(0xFF6B7C93))),
            // small "PDF" badge like in the mock
            Positioned(
              left: 6,
              bottom: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6A2A),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'PDF',
                  style: TextStyle(
                    fontSize: 9,
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
