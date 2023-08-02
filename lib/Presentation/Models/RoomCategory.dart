class RoomCategory{

  String id;
  String name ;
  String image ;

  RoomCategory({
    required this.id,
    required this.name,
    required this.image
  });


  static List<RoomCategory> getAllCategories(){
    return [
      RoomCategory(id: "chat", name: "Chat", image: "chat.png"),
      RoomCategory(id: "coding", name: "Coding", image: "coding.png"),
      RoomCategory(id: "gaming", name: "Gaming", image: "gaming.png"),
      RoomCategory(id: "music", name: "Music", image: "music.png"),
      RoomCategory(id: "movies", name: "Movies", image: "movies.png"),
      RoomCategory(id: "events", name: "Events", image: "events.png"),
      RoomCategory(id: "art", name: "Art", image: "art.png"),
      RoomCategory(id: "fashion", name: "Fashion", image: "fashion.png"),
      RoomCategory(id: "global", name: "Global", image: "global.png"),
      RoomCategory(id: "news", name: "News", image: "news.png"),
      RoomCategory(id: "reading", name: "Reading", image: "reading.png"),
      RoomCategory(id: "smartphone", name: "Smartphone", image: "smartphone.png"),
    ];
  }


  static RoomCategory getRoomCategory(String id){
    var categories = getAllCategories();
    switch (id){
      case "chat":
        return categories[0];
      case "coding":
        return categories[1];
      case "gaming":
        return categories[2];
      case "music":
        return categories[3];
      case "movies":
        return categories[4];
      case "events":
        return categories[5];
      case "art":
        return categories[6];
      case "fashion":
        return categories[7];
      case "global":
        return categories[8];
      case "news":
        return categories[9];
      case "reading":
        return categories[10];
      case "smartphone":
        return categories[11];
      default:
        return RoomCategory(id: "id", name: "name", image: "image");
    }
  }
}