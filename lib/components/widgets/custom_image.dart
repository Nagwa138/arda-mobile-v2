import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_shimmer.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.radius,
    this.placeholder,
    this.errorWidget,
    this.bytes,
    this.showLoading = true,
  });

  /// Main image path (asset, network, file, svg, etc.)
  final String? path;

  /// Local image bytes (for memory images)
  final Uint8List? bytes;

  /// Dimensions
  final double? width;
  final double? height;

  /// Image fit style
  final BoxFit fit;

  /// Optional color overlay
  final Color? color;

  /// Optional border radius
  final double? radius;

  /// Custom placeholder while loading
  final Widget? placeholder;

  /// Custom error widget
  final Widget? errorWidget;

  /// Show CircularProgressIndicator while loading
  final bool showLoading;

  bool get isSvg => path?.toLowerCase().endsWith('.svg') ?? false;
  bool get isNetwork => path?.startsWith('http') ?? false;
  bool get isFile =>
      path?.startsWith('/') ?? false || (path?.startsWith('file://') ?? false);
  bool get isAsset => !isNetwork && !isFile && bytes == null;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? 0);
    final colorFilter =
        color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null;

    Widget imageWidget;

    if (bytes != null) {
      imageWidget = Image.memory(
        bytes!,
        width: width,
        height: height,
        fit: fit,
        color: color);
    } else if (path == null || path!.isEmpty || path == "null") {
      // Handle null or empty path with fallback logo
      imageWidget = Image.asset(
        'assets/images/ard_logo.png',
        width: width,
        height: height,
        fit: fit,
        color: color);
    } else if (isNetwork) {
      imageWidget = isSvg
          ? SvgPicture.network(
              path!,
              width: width,
              height: height,
              fit: fit,
              colorFilter: colorFilter,
              placeholderBuilder: (_) => _loadingWidget())
          : CachedNetworkImage(
              imageUrl: path!,
              width: width,
              height: height,
              fit: fit,
              color: color,
              placeholder: (_, __) => placeholder ?? _loadingWidget(),
              errorWidget: (_, __, ___) =>
                  errorWidget ?? _errorFallback(context));
    } else if (isFile) {
      final file = File(path!.replaceFirst('file://', ''));
      imageWidget = isSvg
          ? SvgPicture.file(
              file,
              width: width,
              height: height,
              fit: fit,
              colorFilter: colorFilter)
          : Image.file(
              file,
              width: width,
              height: height,
              fit: fit,
              color: color);
    } else if (isSvg) {
      imageWidget = SvgPicture.asset(
        path!,
        width: width,
        height: height,
        fit: fit,
        colorFilter: colorFilter);
    } else {
      imageWidget = Image.asset(
        path!,
        width: width,
        height: height,
        fit: fit,
        color: color);
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: imageWidget);
  }

  Widget _loadingWidget() => showLoading
      ? CustomShimmer(
          width: width,
          height: height,
          shape: radius != null && radius! > 0
              ? BoxShape.rectangle
              : BoxShape.rectangle)
      : const SizedBox.shrink();

  Widget _errorFallback(BuildContext context) => Icon(
        Icons.broken_image,
        color: Colors.grey.shade400,
        size: width != null ? width! * 0.6 : 40,
      );
}
