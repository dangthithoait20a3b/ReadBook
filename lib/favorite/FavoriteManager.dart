import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter2/models/post.dart';

class FavoriteManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DatabaseReference _favoriteRef =
  FirebaseDatabase.instance.reference().child('users').child('userId').child('favorites');

  // add a book to user's favorite list
  Future<void> addToFavorite(String userId, Post book) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(book.id)
        .set({'book': book.toJson()});
  }

  // remove a book from user's favorite list
  Future<void> removeFromFavorite(String userId, Post book) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(book.id)
        .delete();
  }

  // get user's favorite list
  Stream<List<Post>> getFavorite(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.get('book');
        return Post.fromJson(data);
      }).toList();
    });
  }


}
