import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:flutter_demo/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_demo/route/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/common_controller.dart';
import '../../../core/theme/theme_colors.dart';
import '../../../core/widgets/custom_dialog.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../core/widgets/text_field_with_label.dart';

class ProfileDetailsScreen extends GetView<DashboardController> {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text("Profile", style: context.textStyle.titleLarge),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileCard(context),
                Spacing.h32,
                _buildMenuCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
       Obx((){
         return CommonController.to.profileState.value.when(
           success: (data){
             return Column(
               children: [
                 Center(
                   child: CircleAvatar(
                     radius: 36,
                     backgroundColor: context.colorScheme.surfaceContainerHighest,
                     child: Icon(
                       Icons.person,
                       size: 36,
                       color: context.colorScheme.onSurfaceVariant,
                     ),
                   ),
                 ),
                 Spacing.h8,
                 Text(data.fullName??"", style: context.textStyle.titleMedium),
                 Text(data.email??"", style: context.textStyle.bodySmall),
                 Text(data.mobileNumber??"", style: context.textStyle.bodySmall),
               ],
             );
           },
           error: (error)=>ErrorTextWidget(msg: error),
           loading: ()=>Loader(),
           none: ()=>SizedBox()
       );
       }),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Get.toNamed(AppRoutes.updateProfile);
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          _menuTile(
            context,
            icon: Icons.person_outline,
            iconBg: ThemeColors.colorGreen.withOpacity(0.1),
            iconColor: ThemeColors.colorGreen,
            title: 'Update Profile',
            onTap: () {
              Get.toNamed(AppRoutes.updateProfile);
            },
          ),

          _divider(context),

          _menuTile(
            context,
            icon: Icons.lock_outline,
            iconBg: ThemeColors.colorGold.withOpacity(0.1),
            iconColor: ThemeColors.colorGold,
            title: 'Change Password',
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => passwordDialog(context),
              );
            },
          ),
          _divider(context),

          _menuTile(
            context,
            icon: Icons.logout,
            iconBg: ThemeColors.colorRed.withOpacity(0.1),
            iconColor: ThemeColors.colorRed,
            title: 'Logout',
            titleColor: ThemeColors.colorRed,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => CustomDialog(
                  title: 'Sure you want to Log-out ?',
                  icon: Icons.block,
                  iconColor: ThemeColors.colorRed,
                  primaryBtnText: 'Yes',
                  onPrimaryPressed: () {
                    CommonController.to.logout();
                    Get.back();
                  },
                  onCancelPressed: () {
                    Get.back();
                  },
                ),
              );
            },
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    String? subtitle,
    Color? titleColor,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: iconBg,
                child: Icon(icon, color: iconColor, size: 20),
              ),
              Spacing.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textStyle.titleSmall?.copyWith(
                        color: titleColor ?? context.colorScheme.onSurface,
                      ),
                    ),
                    if (subtitle != null)
                      Text(subtitle, style: context.textStyle.labelSmall),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );}
  Widget _divider(BuildContext context) => Divider(
    height: 1,
    indent: 10,
    endIndent: 10,
    color: context.colorScheme.outlineVariant,
  );
  Widget passwordDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Change password', style: context.textStyle.titleSmall),
                Spacing.h16,
            
                /// OLD PASSWORD
                PassWordTextFormFieldWithLabel(
                  controller: controller.oldPasswordController,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  hint: "Enter Old Password",
                  textInputFormatter: [LengthLimitingTextInputFormatter(16)],
                  validator: (value) {
                    if ((value ?? '').isEmpty) return "Enter old password";
                    if (value!.length < 6) return "Minimum 6 characters";
                    return null;
                  },
                ),
            
                Spacing.h8,
            
                /// NEW PASSWORD
                PassWordTextFormFieldWithLabel(
                  controller: controller.newPasswordController,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  hint: "Enter New Password",
                  textInputFormatter: [LengthLimitingTextInputFormatter(16)],
                  validator: (value) {
                    if ((value ?? '').isEmpty) return "Enter new password";
                    if (value!.length < 6) return "Minimum 6 characters";
                    return null;
                  },
                ),
            
                Spacing.h8,
            
                /// CONFIRM PASSWORD
                PassWordTextFormFieldWithLabel(
                  controller: controller.confirmPasswordController,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  hint: "Re-enter New Password",
                  textInputFormatter: [LengthLimitingTextInputFormatter(16)],
                  validator: (value) {
                    if ((value ?? '').isEmpty) return "Confirm password";
                    if (value!.length < 6) return "Minimum 6 characters";
                    if (value != controller.newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
            
                Spacing.h16,
            
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        radius: 10,
                        onPressed: () => Get.back(),
                        text: "Cancel",
                        backgroundColor:
                        context.colorScheme.surfaceContainerHighest,
                        foregroundColor: context.colorScheme.onSurface,
                      ),
                    ),
                    Spacing.w8,
            
                    /// DONE BUTTON
                    Expanded(
                      child: Obx(() {
                        final isLoading =
                            controller.changePasswordState.value.isLoading;
            
                        return RoundedButton(
                          radius: 10,
                          onPressed: isLoading
                              ? null
                              : () {
                            if (formKey.currentState!.validate()) {
                              controller.changePassword();
                            }
                          },
                          text: isLoading ? "Please wait..." : "Done",
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary,
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
