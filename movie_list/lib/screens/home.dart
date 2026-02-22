import 'package:flutter/material.dart';
import 'package:movie_list/data/movie_data.dart';
import 'package:movie_list/models/movies.dart';
import 'package:movie_list/components/movie_skeleton.dart';

const String movieTitle = "Movixor";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Movie selectedMovie;
  bool isLoadingAll = true;
  bool isLoadingDetail = false;

  @override
  void initState() {
    super.initState();
    selectedMovie = movies.first;
    _startInitialLoad();
  }

  void _startInitialLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        isLoadingAll = false;
      });
    }
  }

  void _onMovieSelected(Movie movie) async {
    if (selectedMovie.id == movie.id) return;

    setState(() {
      isLoadingDetail = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        selectedMovie = movie;
        isLoadingDetail = false;
      });
    }
  }

  void selectMovie(Movie movie) {
    _onMovieSelected(movie);
  }

  String truncate(String text, int length) {
    if (text.length <= length) return text;
    return '${text.substring(0, length)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          movieTitle,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.amberAccent, height: 1, thickness: 1),
        ),
      ),
      body: Column(
        children: [
          // Featured Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 30.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(
                bottom: BorderSide(color: Colors.white12, width: 1),
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: (isLoadingAll || isLoadingDetail)
                  ? const MovieSkeletonDetail()
                  : Column(
                      key: ValueKey<int>(selectedMovie.id),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            selectedMovie.image,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          selectedMovie.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          truncate(selectedMovie.description, 120),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Director: ${selectedMovie.director}',
                          style: const TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // Scrollable List
          Expanded(
            child: isLoadingAll
                ? ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        const MovieSkeletonListItem(),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      final isSelected = selectedMovie.id == movie.id;

                      return GestureDetector(
                        onTap: () => _onMovieSelected(movie),
                        child: Card(
                          color: isSelected ? Colors.white10 : Colors.black26,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  movie.image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      truncate(movie.description, 80),
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Director: ${movie.director}',
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      'Date: ${movie.releasedDate.year}-${movie.releasedDate.month.toString().padLeft(2, '0')}-${movie.releasedDate.day.toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
