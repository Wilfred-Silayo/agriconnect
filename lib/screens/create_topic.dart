import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/services/gerneralservices.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class CreateTopic extends StatefulWidget {
  const CreateTopic({super.key});

  @override
  State<CreateTopic> createState() => _CreateTopicState();
}

class _CreateTopicState extends State<CreateTopic> {
  final TextEditingController _messageBody = TextEditingController();
  bool _isLoading = false;

  final user = Supabase.instance.client.auth.currentUser;

  void _clearInput() {
    _messageBody.clear();
  }

  Future<void> _handlePost() async {
    final message = _messageBody.text.trim();
    final email = user?.email;

    if (message.isEmpty || email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tafadhali andika ujumbe kwanza.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await Supabase.instance.client
          .from('Jamii') // replace with your actual table name
          .insert({
            'body': message,
            'user_email': email,
            'created_at': DateTime.now().toIso8601String(),
          });

      _clearInput();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ujumbe umetumwa!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tatizo limetokea: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantsColors().mainColor(),
        elevation: 0,
        title: const Text('Chapisha Ujumbe'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jamii Post',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _handlePost,
                        child: const Text('Tuma'),
                      ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _messageBody,
              maxLines: 20,
              decoration: const InputDecoration.collapsed(
                hintText: 'Andika hapa',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
