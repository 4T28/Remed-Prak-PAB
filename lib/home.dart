import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';
import 'services.dart';
import 'widgets.dart';
import 'detail.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  final pages = [
    const DashboardPage(),
    const FavoritePage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.card,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SpaceNews Core",
        ),
      ),

      body: FutureBuilder<List<ArticleModel>>(

        future: ApiService.getArticles(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No News"),
            );
          }

          final articles = snapshot.data!;

          return Column(
            children: [

              Container(
                height: 180,
                margin:
                    const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: articles.first.imageUrl.isNotEmpty
                        ? NetworkImage(
                            articles.first.imageUrl,
                          )
                        : const AssetImage(
                            "assets/logo.jpg",
                          ),
                  ),
                ),

                alignment:
                    Alignment.bottomLeft,

                child: Container(
                  padding:
                      const EdgeInsets.all(10),

                  color: Colors.black54,

                  child: Text(
                    "Headline News",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(

                  itemCount:
                      articles.length,

                  itemBuilder:
                      (context, index) {

                    final article =
                        articles[index];

                    return NewsCard(
                      title:
                          article.title,

                      imageUrl:
                          article.imageUrl,

                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                DetailPage(
                              article:
                                  article,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorite News",
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream:
            FirestoreService.getFavorites(uid),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final docs =
              snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada favorit",
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,

            itemBuilder: (context, index) {

              final data =
                  docs[index];

              return ListTile(

                leading:
                    const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),

                title:
                    Text(data["title"]),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationPage
    extends StatelessWidget {

  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Notification"),
      ),

      body:
          StreamBuilder<QuerySnapshot>(

        stream:
            FirestoreService
                .getNotifications(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final docs =
              snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "No Notification",
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,

            itemBuilder:
                (context, index) {

              final data =
                  docs[index];

              return ListTile(

                leading: const Icon(
                  Icons.notifications,
                ),

                title:
                    Text(data["title"]),

                subtitle:
                    Text(
                  data["message"],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Profile"),
      ),

      body:
          FutureBuilder<DocumentSnapshot>(

        future: FirebaseFirestore
            .instance
            .collection("users")
            .doc(uid)
            .get(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final data =
              snapshot.data!.data()
                  as Map<String, dynamic>;

          return Padding(
            padding:
                const EdgeInsets.all(20),

            child: Column(

              children: [

                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(
                    "https://i.pravatar.cc/300",
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  data["name"],
                  style:
                      const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Text(data["email"]),

                Text(
                  data["instagram"],
                ),

                const SizedBox(height: 30),

                CustomButton(
                  text: "Log Out",

                  onPressed: () async {

                    await AuthService
                        .logout();

                    if (!context.mounted)
                      return;

                    Navigator
                        .pushAndRemoveUntil(

                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const RegisterPage(),
                      ),

                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}