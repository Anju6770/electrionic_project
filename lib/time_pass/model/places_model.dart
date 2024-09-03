class PlaceModel {
  String id;
  String name;
  String author;
  String year;
  String price;


  PlaceModel({
    required this.id,
    required this.name,
    required this.author,
    required this.year,
    required this.price,
  });


  // Convert a PlaceModel object into a Map object to send to Cloud
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location':author,
      'imageUrl': year,
      'description': price,
    };
  }


  // Create a PlaceModel object from a Map object for fetching from Cloud
// Convert the Map object to PlaceModel object
  factory PlaceModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PlaceModel(
      id: documentId,
      name: map['name'] ?? '',
      author: map['author'] ?? '',
      year: map['year'] ?? '',
      price: map['price'] ?? '',
    );
  }
}

