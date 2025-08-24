import 'package:flutter/material.dart';
import 'package:mave/toolkit/typs.dart';
import 'package:mave/pages/widgets/comic_grid.dart' show ComicGrid;




//test libs
import 'package:http/http.dart' as http;
import 'package:mave/website/scraper.dart';
//





class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstTimeLoading(),
    );
  }
}



class FirstTimeLoading extends StatelessWidget {
  Future<List<Comic>> _comicListPromise = FirstTimeLoading.loadComics();

  

  FirstTimeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _comicListPromise,
      builder: (context, comicListPromise){
        if (comicListPromise.connectionState == ConnectionState.done){
          return ComicGrid(comicListPromise.data!);
        }
        else return CircularProgressIndicator();
      } 
    );
  }


  static Future<List<Comic>> loadComics() async{
    final resp = await http.get(Uri.parse("https://www.mangaread.org/"));
    return Scraper.comics(resp.body).toList();
  }

}
