import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelters/services/helpers/compare_dates.dart';
import 'package:shelters/widgets/default_user_avatar.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    required this.title,
    required this.recentMessage,
    required this.dateTime,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String recentMessage;
  final DateTime dateTime;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          height: 85,
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: DefaultUserAvatar(
                  letter: title[0],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            recentMessage,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    if (dateTime.isToday()) ...{
                      Text(
                        DateFormat.Hm().format(dateTime),
                      ),
                    } else ...{
                      Text(
                        DateFormat('dd.MM').format(dateTime),
                      ),
                    },
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
