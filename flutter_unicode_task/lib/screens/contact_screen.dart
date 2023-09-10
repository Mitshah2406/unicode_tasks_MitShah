import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({required this.contact, super.key});
  final Contact contact;
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: widget.contact.avatar != null
                ? MemoryImage(widget.contact.avatar!)
                : const AssetImage('images/placeholder.png') as ImageProvider,
          ),
          Text(widget.contact.displayName ?? ''),
          if (widget.contact.phones != null &&
              widget.contact.phones!.isNotEmpty)
            Text('Phone: ${widget.contact.phones!.first.value}'),
        ],
      )),
    );
  }
}
