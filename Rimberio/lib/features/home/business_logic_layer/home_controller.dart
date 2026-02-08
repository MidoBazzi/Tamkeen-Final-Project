// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/features/home/data_layer/models/slider_model.dart';
import 'package:service_provider/features/home/data_layer/models/tags_model.dart';
import 'package:service_provider/features/home/data_layer/services/home_service.dart';

class HomeController extends GetxController {
  final HomeService home_service = HomeService();

  RxInt selectedindex = 0.obs;
  RxInt currentIndex = 0.obs;
  RxInt selectedCategory = 0.obs;

  RxBool isLoadingSliders = false.obs;
  RxBool isLoadingTags = false.obs;
  RxList<SliderModel> sliders = <SliderModel>[].obs;
  RxList<TagsModel> tags = <TagsModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadSliders();
    loadTags();
  }

  Future<void> loadSliders() async {
    isLoadingSliders.value = true;
    try {
      sliders.value = await home_service.getSliders();
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoadingSliders.value = false;
    }
  }

  Future<void> loadTags() async {
    isLoadingTags.value = true;
    try {
      tags.value = await home_service.getTags();
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoadingTags.value = false;
    }
  }
}
