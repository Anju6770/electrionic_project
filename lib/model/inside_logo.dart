class InsideLogo{
  String image;

  InsideLogo({
    required this.image
  });
  Map<String,dynamic> toMap(){
    return{
      'image':image,
    };
  }

  factory InsideLogo.fromMap(Map<String, dynamic> map, String documentId) {
    return InsideLogo(
      image: map['image'] ?? '',
    );
  }
}