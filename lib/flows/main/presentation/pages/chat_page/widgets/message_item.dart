import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    required this.message,
    required this.time,
    required this.sentByUser,
    super.key,
  });

  final String message;
  final String time;
  final bool sentByUser;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const messageTextStyle = TextStyle(
      fontSize: 16,
    );
    final timeTextStyle = TextStyle(
      fontSize: 12,
      color: sentByUser
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).hintColor,
      fontStyle: FontStyle.italic,
    );

    return Align(
      alignment: sentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: 5,
          left: sentByUser ? width * 0.2 : 10,
          right: sentByUser ? 10 : width * 0.2,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:
                sentByUser ? Theme.of(context).primaryColorLight : Colors.white,
          ),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: LayoutBuilder(builder: (context, constraints) {
            final linesAmount = (TextPainter(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: message,
                    style: messageTextStyle,
                  ),
                  TextSpan(
                    text: time,
                    style: timeTextStyle,
                  ),
                ],
              ),
              textScaler: MediaQuery.textScalerOf(context),
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth - 5))
                .computeLineMetrics()
                .length;

            if (linesAmount == 1) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(message, style: messageTextStyle),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    time,
                    style: timeTextStyle,
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  Text(message, style: messageTextStyle),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      time,
                      style: timeTextStyle,
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
