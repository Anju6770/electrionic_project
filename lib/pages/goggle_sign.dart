// import 'package:firebase_auth/firebase_auth.dart';
//
// User? user = FirebaseAuth.instance.currentUser;
//
// if (user != null) async {
// String? name = user.displayName; // Name (Google sign-in)
// String? email = user.email;      // Email (Google or email sign-in)
//
// // Display these values in your profile page
// print('Name: $name');
// print('Email: $email');
// }
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Row(
// children: [
// Text(
// '${userData[0].firstName}',
// style: mystyle(25,Colors.black,FontWeight.bold),
// ),
// Gap(10),
// Text(
// '${userData[0].lastName}',
// style: mystyle(25,Colors.black,FontWeight.bold),
// ),
// ],
// ),
// ],
// ),
// Gap(10),
// Divider(),
// Gap(10),
// Row(
// children: [
// Icon(Icons.email_outlined,color: Colors.grey,),
// Gap(10),
// Text('${userData[0].email}', style: TextStyle(fontSize: 20,color:  Colors.black,fontWeight:  FontWeight.bold),),
// ],
// ),
// Gap(10),
//
// Gap(10),
// Row(
// children: [
// Icon(Icons.location_city_outlined,color: Colors.grey,),
// Gap(10),
// Text('${userData[0].location}', style: TextStyle(fontSize: 20,color:  Colors.black,fontWeight:  FontWeight.bold),),
// ],
// ),