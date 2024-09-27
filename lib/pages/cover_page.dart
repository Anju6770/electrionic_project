import 'package:carousel_slider/carousel_slider.dart';
import 'package:electrionic_project/Main_page/services.dart';
import 'package:electrionic_project/model/cover_first.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CoverPage extends StatefulWidget {
  const CoverPage({super.key});

  @override
  State<CoverPage> createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> {

  final List<String> textList = [
    'We Provide The Best Electronic Products',
    'You will be able to find a wide selection of electronics from top brands',
    'If the product is not working, we will replace it and give you a new one'
  ];

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<CoverFirst>>(
            stream: _services.fetchsign(),
            builder: (context,snapshot){
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                );
              }
              final logo = snapshot.data!;
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: logo.length,
                  itemBuilder: (context, index) {
                    final logos = logo[index];
                    return Column(
                      children: [
                        Image(image: NetworkImage("${logos.image}"),fit: BoxFit.cover,),

                      ],
                    );
                  },
                ),
              );
            },
          ),
          CarouselSlider(
            items: textList.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  e,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
            carouselController: _carouselController,
            options: CarouselOptions(
              initialPage: 0,
              enlargeCenterPage: true,
              enlargeFactor: 0.5,
              height: 170,
              onPageChanged: (value, _) {
                setState(() {
                  _currentIndex = value;
                });
              },
            ),
          ),
          buildIndicator(),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              if (_currentIndex == textList.length - 1) {
                Get.offAllNamed('/signup');
              } else {
                int nextIndex = (_currentIndex + 1) % textList.length;
                _carouselController.animateToPage(nextIndex);
                setState(() {
                  _currentIndex = nextIndex;
                });
              }
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                child: Icon(Icons.arrow_forward, size: 25, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < textList.length; i++)
          Container(
            margin: EdgeInsets.all(5),
            height: 7,
            width: i == _currentIndex ? 35 : 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: i == _currentIndex ? Colors.white : Colors.grey,
            ),
          ),
      ],
    );
  }
}

