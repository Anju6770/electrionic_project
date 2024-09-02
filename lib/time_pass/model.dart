class BookModel {
  String title;
  String author;
  String year;
  String price;
  String id;

  BookModel ({
    required this.title,
    required this.author,
    required this.year,
    required this.price,
    required this.id,
  });
///model to map
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'author': author,
      'year': year,
      'price': price,
    };
  }

  ///map to model

  factory BookModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BookModel(
    id : documentId,
      title: map['title'] ??'',
      author: map['author']??'',
      year: map['year']??'',
      price: map['price']??'',

    );
  }
}