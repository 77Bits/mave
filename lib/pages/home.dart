import 'package:flutter/material.dart';
import 'package:mave/pages/widgets/comic_grid.dart' show ComicGrid;
import 'package:mave/toolkit/toolkit.dart' show loadComics, Comic;






class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstTimeLoading(),
    );
  }
}



class FirstTimeLoading extends StatelessWidget {
  Future<List<Comic>> _comicListPromise = loadComics(0);

  

  FirstTimeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _comicListPromise,
      builder: (context, comicListPromise){
        if (comicListPromise.connectionState == ConnectionState.done){
          if (!comicListPromise.hasError)
            return ComicGrid(comicListPromise.data!);
          return Text(comicListPromise.error!.toString());
        }
        else return CircularProgressIndicator();
      } 
    );
  }



}
