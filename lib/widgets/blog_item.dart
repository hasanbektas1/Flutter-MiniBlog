import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_event.dart';
import 'package:miniblog/models/blog.dart';

import '../screens/detail_screen.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AspectRatio(
                  aspectRatio: 4 / 2,
                  child: Container(
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Center(child: Image.network(blog.thumbnail!)))),
              ListTile(
                title: Text(blog.title!),
                subtitle: Text(blog.author!),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        context.read<ArticleDetailBloc>().add(ResetDetailEvent());

        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailScreen(blogId: blog.id!)));
      },
    );
  }
}
