import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/messaging_controller.dart';
import 'package:lora_app/model/neighbor.dart';
import 'package:lora_app/utilities/colors.dart';
import 'package:lora_app/utilities/constants.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Neighbor neighbor;
  const ChatScreen({super.key, required this.neighbor});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  TextEditingController controller = TextEditingController();

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  child: Image.asset('assets/avatars/Asset 2-8.png'),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User ${widget.neighbor.id}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'online',
                    style: TextStyle(fontSize: 13, color: Colors.green[300]),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.neighbor.rssi < -100)
                    Icon(
                      Icons.signal_cellular_alt_1_bar_rounded,
                      size: 20,
                      color: Colors.red,
                    ),
                  if (widget.neighbor.rssi <= -80)
                    Icon(
                      Icons.signal_cellular_alt_2_bar_rounded,
                      size: 20,
                      color: Colors.yellow,
                    ),
                  if (widget.neighbor.rssi <= -1)
                    Icon(
                      Icons.signal_cellular_alt_rounded,
                      size: 20,
                      color: Colors.green,
                    ),
                  if (widget.neighbor.rssi >= 0)
                    Icon(Icons.route, size: 20, color: Colors.green),
                  Text(
                    widget.neighbor.rssi.toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: messageState.when(
                data: (messages) => messages.isEmpty
                    ? const Center(child: Text('No messages'))
                    : ListView.builder(
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.map_rounded, size: 24),
                  ),
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,

                      controller: controller,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.grey[300],
                        labelText: 'Type here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 08,
                          horizontal: 18,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStatePropertyAll(MyColors.purple),
                    ),
                    onPressed: () {
                      ref
                          .read(messagesProvider.notifier)
                          .sendText(widget.neighbor.id, controller.text);
                      controller.clear();
                    },
                    icon: Icon(Icons.arrow_upward_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
