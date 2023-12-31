import 'package:miniblog/models/blog.dart';

abstract class ArticleDetailState {}

class ArticlesDetailInitial extends ArticleDetailState {}

class ArticlesDetailLoaded extends ArticleDetailState {
  final Blog blogsid;
  ArticlesDetailLoaded({required this.blogsid});
}

class ArticlesDetailLoading extends ArticleDetailState {}

class ArticlesDetailError extends ArticleDetailState {}
