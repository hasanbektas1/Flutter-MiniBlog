import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_event.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final ArticleRepository articleRepository;

  ArticleDetailBloc({required this.articleRepository})
      : super(ArticlesDetailInitial()) {
    on<FetchDetailarticlesid>(_onFetcDetailArticleesid);
    on<ResetDetailEvent>(_onResetDetailArticleesid);
  }

  void _onFetcDetailArticleesid(
      FetchDetailarticlesid event, Emitter<ArticleDetailState> emit) async {
    final String blogID = event.blogId;
    emit(ArticlesDetailLoading());

    try {
      final articlesid = await articleRepository.fetchAllBlogsid(blogID);
      emit(ArticlesDetailLoaded(blogsid: articlesid));
    } catch (e) {
      emit(ArticlesDetailError());
    }
  }

  void _onResetDetailArticleesid(
      ResetDetailEvent event, Emitter<ArticleDetailState> emit) async {
    emit(ArticlesDetailInitial());
  }
}
