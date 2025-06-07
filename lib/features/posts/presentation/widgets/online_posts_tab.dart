import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/posts_cubit.dart';
import 'post_card.dart';

class OnlinePostsTab extends StatefulWidget {
  const OnlinePostsTab({super.key});

  @override
  State<OnlinePostsTab> createState() => _OnlinePostsTabState();
}

class _OnlinePostsTabState extends State<OnlinePostsTab> {
  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is PostSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is PostSaveError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving post: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PostsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostsError) {
          debugPrint("Error loading posts: ${state.message}");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading posts',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<PostsCubit>().loadPosts(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is PostsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<PostsCubit>().loadPosts();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostCard(
                  post: post,
                  onSave: () => context.read<PostsCubit>().savePostToLocal(post),
                  showSaveButton: true,
                );
              },
            ),
          );
        }
        
        return const Center(
          child: Text('No posts available'),
        );
      },
    );
  }
}