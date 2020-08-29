// import 'package:flutter/material.dart';
// import 'package:baba_spira/consts/color.dart';

// class AccountSetting extends StatefulWidget {
//   @override
//   _AccountSettingState createState() => _AccountSettingState();
// }

// class _AccountSettingState extends State<AccountSetting> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: pink,
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Row(
//               children: <Widget>[
//                 ProfileButton(
//                   Icons.person,
//                   "EDIT ACCOUNT",
//                   Color(0xFF808f9c),
//                   () {
//                     // Navigator.pushNamed(context, "/editaccount");
//                   },
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: Row(
//               children: <Widget>[
//                 ProfileButton(
//                   Icons.person_add,
//                   "Name".toUpperCase(),
//                   Color(0xFF7c7d99),
//                   () {
//                     // Navigator.pushNamed(context, "/password");
//                   },
//                 ),
//                 ProfileButton(
//                   Icons.person_outline,
//                   "User Name".toUpperCase(),
//                   Color(0xFF535599),
//                   () {
//                     //  Navigator.pushNamed(context, "/address");
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Row(
//               children: <Widget>[
//                 ProfileButton(
//                   Icons.lock,
//                   "Password".toUpperCase(),
//                   Color(0xFF373a78),
//                   () {
//                     // Navigator.pushNamed(context, "/order");
//                   },
//                 ),
//                 ProfileButton(
//                   Icons.email,
//                   "Email".toUpperCase(),
//                   Color(0xFF844c8c),
//                   () {
//                     // Navigator.pushNamed(context, "/cart");
//                   },
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: Row(
//               children: <Widget>[
//                 ProfileButton(
//                   Icons.security,
//                   "Security Number",
//                   Color(0xFF804c3b),
//                   () {
//                     //  Navigator.pushNamed(context, "/newsletter");
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ProfileButton extends StatelessWidget {
//   final IconData icn;
//   final String name;
//   final Color clr;
//   final Function onPress;
//   ProfileButton(this.icn, this.name, this.clr, this.onPress);
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: RaisedButton(
//           color: clr,
//           onPressed: onPress,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Icon(
//                 icn,
//                 color: Colors.white,
//                 size: 40,
//               ),
//               Text(
//                 name,
//                 style: TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
