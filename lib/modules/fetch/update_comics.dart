import 'package:http/http.dart' as http;
import 'package:mave/website/scraper.dart';
import 'package:mave/modules/modules.dart' show Comic, ComicDb, ComicLabel;





Future<Map<String, ComicLabel>> updateComics() async{
  final recentRemoteComics = Scraper.recentComics(
    (await http.get(Uri.parse("https://mangapill.com/chapters"))).body
  );
  final newRemoteComics  = Scraper.newComics(
    (await http.get(Uri.parse("https://mangapill.com/mangas/new"))).body
  );


  // this is for the url of those comics that contain new chapters
  final Map<String, ComicLabel> report = {};


  await _updateNewRemoteComics(newRemoteComics, report);

  return report;
}

Future<void> _updateNewRemoteComics(Iterable<Comic> newRemoteComics, Map<String, ComicLabel> report) async{
  final List<Comic> comics2Insert = [];
  final db = ComicDb.self;
  
  for (Comic comic in newRemoteComics) {
    if (!(await db.comicExistsByUrl(comic))){
      comics2Insert.add(comic);
      report[comic.url] = ComicLabel.newComic;
    }
    else break;
  }
  await db.addComics(comics2Insert);
}
