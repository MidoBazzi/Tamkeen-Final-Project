// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/features/serviceproviders/data_layer/models/providers_model.dart';
import 'package:service_provider/features/serviceproviders/data_layer/services/providers_services.dart';

class ProviderController extends GetxController {
  final ProviderService providerService = ProviderService();

  final TextEditingController searchController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<ProviderModel> providersList = <ProviderModel>[].obs;

  RxBool isExpanded = false.obs;
  RxInt selectedTab = 0.obs;
  RxInt currentGalleryIndex = 0.obs;
  var selectedProvider = Rxn<ProviderModel>();

  @override
  void onInit() {
    super.onInit();
    getProviders();
  }

  Future<void> getProviders({String? searchName}) async {
    isLoading.value = true;
    try {
      var data = await providerService.fetchProviders(name: searchName);
      providersList.assignAll(data);
      if (data.isNotEmpty) {
        selectedProvider.value = data[0];
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void searchProviders(String query) {
    if (query.isEmpty) {
      getProviders();
    } else {
      getProviders(searchName: query);
    }
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
