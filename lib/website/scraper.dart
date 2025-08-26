import 'package:html/parser.dart';
import 'package:html/dom.dart' show Document, Element;
import 'package:mave/toolkit/toolkit.dart' show Comic;
import 'info.dart' show URL_PREFIX;




class Scraper{



  static Iterable<Comic> comics(String htmlCode){
    return _HomepageScraper(htmlCode).get_comics();
  }
}




class _HomepageScraper {

  late final Document tree;

  _HomepageScraper(String htmlCode){
    this.tree = parse(htmlCode);
  }


  Iterable<Comic> get_comics(){
    final cards = tree.querySelectorAll(".grid > div");
    return cards.map(_HomepageScraper.card2Comic);
  }


  static Comic card2Comic(Element card){
    final String title = card.querySelector('.text-sm')!.text.trim();
    return Comic(
      title: title,
      url  : URL_PREFIX + card.querySelector('a')!.attributes['href']!,
      cover: card.querySelector('img')!.attributes['data-src']!,
    );
  } 
}
