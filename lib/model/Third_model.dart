class ThirdModel{
  String image;
  String name;
  String payment;
  String pay;
  String discount;
  String rating;

  ThirdModel({
    required this.image,
    required this.discount,
    required this.name,
    required this.payment,
    required this.rating,
    required this.pay,
  });

  Map<String,dynamic> toMap(){
    return{
      'image':image,
      'payment':payment,
      'rating':rating,
      'name':name,
    };
  }

  factory ThirdModel.fromMap(Map<String, dynamic> map) {
    return ThirdModel(
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      payment: map['payment'] ?? '',
      rating: map['rating'] ?? '',
      pay: map['pay']??'',
      discount:map['discount']?? '',
    );
  }
}