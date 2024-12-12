class Joke{
  final int id;
  final String setup;
  final String punchline;
  final String type;

  Joke ({required this.id, required this.setup, required this.punchline, required this.type} );
  Joke.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        setup = data['setup'],
        type = data['type'],
        punchline = data['punchline'];

  Map<String, dynamic> toJson() => {'id' : id, 'setup' : setup, 'type' : type, 'punhline':punchline};

}