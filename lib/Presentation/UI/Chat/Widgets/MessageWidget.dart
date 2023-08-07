import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/Models/Message/Message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  String uid;
  MessageWidget({required this.message, required this.uid, super.key});

  @override
  Widget build(BuildContext context) {
    bool sender = message.senderId == uid;
    DateTime messageTime = DateTime.fromMillisecondsSinceEpoch(message.time);
    return Row(
      mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          constraints: BoxConstraints(
            maxWidth:  MediaQuery.of(context).size.width * 0.75
          ),
          decoration: BoxDecoration(
              color: sender ? MyTheme.blue : MyTheme.gray.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
                topRight: sender ? Radius.zero : const Radius.circular(15),
                topLeft: sender ? const Radius.circular(15) : Radius.zero,
              )),
          child: Column(
            mainAxisAlignment: sender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // the sender name in the top of the message
              !sender?Text(
                message.senderName,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: sender ? MyTheme.white : MyTheme.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ):Container(width: 0,),
              // the message
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  message.message,
                  textAlign: sender? TextAlign.end : TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                      color: sender ? MyTheme.white : MyTheme.black),
                ),
              ),
              Text(
                "${messageTime.hour}:${messageTime.minute}",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 16,
                    color: sender ? MyTheme.white : MyTheme.blue),
              ),
            ],
          ),
        )
      ],
    );
  }
}