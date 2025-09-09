


enum ComicType{
  manga, 
  webtoon, 
  comic
}



class ComicDetails{
  final String?      story;
  final List<String> genres;
  final int?         year;
  final ComicType?   type;

  const ComicDetails({
    this.story,
    this.year,
    this.type,
    required this.genres,
  });
}



enum ComicState {
  normal,
  favorite,
  blacklist
}



class Comic {

  

  int? id;

  final String     title;
  final String     url;
  final String     cover;
  final ComicState state;


  
  Comic({
    this.id,
    required this.title,
    required this.url, 
    required this.cover,
    this.state = ComicState.normal,
  });


  @override
  String toString() {
    return title;
  }


  Map<String, dynamic> toMap(){
    return {
      "title":title,
      "url"  :url,
      "cover":cover,
      "state":state.index,
    };
  }
}



enum ComicLabel {
  newChapters,
  newComic,
}

