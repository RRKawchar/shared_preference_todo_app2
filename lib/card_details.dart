// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_project/custom_things/nav_bar/custom_btm_nav_bar.dart';
// import 'package:firebase_project/helper/firebase_helper.dart';
// import 'package:flutter/material.dart';
//
// import '../custom_things/custom_txt_style/txt_style.dart';
//
// class CardDetailsPage extends StatefulWidget {
//   CardDetailsPage({Key? key}) : super(key: key);
//
//   @override
//   State<CardDetailsPage> createState() => _CardDetailsPageState();
// }
//
// class _CardDetailsPageState extends State<CardDetailsPage> {
//   final Stream<QuerySnapshot> _cartStream = FirebaseFirestore.instance
//       .collection('users_card')
//       .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//       .snapshots();
//   int cnt = 1;
//   bool isChecked = true;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return await Navigator.push(context,
//             MaterialPageRoute(builder: (context) => CustomBottomNavBar()));
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 70,
//           backgroundColor: const Color(0xFFFFFFFF),
//           foregroundColor: Colors.black,
//           elevation: 0,
//           title: const Text('My Cart'),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CustomBottomNavBar()));
//             },
//             icon: const Icon(Icons.arrow_back),
//           ),
//         ),
//         body: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//           child: StreamBuilder(
//             stream: _cartStream,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasError) {
//                 return const Center(child: Text('Something went wrong'));
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                     child: CircularProgressIndicator(color: Color(0xFF006847)));
//               } else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           var data = snapshot.data!.docs[index];
//                           // int cnt = 1;
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Item${index + 1}"),
//                               Container(
//                                 margin: const EdgeInsets.symmetric(vertical: 5),
//                                 height: 150,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.white,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       flex: 5,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Image(
//                                                   image: NetworkImage(snapshot
//                                                       .data!
//                                                       .docs[index]['img'])),
//                                               Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     snapshot.data!.docs[index]
//                                                         ['name'],
//                                                     style: const TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 5,
//                                                   ),
//                                                   Text(
//                                                     'TK. ${snapshot.data!.docs[index]['price']}',
//                                                     style: const TextStyle(
//                                                         color:
//                                                             Colors.deepOrange),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           IconButton(
//                                               onPressed: () {
//                                                 FireBaseHelper().deleteData(
//                                                     snapshot
//                                                         .data.docs[index].id);
//                                               },
//                                               icon: const Icon(
//                                                 Icons.delete,
//                                                 color: Colors.red,
//                                                 size: 30,
//                                               ))
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 3,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   print('click komce');
//                                                   if (cnt <= 1) {
//                                                   } else {
//                                                     setState(() {
//                                                       cnt--;
//                                                     });
//                                                   }
//                                                 },
//                                                 child: Container(
//                                                   padding: const EdgeInsets.symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 5),
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5),
//                                                       border: Border.all(
//                                                         color: Colors.red,
//                                                         width: 0.3,
//                                                       )),
//                                                   child: const Text(
//                                                     '-',
//                                                     style: TextStyle(
//                                                         fontSize: 20,
//                                                         color:
//                                                             Color(0xFF006847)),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                   padding: const EdgeInsets.symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 8),
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5),
//                                                       border: Border.all(
//                                                         color: Colors.red,
//                                                         width: 0.3,
//                                                       )),
//                                                   child: Text('${cnt}')),
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     print('click barce');
//                                                     cnt++;
//                                                   });
//                                                 },
//                                                 child: Container(
//                                                   padding: const EdgeInsets.symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 5),
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5),
//                                                       border: Border.all(
//                                                         color: Colors.red,
//                                                         width: 0.3,
//                                                       )),
//                                                   child: const Text('+',
//                                                       style: TextStyle(
//                                                           fontSize: 20,
//                                                           color: Color(
//                                                               0xFF006847))),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             "TK. ${((int.parse(data['price'])) * cnt)}"
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 color: Colors.deepOrange,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return const SizedBox(
//                             height: 10,
//                           );
//                         },
//                         itemCount: snapshot.data.docs.length,
//                       ),
//                       Container(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         height: 100,
//                         width: double.infinity,
//                         color: Colors.white,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text("Sub Total"),
//                                 const Text("data"),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text("Sub Total"),
//                                 const Text("data"),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text("Sub Total"),
//                                 const Text("data"),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//                         height: 100,
//                         width: double.infinity,
//                         color: Colors.white,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Payment Method:',
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                   activeColor: const Color(0xFF006847),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20)),
//                                   value: isChecked,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       isChecked = !isChecked;
//                                     });
//                                   },
//                                 ),
//                                 const Text("Cash on delivery",
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.deepOrange)),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               return const Center(
//                 child: Text(
//                   'Your Cart is Empty Now',
//                   style: TextStyle(fontSize: 20, color: Colors.black),
//                 ),
//               );
//             },
//           ),
//         ),
//         bottomNavigationBar: Container(
//           height: 50,
//           width: double.maxFinite,
//           alignment: Alignment.center,
//           color: const Color(0xFF006847),
//           child: Text(
//             'Place Order',
//             style: myStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
