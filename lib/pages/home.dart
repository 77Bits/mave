import 'package:flutter/material.dart';
import 'package:mave/toolkit/typs.dart';
import 'package:mave/pages/widgets/comic_grid.dart' show ComicGrid;


import 'package:mave/toolkit/tools/load_comics.dart' as tools;






class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstTimeLoading(),
    );
  }
}



class FirstTimeLoading extends StatelessWidget {
  Future<List<Comic>> _comicListPromise = tools.loadComics(0);

  

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
