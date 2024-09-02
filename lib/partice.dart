// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// class FirestoreImageDisplay extends StatefulWidget {
//   const FirestoreImageDisplay({super.key});
//
//   @override
//   State<FirestoreImageDisplay> createState() => _FirestoreImageDisplayState();
// }
//
// class _FirestoreImageDisplayState extends State<FirestoreImageDisplay> {
//   late String image;
//   late String image1;
//   final storage = FirebaseStorage.instance;
//   @override
//   void initState(){
//     super.initState();
//     image="";
//     image1="";
//     getImage();
//   }
//   Future<void> getImage()async{
//     final ref=storage.ref().child("HeadPhone.jpg");
//     final ref1=storage.ref().child("TV.jpg");
//     final url=await ref.getDownloadURL();
//     final url1=await ref1.getDownloadURL();
//     setState(() {
//       image=url;
//       image1=url1;
//     });
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Display image from firebase"),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 300,
//             child: Image(image: NetworkImage(image),fit: BoxFit.cover,),
//           ),
//           SizedBox(
//             height: 300,
//             child: Image(image: NetworkImage(image1),fit: BoxFit.cover,),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PlacesListScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final CollectionReference shoe = FirebaseFirestore.instance.collection("shirt");
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/add');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: shoe.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.requireData;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());

          }else{
            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                final shoe = data.docs[index];
                return Card(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage('${shoe['image']}'))
                        ),
                      ),
                      Text('${shoe['name']}'),
                    ],
                  ),
                );
              },
            );
          }

        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class CarouselWithNetworkImages extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final List<String> imageUrls = [
//       'https://example.com/image1.jpg',
//       'https://example.com/image2.jpg',
//       'https://example.com/image3.jpg',
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carousel Slider with Network Images'),
//       ),
//       body: Center(
//         child: CarouselSlider(
//           options: CarouselOptions(
//             height: 400.0,
//             enlargeCenterPage: true,
//             viewportFraction: 0.8,
//             aspectRatio: 2.0,
//             initialPage: 0,
//           ),
//           items: imageUrls.map((imageUrl) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }