class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  Map<String, dynamic> toJson() => {
    'text': text,
    'author': author,
  };

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'],
      author: json['author'],
    );
  }
}

List<Quote> sampleQuotes = [
  Quote(text: "Believe you can and you’re halfway there.", author: "Theodore Roosevelt"),
  Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
  Quote(text: "ou are never too old to set another goal or to dream a new dream.", author: "C.S. Lewis"),
  Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
  Quote(text: "Happiness can be found even in the darkest of times if one only remembers to turn on the light.", author: "Albus Dumbledore"),
  Quote(text: "You don’t have to be great to start, but you have to start to be great.", author: "Zig Ziglar"),
  Quote(text: "Do something today that your future self will thank you for.", author: "Unknown"),
  Quote(text: "Keep your eyes on the stars, and your feet on the ground.", author: "Theodore Roosevelt"),
  Quote(text: "It always seems impossible until it’s done.", author: "Nelson Mandela"),
  Quote(text: "You don’t have to be perfect to be amazing.", author: "Unknown"),
  Quote(text: "Life is 10% what happens to you and 90% how you react to it.", author: "Charles R. Swindoll"),
  Quote(text: "You are capable of amazing things.", author: "Unknown"),
  Quote(text: "The best way to get started is to quit talking and begin doing.", author: "Walt Disney"),
  Quote(text: "Don’t watch the clock; do what it does. Keep going.", author: "Sam Levenson"),
  Quote(text: "You are never too old to learn something new.", author: "Unknown"),
  Quote(text: "The biggest risk is not taking any risk.", author: "Mark Zuckerberg"),
  Quote(text: "You are stronger than you think, braver than you feel, and smarter than you know.", author: "Unknown"),
  Quote(text: "Success is liking yourself, liking what you do, and liking how you do it.", author: "Maya Angelou"),
  Quote(text: "Do not let what you cannot do interfere with what you can do.", author: "John Wooden"),
  Quote(text: "You are capable of achieving great things.", author: "Unknown"),
  Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
  Quote(text: "You are never too old to chase your dreams.", author: "Unknown"),
  Quote(text: "The biggest adventure you can take is to live the life of your dreams.", author: "Oprah Winfrey"),
  Quote(text: "You are stronger than your excuses.", author: "Unknown"),
  Quote(text: "You are capable of overcoming any obstacle.", author: "Unknown"),
  Quote(text: "The greatest achievement was at first and always seems impossible.", author: "Unknown"),
  Quote(text: "Fall seven times, stand up eight.", author: "Japanese proverb"),
  Quote(text: "Happiness can be found even in the darkest of times if one only remembers to turn on the light.", author: "Albus Dumbledore"),
  Quote(text: "Life is a daring adventure or nothing at all.", author: "Helen Keller"),
  Quote(text: "Love is the master key that opens the gates of happiness.", author: "Oliver Wendell Holmes"),
];
