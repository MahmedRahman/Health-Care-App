import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UpdateBackgroundScreen extends StatelessWidget {
  final List<Color> colorOptions = [
    Color(0xFF3B6DF6),
    Color(0xFFB03C8A),
    Color(0xFF8E44AD),
    Color(0xFFAEDC2A),
    Color(0xFFE67E22),
    Color(0xFF1ABC9C),
    Color(0xFF3498DB),
    Color(0xFF34495E),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Update Background',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102437),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Choose Image',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF102437),
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // TODO: pick image
              },
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_rounded, size: 40, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      'Choose image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF102437),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'JPG, PNG, max image size is 5mb',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Choose Color',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF102437),
              ),
            ),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: colorOptions
                    .map((color) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              Get.back(result: color);
                              // TODO: select color
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: color,
                              child:
                                  Container(), // ممكن تضيف علامة صح هنا لو اللون متحدد
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: update action
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF102437),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
