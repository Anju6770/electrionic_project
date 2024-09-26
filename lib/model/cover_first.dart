class CoverFirst{
  String image;

  CoverFirst({
   required this.image
});
  Map<String,dynamic> toMap(){
    return{
      'image':image,
    };
  }

  factory CoverFirst.fromMap(Map<String, dynamic> map, String documentId) {
    return CoverFirst(
      image: map['image'] ?? '',
    );
  }
}