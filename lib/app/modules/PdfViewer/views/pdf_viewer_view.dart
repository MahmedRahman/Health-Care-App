import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  final String assetPath;

  const PdfViewerPage({super.key, required this.assetPath});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String? localPath;
  bool error = false;

  @override
  void initState() {
    super.initState();
    preparePdf();
  }

  Future<void> preparePdf() async {
    try {
      final bytes = await rootBundle.load(widget.assetPath);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temp.pdf');
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

      if (await file.exists()) {
        setState(() {
          localPath = file.path;
        });
      } else {
        setState(() {
          error = true;
        });
      }
    } catch (e) {
      setState(() {
        error = true;
      });
      print("Error loading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return Scaffold(
        appBar: AppBar(title: const Text("Terms & Conditions")),
        body: const Center(child: Text("Failed to load PDF file.")),
      );
    }

    if (localPath == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Terms & Conditions")),
      body: PDFView(
        filePath: localPath!,
      ),
    );
  }
}
