import 'package:flutter/material.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/services/theme.dart';

class ProfileInfo extends StatelessWidget {
  final Profile data;
  const ProfileInfo({required this.data});

  int yearsBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays / 365).round();
  }

  Widget _field(String label, IconData icon, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, color: ThemeService.secondaryText, size: 15),
        const SizedBox(width: 10),
        Text(label,
            style: TextStyle(fontSize: 12, color: ThemeService.secondaryText)),
        const SizedBox(width: 10),
        Text(value, style: TextStyle(fontSize: 16))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //_levelIndicator(),
          // ProfileStatus(
          //     connections: data.connections, posts: data.posts, id: data.id),

          Row(
            children: [
              Expanded(
                  child: Text("${data.firstName} ${data.lastName}",
                      style: TextStyle(
                        color: ThemeService.primaryText,
                        fontSize: 20,
                      ))),
              if (data.verified) ...const [
                SizedBox(width: 10),
                Icon(Icons.verified)
              ]
            ],
          ),
          Text("@${data.username}",
              style:
                  TextStyle(fontSize: 16, color: ThemeService.secondaryText)),
          const SizedBox(height: 10),
          UserStats(context: context, data: data),

          if (data.birth != null)
            _field("Yaş", Icons.person,
                yearsBetween(data.birth!, DateTime.now()).toString()),
          if (data.educationData != null)
            _field("Eğitim", Icons.school, data.educationData!.schoolName)
        ],
      ),
    );
  }
}
