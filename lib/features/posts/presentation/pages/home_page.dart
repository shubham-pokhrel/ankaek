import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../cubit/posts_cubit.dart';
import '../widgets/online_posts_tab.dart';
import '../widgets/saved_posts_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostsCubit>(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Anka Ek',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.cloud_outlined),
                  text: 'Online',
                ),
                Tab(
                  icon: Icon(Icons.bookmark_outline),
                  text: 'Saved',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              OnlinePostsTab(),
              SavedPostsTab(),
            ],
          ),
        ),
      ),
    );
  }
}