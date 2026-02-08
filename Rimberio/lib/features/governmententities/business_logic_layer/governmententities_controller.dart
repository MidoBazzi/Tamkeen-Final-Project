import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/core/const/app_icon.dart';
import 'package:service_provider/features/governmententities/data_layer/models/government_entity_model.dart';
import 'package:service_provider/features/governmententities/data_layer/services/governmententities_service.dart';

class GovernmententitiesController extends GetxController {
  var govEntities = <GovernmentEntityModel>[].obs;
  var isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  final GovernmententitiesService entityService = GovernmententitiesService();

  @override
  void onInit() {
    fetchGovEntities();
    super.onInit();
  }

  Future<void> fetchGovEntities({String? name}) async {
    isLoading.value = true;
    try {
      var result = await entityService.getGovernmentEntities(name: name);
      govEntities.assignAll(result);
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoading.value = false;
    }
  }

  void searchEntities(String query) {
    if (query.trim().isEmpty) {
      fetchGovEntities();
    } else {
      fetchGovEntities(name: query);
    }
  }

  String mapIcon(String type) {
    switch (type.tr()) {
      case 'PHONE':
        return AppIcon.call;
      case 'FACEBOOK':
        return AppIcon.facebook;
      case 'INSTAGRAM':
        return AppIcon.instagram;
      default:
        return AppIcon.call;
    }
  }
}
