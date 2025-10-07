import 'package:get/get.dart';

import '../../../constants/appAssets.dart';
import '../../../constants/colors.dart';


class AppointmentsController extends GetxController {
  final List<Map<String, dynamic>> items = [
    {'title': 'Hospital', 'icon': AppAssets.hospital, 'color': AppColors.hospitalColor},
    {'title': 'Doctors', 'icon': AppAssets.docs, 'color': AppColors.docsColor},
    {'title': 'Laboratory', 'icon': AppAssets.lab, 'color': AppColors.labColor},
    {'title': 'Imaging Centers', 'icon': AppAssets.imaging, 'color': AppColors.imagingColor},
    {'title': 'Nurse', 'icon': AppAssets.nurse, 'color': AppColors.nurseColor},
    {'title': 'Rehab Center', 'icon': AppAssets.center, 'color': AppColors.centerColor},
    {'title': 'Home Visit', 'icon': AppAssets.visitHome, 'color': AppColors.homeVisitColor},
  ];
}
