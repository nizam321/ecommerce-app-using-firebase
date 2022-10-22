import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/const/colors.dart';
import 'package:ecommerce/screens/Accessories_details.dart';
import 'package:ecommerce/screens/search.dart';

import 'package:ecommerce/screens/top_products_details.dart';
import 'package:ecommerce/screens/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  var inputText = "";
  List<String> _sliderImages = [];
  var _dotPosition = 0;
  List<dynamic> _topProducts = [];
  List _accessoriesProducts = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchCarouselImages() async {
    QuerySnapshot qn = await _firestoreInstance.collection("slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _sliderImages.add(
          qn.docs[i]["image"],
        );
        print(qn.docs[i]["image"]);
      }
    });

    return qn.docs;
  }

  fetchTopProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("t-products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _topProducts.add({
          "p-image": qn.docs[i]["p-image"],
          "title": qn.docs[i]["title"],
          "price": qn.docs[i]["price"],
          "details": qn.docs[i]["details"],
        });
      }
    });

    return qn.docs;
  }

  fetchAccessories() async {
    QuerySnapshot qn = await _firestoreInstance.collection("accessories").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _accessoriesProducts.add({
          "image": qn.docs[i]["image"],
          "title": qn.docs[i]["title"],
          "price": qn.docs[i]["price"],
          "details": qn.docs[i]["details"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchTopProducts();
    fetchAccessories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Ecommerce',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    inputText = value;
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: "Search product",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (index) => SearchBar()));
                          },
                          icon: Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            SizedBox(height: 10.h),
            AspectRatio(
              aspectRatio: 2.7,
              child: CarouselSlider(
                  items: _sliderImages
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            SizedBox(height: 10.h),
            DotsIndicator(
              dotsCount: _sliderImages.length == 0 ? 1 : _sliderImages.length,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.deep_orange,
                color: AppColors.deep_orange.withOpacity(0.5),
                spacing: EdgeInsets.all(2),
                activeSize: Size(8, 8),
                size: Size(6, 6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Products',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (index) => ViewAll()));
                    },
                    child: Text(
                      'View All  >',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return SizedBox(
                    height: 120.h,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsProduct(_topProducts[index]),
                        ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              _topProducts[index]["p-image"],
                              width: 140.w,
                              height: 70.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                _topProducts[index]["title"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                _topProducts[index]["price"],
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                separatorBuilder: (_, index) => const SizedBox(width: 3),
                itemCount: _topProducts.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Accessories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All  >',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return SizedBox(
                    height: 120.h,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AccossoriesDetails(_accessoriesProducts[index]),
                        ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              _accessoriesProducts[index]["image"],
                              width: 140.w,
                              height: 70.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                _accessoriesProducts[index]["title"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                _accessoriesProducts[index]["price"],
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                separatorBuilder: (_, index) => SizedBox(width: 3),
                itemCount: _accessoriesProducts.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
