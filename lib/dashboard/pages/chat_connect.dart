import 'package:firefriday/business_logic/events/create_event.dart';
import 'package:firefriday/constants/chat_post_item.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/dashboard/pages/events/create_new_post.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class ChatConnectPage extends StatefulWidget {
  @override
  State<ChatConnectPage> createState() => _ChatConnectPageState();
}

class _ChatConnectPageState extends State<ChatConnectPage> {
  List<Map<String, dynamic>> posts = [];
  List<int> likedPosts = [];

  //Order posts  by most likes
  // void hotStudents(int index) {
  //   setState(() {
  //     posts.sort((a, b) => b['likes'].compareTo(a['likes']));
  //   });
  // }

  String prefEmail = '';
  bool liked_already = false;

  List<Map<String, dynamic>> liked_posts = [];

  //get email from shared prefs
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail().then((value) => setState(() {
          prefEmail = value!;
        }));
    getPosts().then((value) => setState(() {
          posts = value!;
        }));
    print(posts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts
            .length, // Replace with the actual number of containers you want to display
        itemBuilder: (context, index) {
          // Generate a random color for each container
          final color = Color((index * 0x11111111) % 0xFFFFFFFF);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StyledImageContainer(
              isLiked: liked_already,
              likes: posts[index]['likes'],
              imageUrl: posts[index]['image'],
              description: posts[index]['description'],
              phone: posts[index]['phone'],
              email: posts[index]['email'],
              id: posts[index]['id'].toString(),
              onLike: () {
                getLikedPosts().then((value) => setState(() {
                      liked_posts = value!;
                    }));
                //loop through liked_posts and check if we have prefEmail and post id
                print("LIKED POSTS: $liked_posts");
                if (liked_posts.isEmpty) {
                  print("EMPTY");
                  updateLikes(prefEmail, posts[index]['id'], true);
                }
                for (var i = 0; i < liked_posts.length; i++) {
                  if (liked_posts[i]['email'] == prefEmail &&
                      liked_posts[i]['id'] == posts[index]['id']) {
                    //if we have it, remove it
                    liked_already = true;
                    updateLikes(prefEmail, posts[index]['id'], false);
                    print("ALREADY LIKED");
                  } else {
                    //if we don't have it, add it
                    liked_already = false;
                    updateLikes(prefEmail, posts[index]['id'], true);
                    print("NOT LIKED");
                  }
                }

                // bool isLiked = likedPosts.contains(posts[index]['id']);

                getPosts().then((value) => setState(() {
                      posts = value!;
                    }));
              },
            ),
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20.0, // Adjust for desired bottom spacing
            right: 5.0, // Adjust for desired right spacing
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              onPressed: () {
                if (prefEmail.isNotEmpty) {
                  context.push(() => CreatePostPage());
                } else {}
              },
              icon: const Icon(
                UniconsLine.camera_plus,
                color: primaryColor,
              ),
              label: const Text(
                'New Post',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 20.0, // Adjust for desired bottom spacing
          //   right: 5.0, // Adjust for desired right spacing
          //   child: ElevatedButton.icon(
          //     style: ElevatedButton.styleFrom(
          //       shape: StadiumBorder(),
          //     ),
          //     onPressed: () {},
          //     icon: const Icon(
          //       UniconsLine.edit_alt,
          //       color: primaryColor,
          //     ),
          //     label: const Text(
          //       'Manage Posts',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
