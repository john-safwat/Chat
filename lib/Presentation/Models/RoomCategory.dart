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
}