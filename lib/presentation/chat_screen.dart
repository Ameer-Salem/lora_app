import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lora_app/logic/messaging_controller.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/logic/session_controller.dart';
import 'package:lora_app/model/message_bubble.dart';
import 'package:lora_app/presentation/map_screen.dart';
import 'package:lora_app/presentation/scan_screen.dart';
import 'package:lora_app/utilities/colors.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final int otherId;
  const ChatScreen({super.key, required this.otherId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late final ProviderSubscription connectionSub;
  @override
  void initState() {
    super.initState();
    connectionSub = ref.listenManual(connectionStatusProvider, (prev, next) {
      if (next.status == ConnectionStatus.disconnected) {
        if (!mounted) return;

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => ScanScreen()),
          (route) => false,
        );
      }
    });
    Future.microtask(() async {
      ref.read(messagesProvider.notifier).watchMessages(widget.otherId);
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }
  @override
  void dispose() {
    connectionSub.close();
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider(widget.otherId));

    final messageState = ref.watch(messagesProvider);
    return userAsyncValue.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (user) {
        final lastActive = DateTime.fromMillisecondsSinceEpoch(
          user?.lastSeen ?? 0,
        );
        final timeSinceLastActive = DateTime.now().difference(lastActive);
        int rssi = user?.rssi ?? 0;
        if (timeSinceLastActive.inSeconds >= 30) {
          rssi = 0;
        }
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
                        user?.name ?? 'User ${widget.otherId}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        timeSinceLastActive.inSeconds >= 30
                            ? DateFormat(
                                'MMM d, h:mm a',
                              ).format(lastActive.toLocal())
                            : 'online',
                        style: TextStyle(fontSize: 13),
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
                      if (rssi < -100)
                        Icon(
                          Icons.signal_cellular_alt_1_bar_rounded,
                          size: 20,
                          color: Colors.red,
                        )
                      else if (rssi <= -80)
                        Icon(
                          Icons.signal_cellular_alt_2_bar_rounded,
                          size: 20,
                          color: Colors.yellow,
                        )
                      else if (rssi <= -1)
                        Icon(
                          Icons.signal_cellular_alt_rounded,
                          size: 20,
                          color: Colors.green,
                        )
                      else if (rssi >= 0)
                        Icon(Icons.route, size: 20, color: Colors.grey),
                      if (rssi < 0)
                        Text(rssi.toString(), style: TextStyle(fontSize: 12))
                      else
                        Text('unknown', style: TextStyle(fontSize: 12)),
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
                            controller: _scrollController,
                            itemCount: messages.length,

                            itemBuilder: (context, index) {
                              final msg = messages[index];
                              return MessageBubble(
                                sourceId: msg.message.sourceId,
                                connectedDeviceId: ref
                                    .read(bleServiceProvider)
                                    .deviceID!,
                                timestamp: msg.message.timestamp,
                                text: msg.message.payload ?? '',
                                status: msg.message.status,
                              );
                            },
                          ),
                    error: (e, _) => Center(child: Text('Error: $e')),
                    loading: () => const Center(child: Text('No messages')),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 10,
                  ),
                  width: double.infinity,
                  height: 60,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => MapScreen(),
                            ),
                          );
                        },
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
                          backgroundColor: WidgetStatePropertyAll(
                            MyColors.purple,
                          ),
                        ),
                        onPressed: () {
                          if (controller.text.isEmpty) return;
                          _scrollToBottom();
                          ref
                              .read(messagesProvider.notifier)
                              .sendText(widget.otherId, controller.text);
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
      },
    );
  }
}
