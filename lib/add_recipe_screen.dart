import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  final Recipe? recipe;

  const AddRecipeScreen({super.key, this.recipe});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prepTimeController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _nameController.text = widget.recipe!.name;
      _prepTimeController.text = widget.recipe!.preparationTime;
      _ingredientsController.text = widget.recipe!.ingredients;
      _instructionsController.text = widget.recipe!.instructions;
    }
  }

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = Recipe(
        id: widget.recipe?.id,
        name: _nameController.text.trim(),
        preparationTime: _prepTimeController.text.trim(),
        ingredients: _ingredientsController.text.trim(),
        instructions: _instructionsController.text.trim(),
      );

      if (widget.recipe == null) {
        await _dbHelper.insertRecipe(recipe);
      } else {
        await _dbHelper.updateRecipe(recipe);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Tambah Resep' : 'Edit Resep'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Resep'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'masukan nama' : null,
              ),
              TextFormField(
                controller: _prepTimeController,
                decoration: const InputDecoration(labelText: 'Waktu Persiapan'),
                validator: (value) => value == null || value.isEmpty
                    ? 'masukan waktu persiapan'
                    : null,
              ),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(labelText: 'Bahan-bahan'),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Bahan masakan' : null,
              ),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(labelText: 'Instructions'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter instructions'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text(widget.recipe == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
