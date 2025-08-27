



class Comic {

  static const int BOOKMARKED = 2;
  static const int BLOCKED    = 1;
  static const int NORMAL     = 0;



  int? id;

  final String title;
  final String url;
  final String cover;
  final int    state;


  
  Comic({
    this.id,
    required this.title,
    required this.url, 
    required this.cover,
    this.state = 0,
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
      "state":state,
    };
  }
}
