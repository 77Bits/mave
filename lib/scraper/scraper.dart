import 'package:html/parser.dart';
import 'package:html/dom.dart' show Document, Element;
import 'package:mave/typs.dart' show Comic;




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
    final cards = tree.querySelectorAll(".col-12.col-md-6.badge-pos-2");
    return cards.map(_HomepageScraper.card2Comic);
  }


  static Comic card2Comic(Element card){
    final String title = card.querySelector('h3')!.text.trim();
    return Comic(
      title: title,
      url  : card.querySelector('a')!.attributes['href']!,
      cover: card.querySelector('img')!.attributes['src']!,
    );
  }
}
