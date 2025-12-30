import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hanuman_mandir/src/core/const/app_colors.dart';
import 'package:image_network/image_network.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty || !imageUrl.startsWith('http')) {
      return SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.broken_image, color: Colors.grey),
      );
    }

    // --- WEB IMPLEMENTATION (Bypassing CORS using HTML Image) ---
    if (kIsWeb) {
      return ImageNetwork(
        image: imageUrl,
        height: height ?? 100,
        width: width ?? 100,
        fitAndroidIos: fit,
        fitWeb: _mapBoxFitToWeb(fit),
        onLoading: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.deepPurple,
          ),
        ),
        onError: const Icon(Icons.image_not_supported, color: Colors.red),
      );
    }

    // --- MOBILE IMPLEMENTATION (High Performance Caching to load images fast) ---
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryRed,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
          const Icon(Icons.image_not_supported, color: Colors.red),
    );
  }

  // Helper to map Flutter BoxFit to ImageNetwork WebFit
  BoxFitWeb _mapBoxFitToWeb(BoxFit fit) {
    switch (fit) {
      case BoxFit.contain:
        return BoxFitWeb.contain;
      case BoxFit.cover:
        return BoxFitWeb.cover;
      case BoxFit.fill:
        return BoxFitWeb.fill;
      case BoxFit.scaleDown:
        return BoxFitWeb.scaleDown;
      case BoxFit.fitHeight:
      case BoxFit.fitWidth:
      case BoxFit.none:
        return BoxFitWeb.contain;
    }
  }
}
