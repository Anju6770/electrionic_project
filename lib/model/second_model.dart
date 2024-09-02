class SecondModel {
  String image;

  SecondModel({
   required this.image
});
  Map<String,dynamic> toMap(){
    return{
      'image':image,
    };
  }

  factory SecondModel.fromMap(Map<String, dynamic> map, String documentId) {
    return SecondModel(
      image: map['image'] ?? '',
    );
  }
}