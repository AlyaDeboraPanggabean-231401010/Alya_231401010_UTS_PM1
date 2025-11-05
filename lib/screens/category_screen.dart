import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etheramind/providers/quiz_provider.dart';
import 'package:etheramind/utils/constants.dart';
import 'package:etheramind/widgets/category_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final etheramindProvider = Provider.of<EtheramindProvider>(context);
    final categories = etheramindProvider.categories;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Pilih Kategori',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Tambahkan ini untuk membuat title di tengah
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            if (etheramindProvider.user != null) ...[
              Text(
                'Halo, ${etheramindProvider.user!.name}!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih kategori kuis yang ingin Anda coba',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
            ] else ...[
              // Fallback jika user null
              Text(
                'Halo!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih kategori kuis yang ingin Anda coba',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
            ],
            
            // Categories Grid menggunakan CategoryCard
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
                  final score = etheramindProvider.getScoreForCategory(category.id);
                  
                  return CategoryCard(
                    category: category,
                    score: score,
                    onTap: () {
                      etheramindProvider.setCurrentCategory(category.id);
                      // TODO: Navigasi ke halaman kuis nanti
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