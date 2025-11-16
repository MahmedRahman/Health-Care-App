import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/core/service/version_service.dart';

import '../controllers/reports_controller.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Reports',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: ListView(
          children: [
            CustomExpansionTile(
              title: 'bloodPressure',
              icon: 'assets/images/report1.png',
              columns: [
                DataColumn(label: Text("date")),
                DataColumn(label: Text("High")),
                DataColumn(label: Text("Normal")),
                DataColumn(label: Text("Low")),
                DataColumn(label: Text("Unit")),
              ],
              rows: List.generate(
                Get.find<VersionService>().bloodPressure.length,
                (index) {
                  final item = Get.find<VersionService>().bloodPressure[index];
                  return DataRow(
                    cells: [
                      DataCell(Column(
                        children: [
                          SizedBox(height: 4.h),
                          Text(item['date'].toString()),
                          Text(
                            item['time'].toString(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.green.withOpacity(0.8)),
                          ),
                        ],
                      )),
                      DataCell(Text(item['sbp'].toString())),
                      DataCell(Text(item['dbp'].toString())),
                      DataCell(Text(item['meanBloodPressure'].toString())),
                      DataCell(Text("mmHg")),
                    ],
                  );
                },
              ),
              symptoms: Get.find<VersionService>()
                  .bloodPressure
                  .map((e) => e['symtopms'])
                  .toSet()
                  .toList(),
            ),

            SizedBox(height: 16.h),
            //bloodRate
            CustomExpansionTile(
              title: 'Heart Rate',
              icon: 'assets/images/report2.png',
              columns: [
                DataColumn(label: Text("date")),
                DataColumn(label: Text("heartRate")),
                DataColumn(label: Text("Unit")),
              ],
              rows: List.generate(
                Get.find<VersionService>().bloodRate.length,
                (index) {
                  final item = Get.find<VersionService>().bloodRate[index];
                  return DataRow(cells: [
                    DataCell(Column(
                      children: [
                        SizedBox(height: 4.h),
                        Text(item['date'].toString()),
                        Text(
                          item['time'].toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.green.withOpacity(0.8)),
                        ),
                      ],
                    )),
                    DataCell(Text(item['heartRate'].toString())),
                    DataCell(Text("bpm")),
                  ]);
                },
              ),
              symptoms: Get.find<VersionService>()
                  .bloodRate
                  .map((e) => e['symptoms'])
                  .toSet()
                  .toList(),
            ),

            //oxygenSaturation
            SizedBox(height: 16.h),
            //oxygenSaturation
            CustomExpansionTile(
              title: 'Oxygen Saturation',
              icon: 'assets/images/report3.png',
              columns: [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Oxygen Saturation")),
                DataColumn(label: Text("Delivery Method")),
                DataColumn(label: Text("Unit")),
              ],
              rows: List.generate(
                Get.find<VersionService>().oxygenSaturationListData.length,
                (index) {
                  final item = Get.find<VersionService>()
                      .oxygenSaturationListData[index];
                  return DataRow(cells: [
                    DataCell(Column(
                      children: [
                        SizedBox(height: 4.h),
                        Text(item['date'].toString()),
                        Text(
                          item['time'].toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.green.withOpacity(0.8)),
                        ),
                      ],
                    )),
                    DataCell(Text(item['bloodSaturation'].toString())),
                    DataCell(Text(item['oxogynDeliveryMethod'].toString())),
                    DataCell(Text("%")),
                  ]);
                },
              ),
              symptoms: Get.find<VersionService>()
                  .oxygenSaturationListData
                  .map((e) => e['symptoms'])
                  .toSet()
                  .toList(),
            ),
            SizedBox(height: 16.h),

            //weight
            CustomExpansionTile(
              title: 'Weight',
              icon: 'assets/images/report4.png',
              columns: [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Weight")),
                DataColumn(label: Text("bmi")),
                DataColumn(label: Text("Unit")),
              ],
              rows: List.generate(
                Get.find<VersionService>().WeightListData.length,
                (index) {
                  final item = Get.find<VersionService>().WeightListData[index];
                  return DataRow(cells: [
                    DataCell(Column(
                      children: [
                        SizedBox(height: 4.h),
                        Text(item['date'].toString()),
                        Text(
                          item['time'].toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.green.withOpacity(0.8)),
                        ),
                      ],
                    )),
                    DataCell(Text(item['weight'].toStringAsFixed(0))),
                    DataCell(Text(item['bmi'].toStringAsFixed(0))),
                    DataCell(Text("kg")),
                  ]);
                },
              ),
              symptoms: Get.find<VersionService>()
                  .WeightListData
                  .map((e) => e['symptoms'])
                  .toSet()
                  .toList(),
            ),

            SizedBox(height: 16.h),
            //bloodSugar
            CustomExpansionTile(
              title: 'Random Blood Sugar',
              icon: 'assets/images/report5.png',
              columns: [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("R B S")),
                DataColumn(label: Text("Insuline Dose")),
                DataColumn(label: Text("Unit")),
              ],
              rows: List.generate(
                Get.find<VersionService>().bloodSugar.length,
                (index) {
                  final item = Get.find<VersionService>().bloodSugar[index];
                  return DataRow(cells: [
                    DataCell(Column(
                      children: [
                        SizedBox(height: 4.h),
                        Text(item['date'].toString()),
                        Text(
                          item['time'].toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.green.withOpacity(0.8)),
                        ),
                      ],
                    )),
                    DataCell(Text(item['randomBloodSugar'].toStringAsFixed(0))),
                    DataCell(Text(item['insulineDose'].toStringAsFixed(0))),
                    DataCell(Text("mg/dL")),
                  ]);
                },
              ),
              symptoms: Get.find<VersionService>()
                  .bloodSugar
                  .map((e) => e['symptoms'])
                  .toSet()
                  .toList(),
            ),

            SizedBox(height: 16.h),
            //fluidBalance
            CustomExpansionTile(
              title: 'Fluid Balance (F/B)',
              icon: 'assets/images/report6.png',
              columns: [
                DataColumn(label: Text("Date")),
                DataColumn(label: Text("Intake")),
                DataColumn(label: Text("Output")),
                DataColumn(label: Text("Balance")),
                DataColumn(label: Text("Unit")),
              ],
              rows: List.generate(
                Get.find<VersionService>().fluidBalance.length,
                (index) {
                  final item = Get.find<VersionService>().fluidBalance[index];
                  return DataRow(cells: [
                    DataCell(
                      Column(
                        children: [
                          SizedBox(height: 4.h),
                          Text(item['date'].toString()),
                          Text(
                            item['time'].toString(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.green.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text(item['fluidIn'].toString())),
                    DataCell(Text(item['fluidOut'].toString())),
                    DataCell(Text(item['fluidNet'].toString())),
                    DataCell(Text("ml")),
                  ]);
                },
              ),
              symptoms: Get.find<VersionService>()
                  .fluidBalance
                  .map((e) => e['symptoms'])
                  .toSet()
                  .toList(),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String icon;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final List<dynamic> symptoms;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.columns,
    required this.rows,
    required this.symptoms,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  int currentItemsToShow = 4;
  static const int incrementBy = 4;

  @override
  Widget build(BuildContext context) {
    List<DataRow> displayedRows = widget.rows.take(currentItemsToShow).toList();
    bool hasMoreItems = widget.rows.length > currentItemsToShow;
    int remainingItems = widget.rows.length - currentItemsToShow;

    return ExpansionTile(
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      title: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.icon,
                width: 24.sp,
                height: 24.sp,
                // color: Colors.black,
              ),
              SizedBox(width: 8.w),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                    Colors.blue.shade50,
                  ),
                  columns: widget.columns,
                  rows: displayedRows,
                ),
              ),
              if (hasMoreItems)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentItemsToShow += incrementBy;
                        if (currentItemsToShow > widget.rows.length) {
                          currentItemsToShow = widget.rows.length;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: Text(
                      'Show More (${remainingItems} more)',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.only(left: 16.w),
          width: double.infinity,
          child: Text(
            'Symptoms',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 16.w),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.generate(
              widget.symptoms.length,
              (index) => Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Color(0xffF1F6FD),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  widget.symptoms[index].toString(),
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff25C87F)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
