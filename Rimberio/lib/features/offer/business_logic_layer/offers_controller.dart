import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/features/offer/data_layer/models/offers_model.dart';
import 'package:service_provider/features/offer/data_layer/services/offers_service.dart';

class OffersController extends GetxController {
  final OffersService offersService = OffersService();
  final TextEditingController searchController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<OfferModel> offers = <OfferModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOffers();
  }

  Future<void> loadOffers({String? name}) async {
    isLoading.value = true;
    try {
      offers.value = await offersService.getOffers(name: name);
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoading.value = false;
    }
  }

  void searchOffers(String query) {
    if (query.isEmpty) {
      loadOffers();
    } else {
      loadOffers(name: query);
    }
  }
}
