// import 'package:firebase_login_app/Controllers/reviews_controller.dart';
// import 'package:flutter/material.dart';

// import '../Models/tutor.dart';

// class ProfilePage1 extends StatelessWidget {
//   final Tutor tutorObject;

//   ProfilePage1({required this.tutorObject, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<ProfileInfoItem> items = [
//       ProfileInfoItem(tutorObject.email, 'Email'),
//       ProfileInfoItem(tutorObject.phone, 'Phone'),
//       ProfileInfoItem(tutorObject.experience, 'Degree'),
//       ProfileInfoItem(avgRates(tutorObject.id).toString(), "Reviews"), // Added "Reviews" item
//     ];
//     List<ProfileInfoItem> itemsTwo = [
//       ProfileInfoItem(tutorObject.location, 'Location'),
//       ProfileInfoItem(tutorObject.subject, 'Subject'),
//       ProfileInfoItem(tutorObject.hourly_rate + "\$", "Hourly-Rate"),
//     ];
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(flex: 2, child: TopPortion(tutorObject)),
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     tutorObject.name,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       FloatingActionButton.extended(
//                         onPressed: () {},
//                         heroTag: 'follow',
//                         elevation: 0,
//                         label: const Text("Request Session"),
//                         icon: const Icon(Icons.schedule_send_outlined),
//                       ),
//                       const SizedBox(width: 16.0),
//                       FloatingActionButton.extended(
//                         onPressed: () {},
//                         heroTag: 'mesage',
//                         elevation: 0,
//                         backgroundColor: Colors.yellow[700],
//                         label: const Text("Message"),
//                         icon: const Icon(Icons.message_rounded),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // ProfileInfoRow(
//                   //     location: location,
//                   //     hourly_rate: hourly_rate,
//                   //     subj: subject),
//                   dataList(context, itemsTwo),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     child: GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithMaxCrossAxisExtent(
//                         maxCrossAxisExtent: 200,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                       ),
//                       itemCount: items.length,
//                       itemBuilder: (context, index) {
//                         final item = items[index];
//                         return GestureDetector(
//                           onTap: () {
//                             print('Grid Item $index tapped');
//                           },
//                           child: Container(
//                             color: Color.fromARGB(255, 186, 0, 186),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 if (item.title == 'Reviews')
//                                   _reviewsItem(context,
//                                       item) // Use _reviewsItem for "Reviews" item
//                                 else
//                                   _singleItem(context, item),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _singleItem(BuildContext context, ProfileInfoItem item) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             item.value.toString(),
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//         Text(
//           item.title,
//           style: Theme.of(context).textTheme.caption,
//         ),
//       ],
//     );
//   }

//   Widget _reviewsItem(BuildContext context, ProfileInfoItem item) {
//     double rating =
//         double.tryParse(item.value) ?? 0.0; // Parse the rating value
//     int starCount = rating.round(); // Round the rating to the nearest integer

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(5, (index) {
//               if (index < starCount) {
//                 return Icon(
//                   Icons.star,
//                   color: Colors.yellow,
//                 );
//               } else {
//                 return Icon(
//                   Icons.star_border,
//                   color: Colors.yellow,
//                 );
//               }
//             }),
//           ),
//         ),
//         Text(
//           item.title,
//           style: Theme.of(context).textTheme.caption,
//         ),
//       ],
//     );
//   }

//   dataList(BuildContext context, List<ProfileInfoItem> itemsTwo) {
//     return Container(
//       height: 80,
//       constraints: const BoxConstraints(maxWidth: 400),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: itemsTwo
//             .map((item) => Expanded(
//                   child: Row(
//                     children: [
//                       if (itemsTwo.indexOf(item) != 0) const VerticalDivider(),
//                       Expanded(
//                         child: item.title == 'Reviews'
//                             ? _reviewsItem(context,
//                                 item) // Use _reviewsItem for "Reviews" item
//                             : _singleItem(context,
//                                 item), // Use _singleItem for other items
//                       ),
//                     ],
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }

// Widget _singleItem(BuildContext context, ProfileInfoItem item) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           item.value.toString(),
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//       ),
//       Text(
//         item.title,
//         style: Theme.of(context).textTheme.caption,
//       ),
//     ],
//   );
// }

// Widget _reviewsItem(BuildContext context, ProfileInfoItem item) {
//   double rating = double.tryParse(item.value) ?? 0.0; // Parse the rating value
//   int starCount = rating.round(); // Round the rating to the nearest integer

//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(5, (index) {
//             if (index < starCount) {
//               return Icon(
//                 Icons.star,
//                 color: Colors.yellow,
//               );
//             } else {
//               return Icon(
//                 Icons.star_border,
//                 color: Colors.yellow,
//               );
//             }
//           }),
//         ),
//       ),
//       Text(
//         item.title,
//         style: Theme.of(context).textTheme.caption,
//       ),
//     ],
//   );
// }

// class ProfileInfoItem {
//   final String title;
//   final String value;
//   ProfileInfoItem(this.title, this.value);
// }

// @override
// Widget TopPortion(Tutor tutorObject) {
//   return Stack(
//     fit: StackFit.expand,
//     children: [
//       Container(
//         margin: const EdgeInsets.only(bottom: 50),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             colors: [
//               Color.fromARGB(255, 186, 0, 186),
//               Color.fromARGB(255, 245, 188, 33)
//             ],
//           ),
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(50),
//             bottomRight: Radius.circular(50),
//           ),
//         ),
//       ),
//       // Positioned(
//       //   top: 0,
//       //   right: 0,
//       //   child: Padding(
//       //     padding: const EdgeInsets.all(8.0),
//       //     child: IconButton(
//       //       icon: const Icon(
//       //         Icons.settings,
//       //         color: Colors.white,
//       //       ),
//       //       onPressed: () {
//       //         // Handle settings button tap
//       //         print('Settings button tapped');
//       //       },
//       //     ),
//       //   ),
//       // ),
//       Align(
//         alignment: Alignment.bottomCenter,
//         child: SizedBox(
//           width: 150,
//           height: 150,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(tutorObject.profile_pic),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.yellow,
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.camera_alt),
//                     color: Colors.black,
//                     onPressed: () {
//                       // Handle camera button tap
//                       print('Camera button tapped');
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }
