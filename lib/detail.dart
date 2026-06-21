import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models.dart';
import 'services.dart';

class DetailPage extends StatefulWidget {

  final ArticleModel article;

  const DetailPage({
    super.key,
    required this.article,
  });

  @override
  State<DetailPage> createState() =>
      _DetailPageState();
}

class _DetailPageState
    extends State<DetailPage> {

  bool isFavorite = false;

  Future<void> saveFavorite() async {

    final uid =
        FirebaseAuth.instance
            .currentUser!
            .uid;

    await FirestoreService
        .addFavorite(
      uid: uid,
      article: widget.article,
    );

    setState(() {
      isFavorite = true;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text("Saved to Favorite"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final article = widget.article;

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Article Detail",
        ),

        actions: [

          IconButton(
            onPressed:
                isFavorite
                    ? null
                    : saveFavorite,

            icon: Icon(
              Icons.favorite,

              color: isFavorite
                  ? Colors.red
                  : Colors.white,
            ),
          ),
        ],
      ),

      body:
          SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Image.network(
              article.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            Padding(
              padding:
                  const EdgeInsets.all(
                      16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(
                    article.title,

                    style:
                        const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(
                    article.newsSite,
                    style:
                        const TextStyle(
                      color:
                          Colors.grey,
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  Text(
                    article.summary,
                    textAlign:
                        TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}