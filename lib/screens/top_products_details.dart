import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/colors.dart';

class DetailsProduct extends StatefulWidget {
  var _topProduct;
  DetailsProduct(this._topProduct);

  @override
  State<DetailsProduct> createState() => _DetailsProductState();
}

class _DetailsProductState extends State<DetailsProduct> {
  Future addToCart() async {
    final FirebaseAuth _email = FirebaseAuth.instance;
    var currentUser = _email.currentUser;
    CollectionReference _userCollection =
        FirebaseFirestore.instance.collection('user-cart');
    return _userCollection
        .doc(currentUser!.email)
        .collection('items')
        .doc()
        .set(
      {
        'p-image': widget._topProduct['p-image'],
        'title': widget._topProduct['title'],
        'price': widget._topProduct['price'],
      },
    ).then((value) => 'Add to cart');
  }

  bool isLike = false;

  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isLike = !isLike;
                      });
                    },
                    icon: Icon(
                      isLike ? Icons.favorite : Icons.favorite_outline,
                      color: isLike ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Image.network(
                widget._topProduct['p-image'],
                height: 200.h,
                width: double.infinity.w,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                top: 15,
              ),
              child: Text(
                widget._topProduct['title'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
              child: Text(
                widget._topProduct['price'],
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                widget._topProduct['details'],
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  addToCart();
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => BottomNavComtroller(),
                  //   ),
                  // );
                  cusstomDialog();
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.deep_orange,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: 5.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cusstomDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
              height: 50,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _counter++;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                    Text(
                      '$_counter',
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _counter--;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.remove),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
