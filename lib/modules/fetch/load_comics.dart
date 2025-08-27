import 'package:http/http.dart' as http;
import 'package:mave/modules/modules.dart';
import 'package:mave/website/scraper.dart';




Future<List<Comic>> loadComics(int page) async{
  return await ComicDb.self.getComicsWithOffset(page);
}



Future<void> fillEmptyDatabase() async{
  final comicsFromDb = await ComicDb.self.getComicsWithOffset(0);
  if (comicsFromDb.isEmpty){
    final resp = await http.get(Uri.parse("https://mangapill.com/chapters"));
    final resp2 = await http.get(Uri.parse("https://mangapill.com/mangas/new"));
    final comicsFromRemote = Scraper.recentComics(resp.body).toList();
    comicsFromRemote.addAll(Scraper.newComics(resp2.body));

    await ComicDb.self.addComics(comicsFromRemote);
  }
}
