/// @Created by akash on 16-02-2024.
/// Know more about author at https://akash.cloudemy.in

import 'package:flutter/foundation.dart';
import 'package:flutter_demo/modules/auth/data/document_type_response.dart';
import 'package:flutter_demo/modules/dashboard/data/models/brand_response.dart';
import 'package:flutter_demo/modules/dashboard/data/models/product_category_res.dart';
import 'package:flutter_demo/modules/dashboard/data/models/product_response.dart';
import 'package:get/get.dart';


import '../../core/constants/app_constants.dart';
import '../../core/utils/printer.dart';
import '../../data/models/user_data.dart';
import '../../modules/profile/data/model/user_profile_model.dart';
import '../common_controller.dart';
import '../utils/common_methods.dart';
import 'api_response_handler.dart';
import 'base_res.dart';

class ApiClient extends GetConnect with Printer {
  static ApiClient get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = BASE_URL;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 60);

    httpClient.addRequestModifier<dynamic>((request) {
/*      request.headers['appVersion'] = '5';
      request.headers['timezone'] = getTimeZoneOffset();*/
      if (CommonController.to.userData.value?.accessToken != null) {
        request.headers['Authorization'] =
            'Bearer ${CommonController.to.userData.value?.accessToken}';
      }
      if (kDebugMode) {
        printRequest(request);
      }
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        CommonController.to.clearData(showLogin: true);
      }
      if (kDebugMode) {
        printResponse(response, request);
      }
      return response;
    });

    super.onInit();
  }

  Future<BaseDataRes<UserData>> logIn(Object body) async {
    final response = await post('Auth/login', body);
    return ApiResponseHandler.parse<UserData>(
      response,
      (json) => UserData.fromJson(json),
    );
  }
  Future<BaseRes> customerSignup(FormData body) async {
    final response = await post("Customer/signup", body);
    return ApiResponseHandler.parseBaseRes(response);
  }

  Future<BaseDataRes<List<DocumentTypeResponse>>> getDocumentTypeRepo() async {
    final response = await get('Customer/required-documents');
    return ApiResponseHandler.parse<List<DocumentTypeResponse>>(
      response,
          (json) => (json as List<dynamic>)
          .map((e) => DocumentTypeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<BaseRes> logout() async {
    final response = await post('Auth/logout', {});
    return ApiResponseHandler.parseBaseRes(response);
  }

  Future<BaseDataRes<UserProfileModel>> getUserProfile() async {
    final response = await get('Customer/my-profile');
    return ApiResponseHandler.parse<UserProfileModel>(
      response,
          (json) => UserProfileModel.fromJson(json as Map<String, dynamic>),
    );
  }
  Future<BaseDataRes<List<ProductResponse>>> getProducts({
    int? categoryId,
    int? brandId,
    double? minPrice,
    double? maxPrice,
    String? search,
  }) async {
    final query = {
      if (categoryId != null) "CategoryId": categoryId.toString(),
      if (brandId != null) "BrandId": brandId.toString(),
      if (minPrice != null) "MinPrice": minPrice.toString(),
      if (maxPrice != null) "MaxPrice": maxPrice.toString(),
      if (search != null && search.isNotEmpty) "Search": search,
    };
    final response = await get('Product', query: query);
    return ApiResponseHandler.parse<List<ProductResponse>>(
      response,
          (json) => (json as List<dynamic>)
          .map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  Future<BaseDataRes<List<BrandResponse>>> getBrand() async {
    final response = await get('Brand');
    return ApiResponseHandler.parse<List<BrandResponse>>(
      response,
          (json) => (json as List<dynamic>)
          .map((e) => BrandResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<BaseDataRes<List<ProductCategoryRes>>> getCategories() async {
    final response = await get('Category');
    return ApiResponseHandler.parse<List<ProductCategoryRes>>(
      response,
          (json) => (json as List<dynamic>)
          .map((e) => ProductCategoryRes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
