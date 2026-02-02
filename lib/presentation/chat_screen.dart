import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/messaging_controller.dart';
import 'package:lora_app/model/neighbor.dart';
import 'package:lora_app/utilities/constants.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Neighbor neighbor;
  const ChatScreen({super.key, required this.neighbor});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(messagesProvider.notifier).watchMessages(widget.neighbor.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messagesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text('User ${widget.neighbor.id}'),
        actions: [
          Column(
            children: [
              if (widget.neighbor.rssi < -100)
                Icon(Icons.signal_cellular_alt_1_bar_rounded),
              if (widget.neighbor.rssi <= -80)
                Icon(Icons.signal_cellular_alt_2_bar_rounded),
              if (widget.neighbor.rssi <= -1)
                Icon(Icons.signal_cellular_alt_rounded),
              if (widget.neighbor.rssi >= 0)
                Icon(Icons.signal_cellular_connected_no_internet_0_bar_rounded),
              Text(widget.neighbor.rssi.toString()),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messageState.when(
              data: (messages) => messages.isEmpty ? const Center(child: Text('No messages')) : ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return msg.message.type == Constants.textTYPE
                      ? Text('${msg.message.payload}')
                      : Text('');
                },
              ),
              error: (e, _) => Center(child: Text('Error: $e')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
