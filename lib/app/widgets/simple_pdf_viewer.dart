import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SimplePDFViewer extends StatefulWidget {
  final String base64String;
  final String fileName;

  const SimplePDFViewer({
    Key? key,
    required this.base64String,
    required this.fileName,
  }) : super(key: key);

  @override
  State<SimplePDFViewer> createState() => _SimplePDFViewerState();
}

class _SimplePDFViewerState extends State<SimplePDFViewer> {
  bool isLoading = true;
  bool isError = false;
  String? localPath;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _savePDFToLocal();
  }

  Future<void> _savePDFToLocal() async {
    try {
      // Decode base64 string to bytes
      final bytes = base64Decode(widget.base64String);

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final fileName = widget.fileName.endsWith('.pdf')
          ? widget.fileName
          : '${widget.fileName}.pdf';
      localPath = '${tempDir.path}/$fileName';

      // Write bytes to file
      final file = File(localPath!);
      await file.writeAsBytes(bytes);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _openPDF() async {
    if (localPath != null) {
      final file = File(localPath!);
      if (await file.exists()) {
        try {
          // Use content:// URI for Android to avoid FileUriExposedException
          final uri = Uri.file(localPath!);

          // Try to launch with a generic intent
          if (await canLaunchUrl(uri)) {
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );
          } else {
            // Fallback: show a dialog with options
            _showOpenOptions();
          }
        } catch (e) {
          // If direct launch fails, show options dialog
          _showOpenOptions();
        }
      }
    }
  }

  void _showOpenOptions() {
    Get.dialog(
      AlertDialog(
        title: Text('Open PDF'),
        content: Text('Choose how to open the PDF file'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _copyToDownloads();
            },
            child: Text('Save to Downloads'),
          ),
        ],
      ),
    );
  }

  Future<void> _copyToDownloads() async {
    try {
      final downloadsDir = await getExternalStorageDirectory();
      if (downloadsDir != null) {
        final downloadsPath = '${downloadsDir.path}/Downloads';
        final downloadsDirFile = Directory(downloadsPath);
        if (!await downloadsDirFile.exists()) {
          await downloadsDirFile.create(recursive: true);
        }

        final sourceFile = File(localPath!);
        final targetFile = File('$downloadsPath/${widget.fileName}');
        await sourceFile.copy(targetFile.path);

        Get.snackbar(
          'Success',
          'PDF saved to Downloads folder',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not save PDF: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      widget.fileName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: _openPDF,
                    icon: const Icon(Icons.open_in_new),
                    color: const Color(0xffDC61E0),
                    tooltip: 'Open PDF',
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isLoading) ...[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xffDC61E0),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Preparing PDF...',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ] else if (isError) ...[
                      Icon(
                        Icons.error_outline,
                        size: 64.sp,
                        color: Colors.red,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Error loading PDF',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        errorMessage ?? 'Unknown error',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ] else ...[
                      // PDF Icon
                      Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffDC61E0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.picture_as_pdf,
                          size: 60.sp,
                          color: const Color(0xffDC61E0),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'PDF Ready',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.fileName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton.icon(
                          onPressed: _openPDF,
                          icon: const Icon(Icons.share),
                          label: const Text('Open PDF'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffDC61E0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Tap the button above to open the PDF with your preferred app',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
