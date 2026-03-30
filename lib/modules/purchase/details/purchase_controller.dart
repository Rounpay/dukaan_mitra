import 'package:get/get.dart';

import '../../../core/network/ui_state.dart';

import '../data/purchase_data_res.dart';
import '../data/purchase_repo.dart';

class PurchaseController extends GetxController{
  final PurchaseRepo repo;
  PurchaseController({required this.repo});
  final loanState = UiState<PurchaseDataRes>.none().obs;

  var loanId = RxInt(Get.arguments['loanId']);

  @override
  void onReady() {
    super.onReady();
    fetchPurchase(loanId.value);
  }
  void fetchPurchase(int loanId) async {
    repo.getLoanDetails(loanId, (state) {
      loanState.value = state;
      state.handleWithErrorBox(
        showLoader: true, (data) {
      },
      );
    });
  }
}