import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final int sourceId;
  final int timestamp;
  final int connectedDeviceId;
  final String text;
  final String status;

  const MessageBubble({
    super.key,
    required this.sourceId,
    required this.connectedDeviceId,
    required this.timestamp,
    required this.text,
    required this.status,
  });
  Widget buildStatus(String status) {
    switch (status) {
      case 'pending':
        return const Icon(
          Icons.access_time_rounded,
          color: Colors.grey,
          size: 14,
        );
      case 'delivered':
        return const Icon(Icons.check, color: Colors.green, size: 17);
    }
    return Text('Unknown status: $status');
  }

  @override
  Widget build(BuildContext context) {
    final isMe = sourceId == connectedDeviceId ? true : false;
    final bgColor = isMe
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.inverseSurface;
    final crossAlign = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final mainAlign = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    final time = DateFormat(
      "hh:mm a",
    ).format(DateTime.fromMillisecondsSinceEpoch(timestamp)).toString();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: crossAlign,
        children: [
          Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.sizeOf(context).width * 0.2,
              maxWidth: MediaQuery.sizeOf(context).width * 0.75,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white
              ),
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: mainAlign,
            children: [
              if (isMe) buildStatus(status),
              SizedBox(width: 4),
              Text(
                time,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
