import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mave/typs.dart' show Comic;



class ComicGrid extends StatelessWidget {
  final List<Comic> _comicList;


  const ComicGrid(this._comicList, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing   : 4,
        crossAxisSpacing  : 4,
        childAspectRatio  : 0.7,
      ),
      itemCount  : _comicList.length,
      itemBuilder: (context, index){
        final cm = _comicList[index];
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
  final String image_url;

  const _GridCachedImage(this.image_url, {super.key});



  static final cacheManager = CacheManager(Config(   
      "covers",
      stalePeriod        : const Duration(days: 7),
      maxNrOfCacheObjects: 130,
  ));


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl    : image_url,
      cacheManager: cacheManager,
      height      : double.infinity,
      width       : double.infinity,
      fit         : BoxFit.cover,
      placeholder : (_, _) => imageWaitingAnimation,
      errorWidget : (_, _, error) => Icon(Icons.error),
    );
  }


 


  static const imageWaitingAnimation = Center(
    child: SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(),
    ),
  );

}



