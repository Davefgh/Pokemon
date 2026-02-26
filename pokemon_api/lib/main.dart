import 'package:flutter/material.dart';
import 'Class/pokemon.dart';
import 'Class/pokemon_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon API Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PokeAPI Integration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PokemonService _pokemonService = PokemonService();
  Pokemon? _pokemon;
  bool _isLoading = false;
  String? _error;

  void _fetchPokemon() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final pokemon = await _pokemonService.fetchPokemon('ditto');
      setState(() {
        _pokemon = pokemon;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(widget.title),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _error != null
                ? Text('Error: $_error',
                    style: const TextStyle(color: Colors.red))
                : _pokemon == null
                    ? const Text('Press the button to fetch a Pokemon')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_pokemon!.sprites.frontDefault.isNotEmpty)
                            Image.network(
                              _pokemon!.sprites.frontDefault,
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            _pokemon!.name.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[700],
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text('ID: ${_pokemon!.id}',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text('Height: ${_pokemon!.height}',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text('Weight: ${_pokemon!.weight}',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPokemon,
        tooltip: 'Refresh Pokemon',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
