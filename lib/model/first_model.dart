class FirstModel{
  String name;
  String image;
  int payment;

  FirstModel({
    required this.name,
    required this.payment,
    required this.image
});

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'image':image,
      'payment':payment,
    };
  }

  factory FirstModel.fromMap(Map<String, dynamic> map, String documentId) {
    return FirstModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      payment: map['payment'] ?? '',
    );
  }
}