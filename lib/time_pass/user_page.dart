import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/time_pass/managementState.dart';
import 'package:electrionic_project/time_pass/model.dart';
import 'package:electrionic_project/time_pass/time_services.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Book extends StatefulWidget {
  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  bool _isLightTheme=true;

  bool get isLightTheme=>_isLightTheme;

  void toggletheme(){
    _isLightTheme = !_isLightTheme;
    //update();
  }
  final PlacesServices _placesServices = PlacesServices();

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();

  Future<void> _uploadPlace() async {
    final newPlace = BookModel(
      id: '',
      title: _titleController.text,
      author: _authorController.text,
      year: _yearController.text,
      price: _priceController.text,
    );

    await _placesServices.addPlace(newPlace);
    _clearFormFields();
  }

  void _clearFormFields() {
    _titleController.clear();
    _authorController.clear();
    _yearController.clear();
    _priceController.clear();


    Future<void>_updatePlace()async{
      final updatedPlace = BookModel(
        id: '',
        title: _titleController.text,
        author: _authorController.text,
        year: _yearController.text,
        price: _priceController.text,
      );


      await _placesServices.updatePlace(updatedPlace);
      Get.back();

    }

  }

  final ManageState ms = Get.put(ManageState());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isLightTheme ? Colors.white : Colors.black,
        leading: Icon(Icons.menu,size: 30,color: Colors.black,),
        title: Text(
          'Anjali Ghalley',
          style: TextStyle(fontSize: 30,fontWeight:  FontWeight.bold, color: isLightTheme ? Colors.black : Colors.white,),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Toggle the theme
              toggletheme();
            },
            icon: Icon(
              isLightTheme ? Icons.sunny : Icons.nightlight,
              color: isLightTheme ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<List<BookModel>>(
            stream: _placesServices.fetchPlaces(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final places = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    final place = places[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${place.title}',style: TextStyle( color: isLightTheme ? Colors.black : Colors.white,),),
                          Row(
                            children: [
                              Text('${place.year}',style: TextStyle( color:isLightTheme ? Colors.black : Colors.white,),),
                              SizedBox(width: 10),
                              Text('${place.author}',style: TextStyle( color:isLightTheme ? Colors.black : Colors.white,),),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  await _placesServices.deletePlace(place.id);
                                },
                                child: Icon(Icons.delete, color: Colors.yellow),
                              ),
                            ],
                          ),
                          Text('${place.price}',style: TextStyle( color: isLightTheme ? Colors.black : Colors.white,),),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: (){
                    _uploadPlace();

                  },
                  child: Icon(Icons.add,  color:isLightTheme ? Colors.red : Colors.white, size: 40)),
              Container(
                margin: EdgeInsets.all(10),
                height: 200,
                width: 200,
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _authorController,
                            decoration: InputDecoration(
                              hintText: 'Author',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _yearController,
                                  decoration: InputDecoration(
                                    hintText: 'Year',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: _priceController,
                                  decoration: InputDecoration(
                                    hintText: 'Price',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await _uploadPlace(); // Upload the new place on send icon tap
                },
                child: Icon(Icons.send, size: 40,  color: isLightTheme ? Colors.green : Colors.white,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



