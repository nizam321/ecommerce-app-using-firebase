import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  List _viewAll = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchViewProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("view-all").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _viewAll.add({
          "img": qn.docs[i]["img"],
          "title": qn.docs[i]["title"],
          "price": qn.docs[i]["price"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchViewProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemCount: _viewAll.length,
          itemBuilder: (_, index) => Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    _viewAll[index]["img"],
                    width: 160.w,
                    height: 100.h,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    _viewAll[index]["title"],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    _viewAll[index]["price"],
                    style: TextStyle(color: Colors.deepOrange, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
