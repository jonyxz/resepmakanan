import 'package:flutter/material.dart';
import 'recipe.dart';
import 'add_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Resep'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipeScreen(recipe: recipe),
                ),
              ).then((_) {
                Navigator.pop(context, true);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              'Waktu persiapan: ${recipe.preparationTime}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 30, thickness: 2),
            const Text(
              'Bahan-bahan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(recipe.ingredients),
            const SizedBox(height: 20),
            const Text(
              'Langkah-langkah:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}
