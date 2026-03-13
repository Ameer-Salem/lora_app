import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/providers.dart';
import 'package:lora_app/presentation/chat_screen.dart';
import 'package:lora_app/presentation/neighbors_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  String formatTimestamp(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inHours < 24) {
      // hh:mm
      final h = time.hour.toString().padLeft(2, '0');
      final m = time.minute.toString().padLeft(2, '0');
      return '$h:$m';
    } else {
      // MonthName dd
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      final monthName = months[time.month - 1];
      final day = time.day.toString().padLeft(2, '0');
      return '$monthName $day';
    }
  }

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
              stream: ref.watch(databaseServiceProvider).watchUsersWithLatestMessage(id),
              builder: (_, snapshot) {
                final usersWithmessages = snapshot.data ?? [];
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: usersWithmessages.length,
                    itemBuilder: (_, index) {
                      final item = usersWithmessages[index];
                      final msg = item.lastMessage;
                      final user = item.user;
                      return ListTile(
                        title: Text(
                          user.name ?? 'User ${user.address}',
                        ), // replace with username if needed
                        subtitle: Text(
                          msg.payload ?? 'no message yet',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        trailing: Text(
                          formatTimestamp(
                            DateTime.fromMillisecondsSinceEpoch(msg.timestamp),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return ChatScreen(otherId: user.address,);
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
