import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';

abstract class ArticleEvent {}

class Fetcharticles extends ArticleEvent {}

class ArticleAdd extends ArticleEvent {
  final Blog blogadd;
  final BuildContext context;

  ArticleAdd({required this.blogadd, required this.context});
}
