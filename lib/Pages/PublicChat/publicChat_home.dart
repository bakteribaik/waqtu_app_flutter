import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:waqtuu/Service/google_sign_in.dart';

class PublicChatHome extends StatefulWidget {
  final bool isDarkMode;
  const PublicChatHome({
    required this.isDarkMode,
    Key? key
    }) : super(key: key);

  @override
  _PublicChatHomeState createState() => _PublicChatHomeState();
}

class _PublicChatHomeState extends State<PublicChatHome> {

  List<String> badword = [
    'anjing','babi','monyet'
  ];

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  final user = FirebaseAuth.instance.currentUser;
  String docID = '';
  
  
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  CollectionReference message = FirebaseFirestore.instance.collection('message');
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance.collection('message').orderBy('timestamp', descending: true).limit(30).snapshots();

  DateTime date = DateTime.now().toLocal();

  String query = '';

  bool isbadWord = false;

  AudioCache player = AudioCache();

  bool isAdmin = false;
  String adminName = '';

  _checkAdmin(){
    if (user!.email == 'zlubiz8@gmail.com') {
      setState(() {
        isAdmin = true;
        adminName = 'Admin WAQTU';
      });
    }else{
      return;
    }
  }

   addMessage() {
      if (controller.text.contains('anjing') || controller.text.contains('babi') || controller.text.contains('monyet')) {
        return  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[300],
                        content: Text('🚫 Pesan anda berisi kata yang dilarang!', textAlign: TextAlign.center,)
                      )
                    );
      } else {
        return message
          .add({
            'docID' : '',
            // 'userID' : user!.uid,
            'name': 'Sobat Waqtu',
            'message': controller.text,
            // 'avatar': user!.photoURL,
            'date' : DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.now()),
            'timestamp' : DateTime.now().millisecondsSinceEpoch
          })
          .then((value){
            message
              .doc(value.id)
              .update({
                'docID' : value.id
              });
            setState(() {
              docID = value.id;
            });
          })
          .catchError((error) => print("Failed to add message: $error"));
      }
  }

  Future<void> _deleteAdmin(id){
      return message
        .where('docID', isEqualTo: id)
        .get()
        .then((value){
          value.docs.forEach((element) {
             message.doc(element.id).delete().then((value) => print('Delete Success'));
          });
        });
  }

  Future<void> _deleteMember(uid, docid){
    return message
      .where('userID', isEqualTo: uid)
      .get()
      .then((value){
        value.docs.forEach((element) {
          if (element.id == docid) {
            message.doc(docid).delete();
          }
        });
      });
  }

  @override
  void initState() {
    // _checkAdmin();
    super.initState();
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? BColor: Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: widget.isDarkMode ? DColor : Colors.teal,
        title: Row(children: [Text('Beri Masukan Kepada Kami', style: TextStyle(fontSize: 14),)],),
        // actions: [
        //   IconButton(onPressed: (){
        //     final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
        //     provider.logout(context);
        //   }, icon: Icon(Icons.logout_rounded))
        // ],
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height * 0.83,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom*0.02),
          child: Container(
            height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
            stream: _messageStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
                if (snapshot.hasError) {
                   return Center(
                    child: CircularProgressIndicator(color: Colors.teal,),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.teal,),
                  );
                }

                return ListView(
                  reverse: true,
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 10),
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Container(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: widget.isDarkMode ? DColor : Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                        child: ListTile(
                          // onTap: () {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       backgroundColor: Colors.teal,
                          //       elevation: 1,
                          //       duration: Duration(seconds: 3),
                          //       content: Text('Hapus Pesan?'),
                          //       action: SnackBarAction(
                          //         label: 'Hapus',
                          //         textColor: Colors.white,
                          //         onPressed: (){
                          //           isAdmin ? _deleteAdmin(document.id) : _deleteMember(user!.uid, document.id);
                          //         },
                          //       ),
                          //     )
                          //   );
                          // },
                          // leading: CircleAvatar(
                          //   backgroundColor: Colors.red,
                          //   backgroundImage: NetworkImage(data['avatar'] ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
                          // ),
                          title: Text(data['name'], style: TextStyle(fontSize: 14, color: widget.isDarkMode ? Colors.white : Colors.teal, fontWeight: FontWeight.bold),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                              Container(
                                child: Text(data['message'], style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87), textAlign: TextAlign.justify,),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(data['date'], style: TextStyle(fontSize: 10, color: widget.isDarkMode ? Colors.white : Colors.grey),),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     isAdmin ? Text('Doc ID: ${data['docID']}', style: TextStyle(fontSize: 10),textAlign: TextAlign.end,) : SizedBox(),
                              //   ],
                              // )
                            ],
                          ),
                    ));
                  }).toList(),
                );
            },
          )
        ),
        )
      ),

      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:  TextField(
              onChanged: (q){
                setState(() {
                  query = q;
                });
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Tuliskan Pesan',
                suffixIcon: IconButton(icon: FaIcon(FontAwesomeIcons.solidPaperPlane, color: Colors.teal,), onPressed: (){
                  if (query.isEmpty) {
                    print('empty');
                  } else {
                    addMessage();
                    controller.clear();
                    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                  }
                },)
              ),
            ),
          )
        )
      ),
    );
  }
}