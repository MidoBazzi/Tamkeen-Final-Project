import 'package:flutter/widgets.dart';
import 'package:service_provider/features/settings/presentation_layer/screens/settings_screen.dart';
import 'package:service_provider/features/governmententities/presentation_layer/screens/governmententities_screen.dart';
import 'package:service_provider/features/home/presentation_layer/screens/home_screen.dart';
import 'package:service_provider/features/offer/presentation_layer/screens/offerlistpage.dart';
import 'package:service_provider/features/serviceproviders/presentation_layer/screens/serviceproviders_screen.dart';

class ClassesList {
  static List<Widget> pages = [
    HomeScreen(),
    Offerlistpage(),
    ServiceprovidersScreen(),
    GovernmententitiesScreen(),
    SettingsScreen(),
  ];
}
