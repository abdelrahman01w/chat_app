class Category{
  static const String sportsId="sports";
  static const String moviesId="movies";
  static const String musicId="music";
  String id;
  late String title;
  Category({required this.id , required this.title});
  Category.fromId(this.id){
    if(id==sportsId){
      title="Sports";
    }else if(id==moviesId){
      title="Movies";
    }else if(id==musicId){
      title="Music";
    }
  }
  static List<Category>getCategory(){
    return [
      Category.fromId(sportsId),
      Category.fromId(moviesId),
      Category.fromId(musicId),
    ];
  }

}