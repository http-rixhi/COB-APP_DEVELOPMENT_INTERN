import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_gallery_with_login/pages/media_view_page.dart';
import 'package:media_gallery_with_login/screens/login_screen.dart';
import 'package:toast/toast.dart';

class MediaGalleryScreen extends StatelessWidget {
  MediaGalleryScreen({Key? key}) : super(key: key);

  final List<String> photos = [
    'https://cdn.pixabay.com/photo/2014/12/16/22/25/woman-570883_640.jpg',
    'https://cdn.pixabay.com/photo/2015/06/19/21/24/avenue-815297_640.jpg',
    'https://cdn.pixabay.com/photo/2018/11/06/14/01/couple-3798371_640.jpg',
    'https://cdn.pixabay.com/photo/2015/06/22/08/37/children-817365_640.jpg',
    'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg',
    'https://cdn.pixabay.com/photo/2017/02/08/17/24/fantasy-2049567_640.jpg',
    'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/12/16/22/25/sunset-570881_640.jpg',
    'https://cdn.pixabay.com/photo/2018/07/21/03/55/woman-3551832_640.jpg',
    'https://cdn.pixabay.com/photo/2017/01/27/16/09/girl-2013447_640.jpg',
    'https://cdn.pixabay.com/photo/2016/04/04/14/12/monitor-1307227_640.jpg',
    'https://cdn.pixabay.com/photo/2018/05/08/08/44/artificial-intelligence-3382507_640.jpg',
    'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_640.jpg',
    'https://cdn.pixabay.com/photo/2019/04/11/22/57/robot-4120890_640.jpg',
    'https://cdn.pixabay.com/photo/2019/06/04/13/34/fantasy-4251452_640.jpg',
    'https://cdn.pixabay.com/photo/2015/06/12/06/10/heart-806512_640.jpg',
    'https://cdn.pixabay.com/photo/2012/11/28/09/08/mars-67522_640.jpg',
    'https://cdn.pixabay.com/photo/2017/03/26/11/33/binary-2175285_640.jpg',
    'https://cdn.pixabay.com/photo/2017/12/11/15/34/lion-3012515_640.jpg',
    'https://cdn.pixabay.com/photo/2016/11/29/13/25/ace-1869825_640.jpg',
    'https://cdn.pixabay.com/photo/2016/09/13/09/25/kite-1666816_640.jpg',
    'https://cdn.pixabay.com/photo/2017/12/11/15/34/lion-3012515_640.jpg',
  ];

  final FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Media Gallery"),
        actions: [
          PopupMenuButton(itemBuilder: (context){
            return [
              const PopupMenuItem(
                value: 0,
                child: Text('LOGOUT'),
              )
            ];
          },
            onSelected: (value){
            if(value == 0) {
              signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginScreen(controller: PageController()
              )));
              Toast.show('Logged Out Successfully');
            }
            },
          )
        ],
      ),

      body: GridView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.all(1),
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.all(0.5),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MediaViewPage(photos: photos, index: index),
                ),
              ),
              child: Hero(
                tag: photos[index],
                child: CachedNetworkImage(
                  imageUrl: photos[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
