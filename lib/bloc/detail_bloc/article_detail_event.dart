abstract class ArticleDetailEvent {}

class FetchDetailarticlesid extends ArticleDetailEvent {
  final String blogId;

  FetchDetailarticlesid({required this.blogId});
}

class ResetDetailEvent extends ArticleDetailEvent {}

class DeleteArticleEvent extends ArticleDetailEvent {
  final String blogId;

  DeleteArticleEvent({required this.blogId});
}
