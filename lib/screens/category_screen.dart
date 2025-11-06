import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etheramind/providers/quiz_provider.dart';
import 'package:etheramind/utils/constants.dart';
import 'package:etheramind/widgets/category_card.dart';
import 'package:etheramind/screens/quiz_screen.dart';
import 'package:etheramind/providers/theme_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final etheramindProvider = Provider.of<EtheramindProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final categories = etheramindProvider.categories;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Pilih Kategori',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary, 
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white, 
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (etheramindProvider.user != null) ...[
              Text(
                'Halo, ${etheramindProvider.user!.name}!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground, // ✅ TEST 3
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih kategori kuis yang ingin Anda coba',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7), // ✅ TEST 4
                ),
              ),
              const SizedBox(height: 24),
            ] else ...[
              Text(
                'Halo!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground, // ✅ TEST 5
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih kategori kuis yang ingin Anda coba',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7), // ✅ TEST 6
                ),
              ),
              const SizedBox(height: 24),
            ],
            
            // Categories Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  
                  return CategoryCard(
                    category: category,
                    onTap: () {
                      etheramindProvider.resetCategory(category.id);
                      etheramindProvider.setCurrentCategory(category.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(category: category),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

