import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/neighbors_controller.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/presentation/chat_screen.dart';
import 'package:lora_app/presentation/neighbors_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.read(bleServiceProvider).deviceID!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chats'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(neighborsProvider.notifier).getNeighbors();
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => NeighborsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.sizeOf(context).height / 2.5,
            width: double.infinity,
            child: Image.asset('assets/pngs/main screen.png'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: ref
                  .watch(databaseServiceProvider)
                  .getLatestMessages(id),
              builder: (_, snapshot) {
                final messages = snapshot.data ?? [];
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, index)  {
                      final msg = messages[index];
                      final int otherId =
                          msg.sourceId == ref.read(bleServiceProvider).deviceID
                          ? msg.destinationId
                          : msg.sourceId;
                      return ListTile(
                        title: Text(
                          'User $otherId',
                        ), // replace with username if needed
                        subtitle: Text(msg.payload ?? 'no message yet'),
                        trailing: Text(
                          DateTime.fromMillisecondsSinceEpoch(
                            msg.timestamp * 1000,
                          ).toLocal().toString(),
                        ),
                        onTap: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return ChatScreen(id: id);
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Text('No messages');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
