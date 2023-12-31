abstract class ArticleDetailEvent {}

class FetchDetailarticlesid extends ArticleDetailEvent {
  final String blogId;

  FetchDetailarticlesid({required this.blogId});
}

class ResetDetailEvent extends ArticleDetailEvent {}
