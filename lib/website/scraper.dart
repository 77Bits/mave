import 'package:html/parser.dart';
import 'package:html/dom.dart' show Document, Element;
import 'package:mave/modules/modules.dart' show Comic;
import 'info.dart' show URL_PREFIX;




class Scraper{



  static Iterable<Comic> recentComics(String htmlCode){
    return _RecentpageScraper(htmlCode).get_comics();
  }

  static Iterable<Comic> newComics(String htmlCode){
    return _NewpageScraper(htmlCode).get_comics();
  }
}

class _NewpageScraper extends _RecentpageScraper{

  _NewpageScraper(String htmlCode): super(htmlCode);

  @override
  Comic card2Comic(Element card) {
    return Comic(
      title: card.querySelector('.mt-3')!.text.trim(),
      url  : URL_PREFIX + card.querySelector('a')!.attributes['href']!,
      cover: card.querySelector('img')!.attributes['data-src']!,
    );
  }
}

class _RecentpageScraper {

  late final Document tree;

  _RecentpageScraper(String htmlCode){
    this.tree = parse(htmlCode);
  }


  Iterable<Comic> get_comics(){
    final cards = tree.querySelectorAll(".grid > div");
    return cards.map(card2Comic);
  }


  Comic card2Comic(Element card){
    final String title = card.querySelector('.text-sm')!.text.trim();
    return Comic(
      title: title,
      url  : URL_PREFIX + card.querySelector('a.mt-1\\.5')!.attributes['href']!,
      cover: card.querySelector('img')!.attributes['data-src']!,
    );
  } 
}
