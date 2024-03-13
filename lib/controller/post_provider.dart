// ignore_for_file: avoid_print
import 'package:chat_app/service/service.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final TextEditingController commentTextController = TextEditingController();
  final FirestoreService _postService = FirestoreService();
  bool isLiked = false;
  int commentCount = 0;

  void toggleLike(String postId, bool isCurrentlyLiked) async {
    await _postService.toggleLike(postId, !isCurrentlyLiked);
    notifyListeners();
  }

  Future<void> addComment(String postId, String commentText) async {
    await _postService.addComment(postId, commentText);
    await fetchCommentCount(postId);
    notifyListeners();
  }

  Future<void> fetchCommentCount(String postId) async {
    print("Fetching comment count for post ID: $postId");
    commentCount = await _postService.fetchCommentCount(postId);
    print("Fetched comment count: $commentCount");
    notifyListeners();
  }

  Future<void> deletePost(String postId) async {
    await _postService.deletePost(postId);
    notifyListeners();
  }
}
