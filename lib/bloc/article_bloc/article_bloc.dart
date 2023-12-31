import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/bloc/article_bloc/article_event.dart';
import 'package:miniblog/bloc/article_bloc/article_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc({required this.articleRepository}) : super(ArticlesInitial()) {
    on<Fetcharticles>(_onFetcArticlees);
    on<ArticleAdd>(_onArticleAdd);
  }

  void _onFetcArticlees(Fetcharticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());

    try {
      final articles = await articleRepository.fetchAllBlogs();
      emit(ArticlesLoaded(blogs: articles));
    } catch (e) {
      emit(ArticlesError());
    }
  }

  void _onArticleAdd(ArticleAdd event, Emitter<ArticleState> emit) async {
    try {
      await articleRepository.submitForm(event.blogadd, event.context);
    } catch (e) {
      emit(ArticlesError());
    }
  }
}
