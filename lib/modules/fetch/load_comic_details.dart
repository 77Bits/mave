import 'package:http/http.dart' as http;
import 'package:mave/modules/modules.dart' show ComicDetails;
import 'package:mave/website/scraper.dart' show Scraper;




Future<ComicDetails> loadComicDetails(String comicUrl) async{
  final resp = await http.get(Uri.parse(comicUrl));

  return Scraper.comicDetails(resp.body);
}

