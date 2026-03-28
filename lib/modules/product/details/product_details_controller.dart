import 'package:get/get.dart';
import '../../../core/network/base_res.dart';
import '../../../core/network/ui_state.dart';
import '../../../core/utils/common_methods.dart';
import '../data/model/product_detail_model.dart';
import '../data/repo/product_detail_repo.dart';

class ProductDetailsController extends GetxController{
  final ProductDetailsRepo repo;
  ProductDetailsController({required this.repo});
  final productDetailsState =  UiState<ProductDetailModel>.loading().obs;
  final loanApplyState =  UiState<BaseRes>.none().obs;
  //final emiPlansState =  UiState<List<EmiPlanModel>>().obs;
  final currentIndex = 0.obs;
  void updateIndex(int index) {
    currentIndex.value = index;
  }
  var productId = RxInt(Get.arguments['productId']);

 @override
 void onReady() {
    super.onReady();
    fetchProduct(productId.value);
  }

  void fetchProduct(int productId) async {
    repo.getProductDetails(productId, (state) {
      productDetailsState.value = state;
      state.handleWithErrorBox(
        showLoader: true, (data) {
          },
      );
    });
 }

 void purchaseApply() async {
    repo.loanApply({
      "productId": productId.value
    }, (state) {
      loanApplyState.value = state;
      state.handleWithErrorBox(
          showLoader: false, (data) async {
        showSuccessDialog(data.message ?? "Application submitted successfully");      });
    });
 }

}