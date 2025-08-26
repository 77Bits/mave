import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mave/toolkit/typs.dart' show Comic;
import 'package:mave/website/info.dart' show IMAGE_HEADERS;



class ComicGrid extends StatelessWidget {
  final List<Comic> comics;
  final ScrollController controller;


  const ComicGrid({
    required this.comics,
    required this.controller,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing   : 4,
        crossAxisSpacing  : 4,
        childAspectRatio  : 0.7,
      ),
      controller : controller,
      itemCount  : comics.length,
      itemBuilder: (context, index){
        final cm = comics[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(7.14),
          child: ColoredBox(
            color: Colors.green,
            child:Column(
              mainAxisSize:MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: _GridCachedImage(cm.cover)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.3, vertical: 0.8),
                  child: Text(
                    cm.title,
                    maxLines : 1,
                    overflow : TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  )
                )
              ],
            )
          )
        );
      },
    );
  }
  
}



class _GridCachedImage extends StatelessWidget {
  final String imageUrl;

  const _GridCachedImage(this.imageUrl, {super.key});



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
      height      : double.infinity,
      width       : double.infinity,
      fit         : BoxFit.cover,
      placeholder : (_, _) => _imageWaitingAnimation,
      errorWidget : (_, _, error) => Icon(Icons.error),
      httpHeaders : IMAGE_HEADERS,
      
    );
  }




  static const _imageWaitingAnimation = Center(
    child: SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(),
    ),
  );

}



