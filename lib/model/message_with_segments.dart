import 'package:lora_app/service/database_service.dart';

class MessageWithSegments {
  final Message message;
  final List<Segment> segments;
  MessageWithSegments(this.message, this.segments);
}