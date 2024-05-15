import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/images.dart';
import '../login_view_doctor/login_view_doctor.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({super.key,required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Search Results",
          style: TextStyle(color: Colors.white, fontFamily: "Lobster"),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('doctors').get(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );

            }else{
              var data = snapshot.data?.docs;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 170,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      var doc = snapshot.data!.docs[index];
                      return !doc['docName'].toString().toLowerCase().contains(searchQuery.toLowerCase())?SizedBox.shrink():
                       GestureDetector(
                         onTap: (){
                           Get.to((LoginViewDoctor(doc: doc)));

                         },
                         child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                                width: 130,
                                height: 120,
                                color: Colors.grey.shade500,
                                child: Image.asset(
                                  fit: BoxFit.fill,
                                  AppAssets.signUp,
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                doc['docName'],
                                style: TextStyle(),
                              ),
                              VxRating(onRatingUpdate: (value) {},
                                selectionColor: Colors.yellow,
                                normalColor: Colors.black45,
                                count: 5,
                                maxRating: 5,
                                value: double.parse(doc['docRating'].toString()),
                                stepInt: true,
                              ),

                            ],
                          ),
                                               ),
                       );
                    }
                ),
              );
            }
          }),
    );
  }
}
