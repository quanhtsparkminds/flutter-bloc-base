import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/app_image/image.type.dart';
import 'package:myapp/shared/widgets/skeleton_loader/skeleton_loader.dart';

class AppImageView extends StatelessWidget {
  const AppImageView(
      {super.key,
      required this.imagePath,
      required this.height,
      required this.width,
      this.color,
      this.fit,
      this.alignment,
      this.onTap,
      this.margin,
      this.radius,
      this.border,
      this.errorBuilder,
      this.imageType = ImageType.unknown,
      this.isForcePaddingErrorImage = true,
      this.padding});

  final String imagePath;
  final ImageType imageType;
  final double height;
  final double width;
  final Color? color;
  final BoxFit? fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? radius;
  final BoxBorder? border;
  final Widget? errorBuilder;
  final bool isForcePaddingErrorImage;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  _buildImageView() {
    switch (imageType) {
      case ImageType.svg:
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imagePath,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            colorFilter: color != null
                ? ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcIn)
                : null,
          ),
        );
      case ImageType.file:
        return Image.file(
          File(imagePath),
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: imagePath,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          progressIndicatorBuilder: (context, url, progress) =>
              const Center(child: SkeletonLoader()),
          errorWidget: (context, error, stackTrace) {
            return errorBuilder ??
                Image.asset(
                  Assets.images.avatarFake.path,
                  width: width,
                );
          },
        );

      case ImageType.png:
      default:
        return Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          color: color,
          errorBuilder: (context, error, stackTrace) {
            return errorBuilder ??
                Image.asset(
                  Assets.images.avatarFake.path,
                  width: width,
                );
          },
        );
    }
  }
}
