import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_event.dart';
import 'package:miniblog/bloc/detail_bloc/article_detail_state.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.blogId}) : super(key: key);

  final String blogId;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
/*   late Map<String, dynamic> blogs = {};
  late Blog blogItem; */

  // https://tobetoapi.halitkalayci.com/api/Articles/17d1549f-3220-48bb-9ee8-08dc01eef2df
  // https://tobetoapi.halitkalayci.com/api/Articles

/*   fetchBlogsItem() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);

    setState(() {
      blogs = jsonData;
      //blog = Blog.fromJson(jsonData);
      // blogs = Blog.fromJson(jsonData);
      blogItem = Blog.fromJson(blogs);
    });
  } */

/*   deleteBlogItem() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      print("Silindi");
    }

    setState(() {
      blogItem = Blog.fromJson(blogs);
      Navigator.pop(context);
    });
  } */

  @override
  void initState() {
    super.initState();
    //  fetchBlogsItem();
    // blogItem = Blog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog Detay"),
        ),
        body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
          builder: (context, state) {
            if (state is ArticlesDetailInitial) {
              print("detail ArticlesDetailInitial");

              context.read<ArticleDetailBloc>().add(FetchDetailarticlesid(
                  blogId: widget.blogId)); // UI'dan BLOC'a Event
              return const Center(child: Text("İstek"));
            }

            if (state is ArticlesDetailLoading) {
              print("ArticlesDetailLoading");

              return const Center(child: CircularProgressIndicator());
            }
            if (state is ArticlesDetailLoaded) {
              print("loaded");

              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.blogsid.thumbnail != null)
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            state.blogsid.thumbnail.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      state.blogsid.title.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.blogsid.content.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Yazar: ${state.blogsid.author.toString()}",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        //   deleteBlogItem(); Bloc ile Geliştirilecek...
                      },
                      child: const Text("Sil"),
                    ),
                  ],
                ),
              );
            }

            if (state is ArticlesDetailError) {
              return const Center(
                  child: Text("Bloglar yüklenirken bir hata oluştu"));
            }

            return const Center(child: Text("Unknown State"));
          },
        ));
  }
}
