import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/bloc/article_bloc/article_bloc.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/repositories/article_repository.dart';
import 'package:miniblog/screens/home_page.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    // Multi ile birden çok bloc eklleyebilme
    BlocProvider<ArticleBloc>(
        create: (context) =>
            ArticleBloc(articleRepository: ArticleRepository())),
    BlocProvider<ArticleDetailBloc>(
        create: (context) =>
            ArticleDetailBloc(articleRepository: ArticleRepository()))
  ], child: const MaterialApp(home: Homepage())));
}
