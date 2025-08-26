import 'package:http/http.dart' as http;
import 'package:mave/toolkit/database/comic.dart';
import 'package:mave/toolkit/typs.dart';
import 'package:mave/website/scraper.dart';





Future<List<Comic>> loadComics(int page) async{
  final comicsFromDb = await ComicDb.self.getComicsWithOffset(page);
  if (page == 0 && comicsFromDb.length == 0){
    final resp = await http.get(Uri.parse("https://mangapill.com/chapters"));
    final comicsFromRemote = Scraper.comics(resp.body).toList();
    await ComicDb.self.addComics(comicsFromRemote);
    return await ComicDb.self.getComicsWithOffset(page);
  }
  else 
    return comicsFromDb;
}
