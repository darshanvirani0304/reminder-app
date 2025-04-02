class Reminder {
  final int? id;
  final String title;
  final String desc;
  final DateTime reminderDateTime;
  final bool status;

  Reminder({
    this.id,
    required this.title,
    required this.desc,
    required this.reminderDateTime,
    required this.status,
  });

  factory Reminder.formMap(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      reminderDateTime: DateTime.parse(json['reminder_date_time']),
      status: json['status'] == 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'reminder_date_time': reminderDateTime.toIso8601String(),
      'status': status ? 0 : 1,
    };
  }
}
