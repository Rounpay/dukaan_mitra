/*
import '../../../../core/managers/network_manager.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/base_res.dart';
import '../../../../core/network/ui_state.dart';
import '../model/fi_assignment_model.dart';
import '../model/fi_dashboard_data.dart';

class FiInspectorRepo {
  Future<void> getMyAssignments(
    void Function(UiState<List<FiAssignmentModel>>) callback,
  ) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }

    final res = await ApiClient.to.getMyAssignments();

    if (res.success == true && res.data != null) {
      callback(UiState.success(res.data!));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
  Future<void> getFiDashboard(
      void Function(UiState<FiDashboardData>) callback,) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }
    final res = await ApiClient.to.getFiDashboard();
    if (res.success == true && res.data != null) {
      callback(UiState.success(res.data!));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
  Future<void> submitReport({
    required int assignmentId,
    required String remarks,
    required String imagePath,
    required void Function(UiState<BaseRes>) callback,
  }) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }

    final res = await ApiClient.to.submitReport(
      assignmentId: assignmentId,
      remarks: remarks,
      imagePath: imagePath,
    );

    if (res.success == true) {
      callback(UiState.success(res));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
}
*/
