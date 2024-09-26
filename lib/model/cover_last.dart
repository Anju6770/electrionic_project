class CoverLast{
  String image;
  String image1;
  String id;

  CoverLast({
   required this.image,
   required this.image1,
   required this.id,
});
  Map<String,dynamic> toMap(){
    return{
      'image':image,
      'image1':image1,
      'id':id,
    };
  }

  factory CoverLast.fromMap(Map<String, dynamic> map, String documentId) {
    return CoverLast(
      image: map['image'] ?? '',
      image1: map['image1'] ?? '',
      id: map['id'] ?? '',
    );
  }
}