import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<Blog>> fetchAllBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);
    return jsonData.map((json) => Blog.fromJson(json)).toList();
  }

  Future<Blog> fetchAllBlogsid(String blogID) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/${blogID}");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    return Blog.fromJson(jsonData);
  }

  Future<void> fetchDeleteBlogsid(String blogID) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/${blogID}");
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print("Blog başarıyla silindi");
      } else {
        print("Blog silinemedi. Hata kodu: ${response.statusCode}");
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  submitForm(Blog blogAdd, BuildContext context) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    if (blogAdd.thumbnail != null) {
      request.files.add(await http.MultipartFile.fromPath(
          "File", blogAdd.thumbnail.toString()));
    }

    request.fields['Title'] = blogAdd.title.toString();
    request.fields['Content'] = blogAdd.content.toString();
    request.fields['Author'] = blogAdd.author.toString();

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }
}
