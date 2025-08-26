import 'package:http/http.dart' as http;
import 'package:mave/toolkit/toolkit.dart';
import 'package:mave/website/scraper.dart';




Future<List<Comic>> loadComics(int page) async{
  return await ComicDb.self.getComicsWithOffset(page);
}



Future<void> fillEmptyDatabase() async{
  final comicsFromDb = await ComicDb.self.getComicsWithOffset(0);
  if (comicsFromDb.length == 0){
    final resp = await http.get(Uri.parse("https://mangapill.com/chapters"));
    final comicsFromRemote = Scraper.comics(resp.body).toList();
    await ComicDb.self.addComics(comicsFromRemote);
  }
}
