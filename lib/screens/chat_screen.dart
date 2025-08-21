import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool fromMe;
  ChatMessage(this.text, this.fromMe);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgs = <ChatMessage>[
    ChatMessage('Hi! How can I help?', false),
    ChatMessage('I need details about a product.', true),
  ];
  final controller = TextEditingController();

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  void _send() {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      msgs.add(ChatMessage(text, true));
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: msgs.length,
              itemBuilder: (_, i) {
                final m = msgs[i];
                final align = m.fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                final bg = m.fromMe ? Colors.blue.shade100 : Colors.grey.shade200;
                return Column(
                  crossAxisAlignment: align,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: bg, borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(m.text),
                    ),
                  ],
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Type a message'),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _send, child: const Icon(Icons.send)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
