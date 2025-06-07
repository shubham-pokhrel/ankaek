import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/posts_cubit.dart';
import 'post_card.dart';

class SavedPostsTab extends StatefulWidget {
  const SavedPostsTab({super.key});

  @override
  State<SavedPostsTab> createState() => _SavedPostsTabState();
}

class _SavedPostsTabState extends State<SavedPostsTab> {
  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().loadSavedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is PostDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post deleted successfully!'),
              backgroundColor: Colors.orange,
            ),
          );
        } else if (state is PostDeleteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting post: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SavedPostsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SavedPostsError) {
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
                  'Error loading saved posts',
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
                  onPressed: () => context.read<PostsCubit>().loadSavedPosts(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is SavedPostsLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No saved posts yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Save posts from the Online tab to see them here',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }
          
          return RefreshIndicator(
            onRefresh: () async {
              context.read<PostsCubit>().loadSavedPosts();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostCard(
                  post: post,
                  onDelete: () => context.read<PostsCubit>().deletePostFromLocal(post.id),
                  showDeleteButton: true,
                );
              },
            ),
          );
        }
        
        return const Center(
          child: Text('No saved posts available'),
        );
      },
    );
  }
}