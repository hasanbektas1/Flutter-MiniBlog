import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/bloc/article_bloc/article_bloc.dart';
import 'package:miniblog/bloc/article_bloc/article_event.dart';
import 'package:miniblog/bloc/article_bloc/article_state.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
/*   List<Blog> blogs = [];
  List<Blog> reversedBlogs = []; */

  @override
  void initState() {
    super.initState();
    //fetchBlogs();
  }

/*   fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    setState(() {
      blogs = jsonData.map((json) => Blog.fromJson(json)).toList();
      reversedBlogs = blogs.reversed.toList();
    });
  } */

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.portrait) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Bloglar"),
              actions: [
                IconButton(
                    onPressed: () async {
                      bool? result = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => AddBlog()));

                      if (result == true) {
                        context.read<ArticleBloc>().add(Fetcharticles());
                      }
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
              if (state is ArticlesInitial) {
                context
                    .read<ArticleBloc>()
                    .add(Fetcharticles()); // UI'dan BLOC'a Event
                return const Center(child: Text("İStek atılıyor.."));
              }
              if (state is ArticlesLoading) {
                print("loading");

                return const Center(child: CircularProgressIndicator());
              }
              if (state is ArticlesLoaded) {
                return ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: ((context, index) =>
                      BlogItem(blog: state.blogs[index])),
                );
              }
              if (state is ArticlesError) {
                return const Center(
                    child: Text("Bloglar yüklenirken bir hata oluştu"));
              }

              return const Center(child: Text("Unknown State"));
            }));
      } else {
        const Center(child: Text("Landscape"));
        return const Center(child: Text("Unknown State"));
      }
    });
  }
}
