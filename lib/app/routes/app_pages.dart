import 'package:get/get.dart';

import '../modules/PatientInfo/bindings/patient_info_binding.dart';
import '../modules/PatientInfo/views/patient_info_view.dart';
import '../modules/PdfViewer/bindings/pdf_viewer_binding.dart';
import '../modules/PdfViewer/views/pdf_viewer_view.dart';
import '../modules/about_app/bindings/about_app_binding.dart';
import '../modules/about_app/views/about_app_view.dart';
import '../modules/appointments/bindings/appointments_binding.dart';
import '../modules/appointments/views/appointments_view.dart';
import '../modules/care_gevers/bindings/care_gevers_binding.dart';
import '../modules/care_gevers/views/care_gevers_view.dart';
import '../modules/contact/bindings/contact_binding.dart';
import '../modules/contact/views/contact_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/labs/bindings/labs_binding.dart';
import '../modules/labs/views/labs_view.dart';
import '../modules/medical_images/bindings/medical_images_binding.dart';
import '../modules/medical_images/views/medical_images_view.dart';
import '../modules/medications/bindings/medications_binding.dart';
import '../modules/medications/views/medications_view.dart';
import '../modules/medications/views/doses_schedule_view.dart';
import '../modules/medicine_add/bindings/medicine_add_binding.dart';
import '../modules/medicine_add/views/medicine_add_view.dart';
import '../modules/medicine_details/bindings/medicine_details_binding.dart';
import '../modules/medicine_details/views/medicine_details_view.dart';
import '../modules/more/bindings/more_binding.dart';
import '../modules/more/views/more_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../widgets/app_layout.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      middlewares: [LayoutMiddleware()],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MORE,
      page: () => const MoreView(),
      binding: MoreBinding(),
      middlewares: [LayoutMiddleware()],
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => const ContactView(),
      binding: ContactBinding(),
      middlewares: [LayoutMiddleware()],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      middlewares: [LayoutMiddleware()],
    ),
    GetPage(
      name: _Paths.CARE_GEVERS,
      page: () => const CareGeversView(),
      binding: CareGeversBinding(),
      middlewares: [LayoutMiddleware()],
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_APP,
      page: () => const AboutAppView(),
      binding: AboutAppBinding(),
    ),
    GetPage(
      name: _Paths.PATIENT_INFO,
      page: () => PatientInfoView(),
      binding: PatientInfoBinding(),
    ),
    GetPage(
      name: _Paths.MEDICATIONS,
      page: () => const MedicationsView(),
      binding: MedicationsBinding(),
    ),
    GetPage(
      name: _Paths.MEDICINE_DETAILS,
      page: () => const MedicineDetailsView(),
      binding: MedicineDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MEDICINE_ADD,
      page: () => const MedicineAddView(),
      binding: MedicineAddBinding(),
    ),
    GetPage(
      name: _Paths.DOSES_SCHEDULE,
      page: () => DosesScheduleView(dosesData: []),
    ),
    GetPage(
      name: _Paths.MEDICAL_IMAGES,
      page: () => const MedicalImagesView(),
      binding: MedicalImagesBinding(),
    ),
    GetPage(
      name: _Paths.LABS,
      page: () => const LabsView(),
      binding: LabsBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENTS,
      page: () => AppointmentsView(),
      binding: AppointmentsBinding(),
    ),
  ];
}
