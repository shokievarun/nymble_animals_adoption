import 'package:animals_adoption_flutter/constants/assets_paths.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class GetNetworkImage extends StatelessWidget {

  final String url;

  const GetNetworkImage({
    Key? key,
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.contain,
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(
          value: progress.progress,
          backgroundColor: ThemeColors.accent.withOpacity(0.5),
          color: ThemeColors.accentForText,
        ),
      ),
      errorWidget: (context, url, error) => Image.asset('$illustrationsPath/error.jpg'),
    );
  }
}