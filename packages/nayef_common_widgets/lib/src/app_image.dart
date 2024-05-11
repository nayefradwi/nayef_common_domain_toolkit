import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final double? scale;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext)? placeholderBuilder;

  const AppImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.scale,
    this.color,
    this.blendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.errorBuilder,
    this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return _AssetSvg(
        path: path,
        width: width,
        height: height,
        color: color,
        blendMode: blendMode,
        placeholderBuilder: placeholderBuilder,
        fit: fit ?? BoxFit.contain,
        alignment: alignment,
      );
    }
    return _AssetImage(
      path: path,
      width: width,
      height: height,
      color: color,
      blendMode: blendMode,
      fit: fit ?? BoxFit.contain,
      alignment: alignment,
      repeat: repeat,
      errorBuilder: errorBuilder,
      scale: scale,
    );
  }

  bool get _isSvg => path.endsWith('.svg');
}

class _AssetImage extends StatelessWidget {
  const _AssetImage({
    required this.path,
    required this.width,
    required this.height,
    required this.scale,
    required this.color,
    required this.blendMode,
    required this.fit,
    required this.alignment,
    required this.repeat,
    required this.errorBuilder,
  });

  final String path;
  final double? width;
  final double? height;
  final double? scale;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      scale: scale,
      color: color,
      colorBlendMode: blendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      errorBuilder: errorBuilder,
    );
  }
}

class _AssetSvg extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  final Widget Function(BuildContext)? placeholderBuilder;
  const _AssetSvg({
    required this.path,
    required this.width,
    required this.height,
    required this.color,
    required this.blendMode,
    required this.placeholderBuilder,
    required this.fit,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    ColorFilter? colorFilter;
    if (blendMode != null && color != null) {
      colorFilter = ColorFilter.mode(color!, blendMode!);
    }
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      placeholderBuilder: placeholderBuilder,
      colorFilter: colorFilter,
    );
  }
}
