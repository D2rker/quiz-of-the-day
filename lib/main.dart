import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'quote.dart';

void main() {
  runApp(InspiringQuotesApp());
}

class InspiringQuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspiring Quotes',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Quote> _favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteQuotes();
  }

  void _loadFavoriteQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteQuotesJson = prefs.getStringList('favoriteQuotes');
    if (favoriteQuotesJson != null) {
      setState(() {
        _favoriteQuotes = favoriteQuotesJson.map((e) => Quote.fromJson(jsonDecode(e))).toList();
      });
    } else {
      _favoriteQuotes = [];
    }
  }

  void _saveFavoriteQuote(Quote quote) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteQuotes.add(quote);
      List<String> favoriteQuotesJson = _favoriteQuotes.map((e) => jsonEncode(e.toJson())).toList();
      prefs.setStringList('favoriteQuotes', favoriteQuotesJson);
    });
  }

  void _deleteFavoriteQuote(Quote quote) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteQuotes.remove(quote);
      List<String> favoriteQuotesJson = _favoriteQuotes.map((e) => jsonEncode(e.toJson())).toList();
      prefs.setStringList('favoriteQuotes', favoriteQuotesJson);
    });
  }

  void _shareQuote(Quote quote) {
    Share.share('${quote.text} - ${quote.author}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspiring Quotes',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: sampleQuotes.length,
        itemBuilder: (context, index) {
          return _buildQuotePage(sampleQuotes[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoriteQuotesScreen(
                favoriteQuotes: _favoriteQuotes,
                onDelete: _deleteFavoriteQuote,
              ),
            ),
          ).then((_) => _loadFavoriteQuotes()); // Refresh the list after returning
        },
        child: Icon(Icons.favorite, size: 30),
      ),
    );
  }

  Widget _buildQuotePage(Quote quote) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 550,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent, Colors.lightBlue],
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Text(
                quote.text,
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '- ${quote.author}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.right,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _saveFavoriteQuote(quote),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Updated parameter
                    ),
                    child: Text('Save'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _shareQuote(quote),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Updated parameter
                    ),
                    child: Text('Share'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteQuotesScreen extends StatelessWidget {
  final List<Quote> favoriteQuotes;
  final Function(Quote) onDelete;

  FavoriteQuotesScreen({required this.favoriteQuotes, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Quotes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: favoriteQuotes.isEmpty
          ? Center(child: Text('No favorite quotes yet.'))
          : ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          final quote = favoriteQuotes[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                quote.text,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                '- ${quote.author}',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.black),
                onPressed: () {
                  onDelete(quote); // Call the onDelete callback
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
