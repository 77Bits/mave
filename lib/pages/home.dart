import 'package:flutter/material.dart';
import 'package:mave/typs.dart';

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


class ComicGrid extends StatelessWidget {
  final List<Comic> _comicList;


  const ComicGrid(this._comicList, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing:4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.7,
      ),
      itemCount: _comicList.length,
      itemBuilder: (context, index){
        var cm = _comicList[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(7.14),
          child: ColoredBox(
            color: Colors.green,
            child:Column(
              mainAxisSize:MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Image.network(
                    cm.cover,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.3, vertical: 0.8),
                  child: Text(
                    cm.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
