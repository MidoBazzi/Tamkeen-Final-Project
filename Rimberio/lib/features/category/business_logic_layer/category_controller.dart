// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:service_provider/core/routing/routing_manager.dart';
import 'package:service_provider/features/category/data_layer/models/category_model.dart';
import 'package:service_provider/features/category/data_layer/models/sub_category_model.dart';
import 'package:service_provider/features/category/data_layer/services/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService category_service = CategoryService();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController subSearchController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxInt selectedCategory = 0.obs;

  RxBool isLoadingSub = false.obs;
  RxList<SubCategoryModel> subCategories = <SubCategoryModel>[].obs;
  RxInt selectedSubCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories({String? name}) async {
    isLoading.value = true;
    try {
      categories.value = await category_service.getCategories(name: name);
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoading.value = false;
    }
  }

  void searchCategories(String query) {
    loadCategories(name: query);
  }

  void navigateBasedOnCategory(CategoryModel category) {
    Get.toNamed(RoutingManager.categoryScreen, arguments: category);
  }

  //-----------------------------------------------------------------------------------------------------

  Future<void> loadSubCategories(int categoryId, {String? name}) async {
    isLoadingSub.value = true;
    try {
      subCategories.value = await category_service.getSubCategories(
        categoryId,
        name: name,
      );
    } catch (e) {
      Get.snackbar('Error'.tr(), e.toString().tr());
    } finally {
      isLoadingSub.value = false;
    }
  }

  void searchSubCategories(int categoryId, String query) {
    loadSubCategories(categoryId, name: query);
  }
}
