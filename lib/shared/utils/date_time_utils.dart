import 'package:intl/intl.dart';

class DateTimeUtils1 {
  static String getMessageDateTime(int timestamp) {
    print('message timestamp ==> $timestamp');

    DateTime now = DateTime.now();
    var timeFormat = DateFormat('HH:mm a');
    //var dateFormat =  DateFormat.yMd();
    var dateFormat = DateFormat('dd-MM-yyyy');
    DateTime messageDate =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    print('messageDate ==> $messageDate');
    var diff = now.difference(messageDate);
    var messageTime = '';

    print('dayDiff ==> ${diff.inDays}');

    if (diff.inDays == 0) {
      messageTime = timeFormat.format(messageDate);
    } else if (diff.inDays == 1) {
      messageTime = 'Yesterday';
    } else {
      messageTime = dateFormat.format(messageDate);
    }

    return messageTime;

    // if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    //   messageTime = timeFormat.format(date);
    // } else if (diff.inDays > 0 && diff.inDays < 7) {
    //   if (diff.inDays == 1) {
    //     messageTime = '${diff.inDays} DAY AGO';
    //   } else {
    //     messageTime = '${diff.inDays} DAYS AGO';
    //   }
    // } else {
    //   if (diff.inDays == 7) {
    //     messageTime = '${(diff.inDays / 7).floor()} WEEK AGO';
    //   } else {
    //     messageTime = '${(diff.inDays / 7).floor()} WEEKS AGO';
    //   }
    // }
  }
}

class DateTimeUtils {
  static DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  static String getMessageDateTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    } else if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Today';
    } else if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday';
    } else {
      return dateFormat.format(dateTime);
    }
  }

  static String getHeaderDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Today';
    } else if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday';
    } else {
      return dateFormat.format(dateTime);
    }
  }
}
