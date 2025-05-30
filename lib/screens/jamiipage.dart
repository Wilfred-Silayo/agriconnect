import 'package:flutter/material.dart';
import 'package:agriconnect/screens/create_topic.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JamiiPage extends StatefulWidget {
  const JamiiPage({super.key});

  @override
  State<JamiiPage> createState() => _JamiiPageState();
}

class _JamiiPageState extends State<JamiiPage> {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchJamiiPosts() async {
    final response = await _supabase
        .from('JamiiPosts')
        .select()
        .order('created_at', ascending: false);

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Invalid response from Supabase");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 202, 202),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantsColors().mainColor(),
        title: const Text('Mada na Maswali'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchJamiiPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final data = posts[index];

              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['poster'] ?? 'Anonymous'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['body'] ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 19, 66, 90),
                            ),
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border_outlined,
                                  color: Colors.blueGrey),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.comment_outlined,
                                  color: Colors.blueGrey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstantsColors().mainColor(),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateTopic()));
        },
        child: const Text('Post'),
      ),
    );
  }
}
