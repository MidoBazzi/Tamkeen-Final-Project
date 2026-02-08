import 'package:get/get.dart';
import 'package:service_provider/features/auth/presentation_layer/screens/changepassword_screen.dart';
import 'package:service_provider/features/auth/presentation_layer/screens/verify_screen.dart';
import 'package:service_provider/features/category/presentation_layer/screens/all_category_screen.dart';
import 'package:service_provider/features/category/presentation_layer/screens/category_screen.dart';
import 'package:service_provider/features/notification/presentation_layer/screens/notification_screen.dart';
import 'package:service_provider/features/serviceproviders/presentation_layer/screens/providerdetail_screen.dart';
import 'package:service_provider/features/settings/presentation_layer/screens/contactus_screen.dart';
import 'package:service_provider/features/settings/presentation_layer/screens/editprofile_screen.dart';
import 'package:service_provider/features/settings/presentation_layer/screens/privacy_policy_screen.dart';
import 'package:service_provider/features/settings/presentation_layer/screens/settings_screen.dart';
import 'package:service_provider/features/auth/presentation_layer/screens/forgetpassword_screen.dart';
import 'package:service_provider/features/auth/presentation_layer/screens/login_screen.dart';
import 'package:service_provider/features/auth/presentation_layer/screens/provider_screen.dart';
import 'package:service_provider/features/auth/presentation_layer/screens/register_screen.dart';
import 'package:service_provider/features/auth/presentation_layer/screens/resetpassword_screen.dart';
import 'package:service_provider/features/governmententities/presentation_layer/screens/governmententities_screen.dart';
import 'package:service_provider/features/home/presentation_layer/screens/home_screen.dart';
import 'package:service_provider/features/home/presentation_layer/screens/super_home.dart';
import 'package:service_provider/features/offer/presentation_layer/screens/offerlistpage.dart';
import 'package:service_provider/features/serviceproviders/presentation_layer/screens/serviceproviders_screen.dart';
import 'package:service_provider/features/splash/presentation_layer/screens/splash_screen.dart';

class RoutingManager {
  static String splashScr = '/';
  static String loginScr = '/Login';
  static String registerScr = '/SignUp';
  static String verifyScr = '/verifyScreen';
  static String forgetpassword = '/Forgetpassword';
  static String resetPassword = '/ResetPassword';
  static String superHome = '/SuperHome';
  static String homeScr = '/Home';
  static String providerScr = '/Provider';
  static String offer = '/Offer';
  static String serviceproviders = '/Serviceproviders';
  static String governmententities = '/Governmententities';
  static String settings = '/SettingsPage';
  static String privacyScr = '/PrivacyPolicy';
  static String contactUsScr = '/ContactUs';
  static String changepasswordScr = '/ChangepasswordScreen';
  static String editprofileScr = '/EditprofileScreen';
  static String notificationScr = '/NotificationScreen';
  static String allCategoryScr = '/AllCategoryScreen';
  static String categoryScreen = '/CategoryScreen';
  static String providerdetailScr = '/ProviderdetailScreen';

  static List<GetPage> getPages() {
    return [
      GetPage(name: splashScr, page: () => SplashScreen()),
      GetPage(name: loginScr, page: () => LoginScreen()),
      GetPage(name: registerScr, page: () => RegisterScr()),
      GetPage(
        name: verifyScr,
        page: () => VerifyScreen(phone: Get.arguments as String),
      ),
      GetPage(name: forgetpassword, page: () => ForgetpasswordScreen()),
      GetPage(
        name: resetPassword,
        page: () => ResetpasswordScreen(phone: Get.arguments as String),
      ),
      GetPage(name: superHome, page: () => SuperHome()),
      GetPage(name: homeScr, page: () => HomeScreen()),
      GetPage(name: providerScr, page: () => ProviderScreen()),
      GetPage(name: offer, page: () => Offerlistpage()),
      GetPage(name: serviceproviders, page: () => ServiceprovidersScreen()),
      GetPage(name: governmententities, page: () => GovernmententitiesScreen()),
      GetPage(name: settings, page: () => SettingsScreen()),
      GetPage(name: privacyScr, page: () => PrivacyPolicyScreen()),
      GetPage(name: contactUsScr, page: () => ContactusScreen()),
      GetPage(name: changepasswordScr, page: () => ChangepasswordScreen()),
      GetPage(name: editprofileScr, page: () => EditprofileScreen()),
      GetPage(name: notificationScr, page: () => NotificationScreen()),
      GetPage(name: allCategoryScr, page: () => AllCategoryScreen()),
      GetPage(name: providerdetailScr, page: () => ProviderdetailScreen()),
      GetPage(name: categoryScreen, page: () => CategoryScreen()),
    ];
  }
}
