import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.blogId}) : super(key: key);

  final String blogId;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Map<String, dynamic> blogs = {};
  late Blog blogItem;

  // https://tobetoapi.halitkalayci.com/api/Articles/17d1549f-3220-48bb-9ee8-08dc01eef2df
  // https://tobetoapi.halitkalayci.com/api/Articles

  fetchBlogsItem() async {
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
  }

  deleteBlogItem() async {
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
  }

  @override
  void initState() {
    super.initState();
    fetchBlogsItem();
    blogItem = Blog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Detay"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (blogItem.thumbnail != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    blogItem.thumbnail.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              blogItem.title.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              blogItem.content.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "Yazar: ${blogItem.author.toString()}",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                deleteBlogItem();
              },
              child: const Text("Sil"),
            ),
          ],
        ),
      ),
    );
  }
}
