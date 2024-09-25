class HomeModel{
  int quantity;
  String name;
  String image;
  String brief1;
  String brief2;
  String brief3;
  int payment;
  String pay;
  String discount;
  String rating;
  String only;
  String id;
  String dispay;

  HomeModel({
   required this.image,
    required this.quantity,
    required this.discount,
    required this.name,
    required this.brief1,
    required this.brief2,
    required this.brief3,
    required this.payment,
    required this.rating,
    required this.pay,
    required this.only,
    required this.id,
    required this.dispay,
});

  Map<String,dynamic> toMap(){
    return{
      'id': id,
      'quantity':quantity,
      'name':name,
      'brief1':brief1,
      'image':image,
      'brief2':brief2,
      'brief3':brief3,
      'payment':payment,
      'rating':rating,
      'pay':pay,
      'discount':discount,
      'only':only,
      'dispay':dispay,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map,String documentId) {
    return HomeModel(
      id: documentId,
      name: map['name'] ?? '',
      brief1: map['brief1'] ?? '',
      image: map['image'] ?? '',
      brief2: map['brief2'] ?? '',
      brief3: map['brief3'] ?? '',
      payment: map['payment'] ?? '',
      rating: map['rating'] ?? '',
      pay: map['pay']??'',
      discount:map['discount']?? '',
      only:map['only']?? '',
      dispay:map['dispay']?? '',
      quantity: map['quantity'] ?? '',
    );
  }
}