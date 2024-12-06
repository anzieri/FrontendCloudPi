import 'package:flutter/material.dart';

class ThreeDotsMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuItems;
  final Color? iconColor;

  const ThreeDotsMenu({
    Key? key,
    required this.menuItems,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      icon: Icon(
        Icons.more_vert,
        color: iconColor ?? Theme.of(context).iconTheme.color,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      itemBuilder: (context) => menuItems,
      position: PopupMenuPosition.under,
    );
  }
}

// Example usage:
// ThreeDotsMenu(
//   menuItems: [
//     PopupMenuItem(
//       child: Text('Edit'),
//       value: 'edit',
//       onTap: () {
//         // Handle edit action
//       },
//     ),
//     PopupMenuItem(
//       child: Text('Delete'),
//       value: 'delete',
//       onTap: () {
//         // Handle delete action
//       },
//     ),
//   ],
// )

void main() {
  runApp(MaterialApp(
      home: Scaffold(
          body: Center(
              child: ThreeDotsMenu(
                iconColor: Colors.amber,
    menuItems: [
      PopupMenuItem(
        child: Text('Edit',
        style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: 'Lexend',
      ),),
        value: 'edit',
        onTap: () {
          // Handle edit action
        },
      ),
      PopupMenuItem(
        child: Text('Delete',
        style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: 'Lexend',
      ),),
        value: 'delete',
        onTap: () {
          // Handle delete action
        },
      ),
    ],
  )))));
}
