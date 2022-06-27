import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String caption;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profileUrl;
  final likes;

  const Post({
    required this.caption,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileUrl,
    required this.uid,
    required this.username,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'caption': caption,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profileUrl': profileUrl,
        'likes': likes,
        'postId': postId,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      caption: snapshot['caption'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      profileUrl: snapshot['profileUrl'],
      likes: snapshot['likes'],
      postId: snapshot['postId'],
    );
  }
}
