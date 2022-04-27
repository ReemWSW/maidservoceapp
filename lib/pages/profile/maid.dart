// import 'package:flutter/material.dart';
// import 'package:maid/widget/textfield_custom.dart';

// class MaidSetupPage extends StatelessWidget {
//   const MaidSetupPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ตั้งค่าแม่บ้าน'),
//       ),
//       body: Container(
//         margin: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text(
//               'บริเวณที่ต้องการทำงาน',
//               style: TextStyle(fontSize: 20),
//             ),
//             TextFieldCustom(
//                 hintText: 'ที่อยู่',
//                 icon: Icons.location_on,
//                 controller: _addressController,
//                 validator: addressValidate,
//                 onSaved: (value) => _address = value,
//                 readOnly: true,
//                 onTap: () async {
//                   address = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const AddressPage(),
//                     ),
//                   );
//                   setState(() {
//                     _addressController.text =
//                         "${address![0]}  ${address![1]} ${address![2]} ${address![3]}";
//                   });
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }
