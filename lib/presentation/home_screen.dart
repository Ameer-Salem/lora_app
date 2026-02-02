import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lora_app/logic/neighbors_controller.dart';
import 'package:lora_app/presentation/chat_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neighbors = ref.watch(neighborsProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () =>
                  ref.read(neighborsProvider.notifier).getNeighbors(),
              icon: const Icon(Icons.person_search_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: Container(color: Colors.green)),
            SizedBox(
              height: 500,
              width: double.infinity,
              child: ListView.builder(
                itemCount: neighbors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                      ),
                    ),
                    title: Text('User ${neighbors[index].id}'),
                    subtitle: Text(
                      'Message $index',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '10:00 AM',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ChatScreen(neighbor: neighbors[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
