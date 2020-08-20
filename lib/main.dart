import 'package:flutter/material.dart';
import 'package:flutter_json_serializable/data/post_api_services.dart';

import 'models/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Json Serializable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar => AppBar(title: Text('Flutter Json Serializable'));

  Widget get body => FutureBuilder(
        future: PostAPIServices.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (!snapshot.hasData) {
              return Center(child: Text('Something wrong!'));
            }

            if (snapshot.data is String) {
              return Center(child: Text(snapshot.data));
            }

            return buildPostListView(snapshot.data);
          }

          return Center(child: CircularProgressIndicator());
        },
      );

  Widget buildPostListView(List<Post> posts) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) => postListTile(posts[index]),
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemCount: posts.length,
    );
  }

  Widget postListTile(Post post) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.black12,
      child: Column(
        children: [
          Text(
            post.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(post.body, textAlign: TextAlign.start),
        ],
      ),
    );
  }
}
