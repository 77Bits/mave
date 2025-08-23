



class Comic {
  final String title;
  final String url;
  final String cover;


  
  Comic({
    required this.title,
    required this.url, 
    required this.cover,
  });


  @override
  String toString() {
    return title;
  }
}
