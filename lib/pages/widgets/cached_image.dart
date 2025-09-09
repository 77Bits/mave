import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mave/website/info.dart' show IMAGE_HEADERS;
import 'package:flutter/material.dart';



class ComicCover extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const ComicCover({
    required this.imageUrl, 
    this.width  = double.infinity,
    this.height = double.infinity,
    super.key
  });



  static final cacheManager = CacheManager(Config(   
      "covers",
      stalePeriod        : const Duration(days: 7),
      maxNrOfCacheObjects: 200,
  ));


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl    : imageUrl,
      cacheManager: cacheManager,
      height      : height,
      width       : width,
      fit         : BoxFit.cover,
      errorWidget : (_, _, error) => Icon(Icons.error),
      httpHeaders : IMAGE_HEADERS,
      
    );
  }
}

