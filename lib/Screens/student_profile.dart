import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login_app/Controllers/users_controller.dart';
import 'package:firebase_login_app/Screens/edit_profile_old.dart';
import 'package:firebase_login_app/Screens/student_edit_profile.dart';
import 'package:flutter/material.dart';

import '../Models/tutor.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
      future: getUserData(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error occurred: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(
            child: Text('User data not found.'),
          );
        }

        // User data exists
        Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;
        List<ProfileInfoItem> items = [
          ProfileInfoItem(userData['email'], 'Email'),
          ProfileInfoItem(userData['phone'], 'Phone'),
        ];
        List<ProfileInfoItem> itemsTwo = [
          ProfileInfoItem(userData['location'], 'Location'),
        ];

        return Column(
          children: [
            Expanded(flex: 2, child: TopPortion(context, userData)),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      userData['name'],
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16.0),
                        // FloatingActionButton.extended(
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const EditProfileUI(),
                        //         ));
                        //   },
                        //   heroTag: 'setting',
                        //   elevation: 0,
                        //   backgroundColor: Colors.yellow[700],
                        //   label: const Text("Setting"),
                        //   icon: const Icon(Icons.message_rounded),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // ProfileInfoRow(
                    //     location: location,
                    //     hourly_rate: hourly_rate,
                    //     subj: subject),
                    dataList(context, itemsTwo),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return GestureDetector(
                            onTap: () {
                              print('Grid Item $index tapped');
                            },
                            child: Container(
                              color: Color.fromARGB(255, 186, 0, 186),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (item.title == 'Reviews')
                                    _reviewsItem(context,
                                        item) // Use _reviewsItem for "Reviews" item
                                  else
                                    _singleItem(context, item),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Text(
          item.title,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  Widget _reviewsItem(BuildContext context, ProfileInfoItem item) {
    double rating =
        double.tryParse(item.value) ?? 0.0; // Parse the rating value
    int starCount = rating.round(); // Round the rating to the nearest integer

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              if (index < starCount) {
                return Icon(
                  Icons.star,
                  color: Colors.yellow,
                );
              } else {
                return Icon(
                  Icons.star_border,
                  color: Colors.yellow,
                );
              }
            }),
          ),
        ),
        Text(
          item.title,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  dataList(BuildContext context, List<ProfileInfoItem> itemsTwo) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itemsTwo
            .map((item) => Expanded(
                  child: Row(
                    children: [
                      if (itemsTwo.indexOf(item) != 0) const VerticalDivider(),
                      Expanded(
                        child: item.title == 'Reviews'
                            ? _reviewsItem(context,
                                item) // Use _reviewsItem for "Reviews" item
                            : _singleItem(context,
                                item), // Use _singleItem for other items
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

Widget _singleItem(BuildContext context, ProfileInfoItem item) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      Text(
        item.title,
        style: Theme.of(context).textTheme.caption,
      ),
    ],
  );
}

Widget _reviewsItem(BuildContext context, ProfileInfoItem item) {
  double rating = double.tryParse(item.value) ?? 0.0; // Parse the rating value
  int starCount = rating.round(); // Round the rating to the nearest integer

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            if (index < starCount) {
              return Icon(
                Icons.star,
                color: Colors.yellow,
              );
            } else {
              return Icon(
                Icons.star_border,
                color: Colors.yellow,
              );
            }
          }),
        ),
      ),
      Text(
        item.title,
        style: Theme.of(context).textTheme.caption,
      ),
    ],
  );
}

class ProfileInfoItem {
  final String title;
  final String value;
  const ProfileInfoItem(this.title, this.value);
}

@override
Widget TopPortion(BuildContext context, Map<String, dynamic> userData) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 186, 0, 186),
              Color.fromARGB(255, 245, 188, 33)
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentEditProfileUI()));
              print('Settings button tapped');
            },
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: NetworkImage(),
                  // ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    color: Colors.black,
                    onPressed: () {
                      // Handle camera button tap
                      print('Camera button tapped');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
