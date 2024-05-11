import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Widget Function(BuildContext context, Object, StackTrace?)?
      errorBuilder;
  final Widget Function(BuildContext, String, DownloadProgress)? loadingBuilder;
  final Widget Function(BuildContext)? svgPlaceHolderBuilder;
  final Map<String, String>? headers;

  const AppNetworkImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.blendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.errorBuilder,
    this.loadingBuilder,
    this.svgPlaceHolderBuilder,
    this.headers,
  });

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return _NetworkSvg(
        url: url,
        width: width,
        height: height,
        color: color,
        blendMode: blendMode,
        placeholderBuilder: svgPlaceHolderBuilder,
        fit: fit ?? BoxFit.contain,
        alignment: alignment,
        headers: headers,
      );
    }
    return _NetworkImage(
      url: url,
      width: width,
      height: height,
      color: color,
      blendMode: blendMode,
      fit: fit ?? BoxFit.contain,
      alignment: alignment,
      repeat: repeat,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
      headers: headers,
    );
  }

  bool get _isSvg => url.endsWith('.svg');
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage({
    required this.url,
    required this.width,
    required this.height,
    required this.color,
    required this.blendMode,
    required this.fit,
    required this.alignment,
    required this.repeat,
    required this.errorBuilder,
    required this.loadingBuilder,
    required this.headers,
  });

  final String url;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, String, DownloadProgress)? loadingBuilder;
  final Map<String, String>? headers;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      color: color,
      colorBlendMode: blendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      errorWidget: errorBuilder == null
          ? null
          : (context, _, __) => errorBuilder!(context, _, null),
      progressIndicatorBuilder: loadingBuilder ??
          (context, _, __) => Container(
                color: Colors.white,
                height: height ?? double.infinity,
                width: width ?? double.infinity,
              ),
      httpHeaders: headers,
    );
  }
}

class _NetworkSvg extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final Widget Function(BuildContext)? placeholderBuilder;
  final Map<String, String>? headers;
  const _NetworkSvg({
    required this.url,
    required this.width,
    required this.height,
    required this.color,
    required this.blendMode,
    required this.placeholderBuilder,
    required this.fit,
    required this.alignment,
    required this.headers,
  });

  @override
  Widget build(BuildContext context) {
    ColorFilter? colorFilter;
    if (blendMode != null && color != null) {
      colorFilter = ColorFilter.mode(color!, blendMode!);
    }
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      placeholderBuilder: placeholderBuilder,
      colorFilter: colorFilter,
      headers: headers,
    );
  }
}
