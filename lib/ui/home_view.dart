import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:vocabulary_app/cubit/login/login_cubit.dart';
import 'package:vocabulary_app/cubit/random_cubit.dart';
import 'package:vocabulary_app/model/random_model.dart';
import 'package:vocabulary_app/ui/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/ui/widgets/word_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Başlangıçta veri çek
    Future.microtask(() => context.read<RandomCubit>().fetchRandomWord());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await context.read<LoginCubit>().logout();
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RandomCubit, RandomModel?>(
        builder: (context, state) {
          if (state == null) {
            Future.microtask(() => context.read<RandomCubit>().fetchRandomWord());
            return Center(child: CircularProgressIndicator());
          }

          return CardSwiper(
            cardsCount: 1,
            numberOfCardsDisplayed: 1,
            cardBuilder:
                (BuildContext context, int index, int horizontalOffsetPercentage, int verticalOffsetPercentage) {
              final word = state.word;
              return WordCard(
                word: word,
                meaning: word.meaning,
                pronunciation: word.pronunciation,
                example: word.example,
                level: word.level,
              );
            },
            onSwipe: (previousIndex, currentIndex, direction) {
              if (direction != CardSwiperDirection.none) {
                print('Yeni kelime çekiliyor...');

                context.read<RandomCubit>().fetchRandomWord();
              }
              return true;
            },
          );
        },
      ),
    );
  }
}
