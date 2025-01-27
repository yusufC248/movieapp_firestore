// import 'package:flutter/material.dart';

// import '../../../module/cats/persentation/page/cats_page.dart';
// import '../../../module/movie/presentation/pages/favorite_movie_page.dart';

// class TabBarFavorite extends StatefulWidget {
//   const TabBarFavorite({super.key});

//   @override
//   State<TabBarFavorite> createState() => _TabBarFavoriteState();
// }

// class _TabBarFavoriteState extends State<TabBarFavorite>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Color _bgColor = Colors.black;
//   Color _fgColor = Colors.amber;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       setState(() {
//         switch (_tabController.index) {
//           case 0:
//             _bgColor = Colors.black;
//             _fgColor = Colors.amber;
//             break;
//           case 1:
//             _bgColor = Colors.orangeAccent;
//             _fgColor = Colors.black;
//             break;
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Favorites"),
//           backgroundColor: _bgColor,
//           foregroundColor: _fgColor,
//           centerTitle: true,
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(20),
//             child: TabBar(
//               controller: _tabController,
//               indicatorColor: Colors.white,
//               indicatorWeight: 2.0,
//               tabs: [
//                 Tab(
//                     child: Text("Movie",
//                         style: TextStyle(fontSize: 18, color: _fgColor))),
//                 Tab(
//                     child: Text("Cats",
//                         style: TextStyle(fontSize: 18, color: _fgColor))),
//               ],
//             ),
//           ),
//           elevation: 0,
//         ),
//         body: TabBarView(
//           controller: _tabController,
//           children: const [
//             FavoriteMoviePage(),
//             CatsPage(
//               isFavorite: true,
//             )

//             // PlaygroundScreen()
//           ],
//         ),
//       ),
//     );
//   }
// }
