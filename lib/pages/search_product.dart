import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/Main_page/services.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchDoc extends StatefulWidget {
  const SearchDoc({super.key});

  @override
  State<SearchDoc> createState() => _SearchDocState();
}

class _SearchDocState extends State<SearchDoc> {
  TextEditingController _controller = TextEditingController();
  List<DocumentSnapshot> _allDocs = [];
  List<DocumentSnapshot> _filteredDocs = [];

  @override
  void initState() {
    super.initState();
    Services();
    _fetchDocs();
  }

  Future<void> _fetchDocs() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot snapshot = await firestore.collection('home').get();
      setState(() {
        _allDocs = snapshot.docs;
        _filteredDocs = _allDocs;
      });
    } catch (e) {
      print('Error fetching hospitals: $e');
    }
  }

  void _filterDocs(String query) {
    List<DocumentSnapshot> result = [];
    if (query.isEmpty) {
      result = _allDocs;
    } else {
      result = _allDocs.where((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    setState(() {
      _filteredDocs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){Get.back();}, child: Icon(Icons.arrow_back_ios,size: 25,)),
        title: Text('Search Products',style: mystyle(30),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 3.5,
              child: Container(
                padding:EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: _controller,
                  style:TextStyle(fontSize: 18),
                  decoration:InputDecoration(
                    hintText: 'Search by name...',
                    suffixIcon: Icon(Icons.keyboard_voice_rounded, size: 30),
                    border: InputBorder.none
                  ),
                  onChanged: (value) {
                    _filterDocs(value); // Filter as the user types
                  },
                ),
              ),
            ),
            Gap(20),
            Expanded(
              child: _filteredDocs.isEmpty
                  ? Center(child: Text('No product found'))
                  : GridView.builder(
                shrinkWrap: true,
                //physics:NeverScrollableScrollPhysics(),
                itemCount: _filteredDocs.length,
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.54,
                ),
                itemBuilder: (context, index) {
                  final product = _filteredDocs[index];
                  return Column(
                    children: [
                      Stack(
                          children:[ Hero(
                            tag:product["image"],
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(product["image"],),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                            Positioned(
                              left: 9,
                              top: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    width: MediaQuery.of(context).size.width * 0.13,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.black,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(product["rating"], style: TextStyle(color: Colors.white)),
                                        Gap(4),
                                        Icon(Icons.star, color: Colors.white, size: 20),
                                      ],
                                    ),
                                  )
                                ],
                              ),)
                          ]
                      ),
                      Container(
                        padding:EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product["name"],
                              style:TextStyle(fontSize: 20),
                              maxLines: 2,
                            ),
                            Gap(4),
                            Row(
                              children: [
                                Text(
                                  product["pay"],
                                  style:TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Gap(6),
                                Text(
                                  product["pay"],
                                  style:TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    decoration:
                                    TextDecoration.lineThrough,
                                  ),
                                ),
                                Gap(5),
                                Text(
                                  product["discount"],
                                  style:TextStyle(
                                      fontSize: 17,
                                      color: Colors.green,fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Gap(5),
                            Row(
                              children: [
                                Icon(Icons.discount),
                                Gap(5),
                                Text("Exchange Offers",style: TextStyle(fontSize: 16),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
              // ListView.builder(
              //   itemCount: _filteredDocs.length,
              //   itemBuilder: (context, index) {
              //     DocumentSnapshot doc = _filteredDocs[index];
              //     Map<String, dynamic> data =
              //     doc.data() as Map<String, dynamic>;
              //
              //     return InkWell(
              //       onTap: () {
              //
              //       },
              //       child: ListTile(
              //         leading: Image.network(
              //           data['image'],
              //           width: MediaQuery.of(context).size.width*0.1,
              //           height: MediaQuery.of(context).size.height*0.5,
              //           fit: BoxFit.fill,
              //         ),
              //         title: Text(data['name']),
              //       ),
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
