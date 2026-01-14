import 'package:PassPort/components/color/color.dart';
import 'package:PassPort/components/widgets/custom_image.dart';
import 'package:PassPort/version2_module/core/enums/snack_bar_type.dart';
import 'package:PassPort/version2_module/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SnackBarWidget extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const SnackBarWidget({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: _buildBoxDecoration(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [_buildAppLogo(context), _buildContent(context)]));
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          blurRadius: 8,
          spreadRadius: 2,
          offset: const Offset(0, 3)),
      ]);
  }

  Positioned _buildAppLogo(BuildContext context) {
    return Positioned(
      right: -10,
      top: -50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CustomImage(
          AppImages.imagesLogo,
          height: 70,
          color: Colors.black)));
  }

  Column _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildIcon(), const Gap(8), _buildMessageText(context)]),
      ]);
  }

  SvgPicture _buildIcon() {
    return SvgPicture.asset(_getIconAsset(), height: 25);
  }

  String _getIconAsset() {
    switch (type) {
      case SnackBarType.error:
        return AppImages.imagesErrorIcon;
      case SnackBarType.success:
        return AppImages.imagesSuccessIcon;
      default:
        return AppImages.imagesPendingIcon;
    }
  }

  Widget _buildMessageText(BuildContext context) {
    return Expanded(
      child: Text(
        message,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: appTextColor)));
  }
}
