import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccossoriesDetails extends StatefulWidget {
  var _accessoriesDetails;
  AccossoriesDetails(this._accessoriesDetails);

  @override
  State<AccossoriesDetails> createState() => _AccossoriesDetailsState();
}

class _AccossoriesDetailsState extends State<AccossoriesDetails> {
  bool isLike = false;

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
                widget._accessoriesDetails['image'],
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                top: 15,
              ),
              child: Text(
                widget._accessoriesDetails['title'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
              child: Text(
                widget._accessoriesDetails['price'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                widget._accessoriesDetails['details'],
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
