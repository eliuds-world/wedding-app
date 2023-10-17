import 'package:flutter/material.dart';
import 'package:mywedding/guest_book_message.dart';

class GuestBook extends StatefulWidget {
  const GuestBook({required this.addMessage,required this.messages, super.key});

  final Future<void> Function(String message)  addMessage;
  final List<GuestBookMessageToUi>  messages;

  @override
  State<GuestBook> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GuestBook> {
  final formKey = GlobalKey<FormState>(debugLabel: "_GuestBookState");
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(hintText: "write message"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your message to continue";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await widget.addMessage(controller.text);
                      controller.clear();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.send), 
                      SizedBox(width: 4),
                      Text("SEND"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 8,
        ),

        for (var message in widget.messages)
          Text("${message.name} : ${message.message}"),
        SizedBox(
          height: 8,
        )
          
        
      ],
    );
  }
}
