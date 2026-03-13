import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/neighbors_controller.dart';
import 'package:lora_app/presentation/chat_screen.dart';

class NeighborsScreen extends ConsumerWidget {
  const NeighborsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neighbors = ref.watch(neighborsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Neighbors')),
      body: neighbors.isEmpty
          ? const Center(child: Text('No contacts found'))
          : ListView.builder(
              itemCount: neighbors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      child: Image.asset('assets/avatars/Asset 2-8.png'),
                    ),
                  ),
                  title: Text('User ${neighbors[index].id}'),
                  subtitle: Text(
                    'Message $index',
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: SizedBox(
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '10:00 AM',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 5,
                          children: [
                            Text(
                              neighbors[index].rssi.toString(),
                              style: TextStyle(fontSize: 13),
                            ),
                            if (neighbors[index].rssi < -100)
                              Icon(
                                Icons.signal_cellular_alt_1_bar_rounded,
                                color: Colors.red,
                              )
                            else if (neighbors[index].rssi <= -80)
                              Icon(
                                Icons.signal_cellular_alt_2_bar_rounded,
                                color: Colors.yellow,
                              )
                            else if (neighbors[index].rssi <= -1)
                              Icon(
                                Icons.signal_cellular_alt_rounded,
                                color: Colors.green,
                              )
                            else if (neighbors[index].rssi >= 0)
                              Icon(Icons.route, color: Colors.green),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            ChatScreen(otherId: neighbors[index].id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
