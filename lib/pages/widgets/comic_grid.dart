import 'package:flutter/material.dart';
import 'package:mave/modules/modules.dart' show Comic, ComicLabel;
import 'cached_image.dart' show ComicCover;



class ComicGrid extends StatelessWidget {
  final List<Comic> comics;
  final ScrollController controller;
  final Map<String, ComicLabel> comicLabel;

  final void Function(BuildContext, Comic)? onTap;


  const ComicGrid({
    required this.comics,
    required this.controller,
    this.comicLabel = const {},
    this.onTap,
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
        return GestureDetector(
          onTap: (){if (onTap != null) onTap!(context, cm);},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.14),
            child: ColoredBox(
              color: Colors.green,
              child: Stack(
                children: [
                  ComicCover(imageUrl: cm.cover),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 20,
                    child: _GridPaddedText(cm.title),
                  ),
                  if (comicLabel.containsKey(cm.url)) Icon(Icons.new_label),
                ],
              )
            )
          )
        );
      },
    );
  }
}


class _GridPaddedText extends StatelessWidget{
  final String title;

  _GridPaddedText(this.title, {super.key});


  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.withOpacity(0.7),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.3, vertical: 0.8),
        child: Text(
          title,
          maxLines : 1,
          overflow : TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        )
      )
    );
  }

}






