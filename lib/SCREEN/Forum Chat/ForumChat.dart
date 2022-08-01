import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumChatPage extends StatefulWidget {
  const ForumChatPage({Key? key}) : super(key: key);

  @override
  State<ForumChatPage> createState() => _ForumChatPageState();
}



class _ForumChatPageState extends State<ForumChatPage> {

  TextEditingController _controller = TextEditingController();

  String reply = '';
  String reply_to = '';

  String myID = '';
  String myNama = '';
  String myGender = '';
  String postUserID = '';
  bool moderator = false;
  bool verified = false;
  bool admin = false;

  bool isFetch = false;

  late Stream<QuerySnapshot> messageStream;
  late Stream<DocumentSnapshot> bannerStream;

  bool adminstatus = false;
  bool modstatus = false;
  bool getuser = false;

  _getUserData() async {
    final pref = await SharedPreferences.getInstance();
    final userid = pref.getString('userid');

    FirebaseFirestore.instance.collection('user')
      .doc(userid)
      .get()
      .then((value){
        if (value.exists) {
          var data = value.data() as Map<String, dynamic>;
          setState(() {
            myID = data['userid'];
            myNama = data['username'];
            myGender = data['gender'];
            moderator  = data['moderator'];
            verified = data['verified'];
            admin = data['admin'];
            isFetch = true;
            bannerStream =  FirebaseFirestore.instance.collection('user').doc(myID).snapshots();
          });
        }
      });
  }

  _addMessage(){
    if (_controller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('forumchat')
      .add({
        'system_message' : false,
        'message_id' : '',
        'userid' : myID,
        'username' : myNama,
        'gender' : myGender,
        'admin' : admin,
        'moderator' : moderator,
        'verified' : verified,
        'message' : _controller.text,
        'reply' : reply,
        'reply_to' : reply_to,
        'timestamp' : DateTime.now().millisecondsSinceEpoch
      })
      .then((value){
        value.update({
          'message_id' : value.id
        });
      });
      _controller.clear();
      setState(() {
        reply = '';
        reply_to = '';
      });
    } else {
      Fluttertoast.showToast(msg: 'Tidak dapat menirim pesan kosong');
    }
  }

  _SystemMessage(username){
    FirebaseFirestore.instance.collection('forumchat')
      .add({
        'system_message' : true,
        'message_id' : '',
        'userid' : '311000',
        'username' : 'WAQTU Qur`an Digital Indonesia',
        'gender' : 'L',
        'admin' : false,
        'moderator' : false,
        'verified' : false,
        'message' : '${username} menjadi moderator',
        'reply' : '',
        'reply_to' : '',
        'timestamp' : DateTime.now().millisecondsSinceEpoch
      })
      .then((value){
        value.update({
          'message_id' : value.id
        });
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserData();
    
    messageStream = FirebaseFirestore.instance.collection('forumchat').orderBy('timestamp', descending: true).limit(50).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.transparent,
        title: Text('Forum Terbuka', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
        // actions: [
        //   TextButton(
        //     onPressed: () async {  
        //       final pref = await SharedPreferences.getInstance();
        //       pref.remove('userid');
        //       Navigator.of(context).pop();
        //     }, child: Text('Logout'))
        // ],
      ),
      body: isFetch ? Container(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: bannerStream,
              builder:(context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
                  return SizedBox();
                }
                var data = snapshot.data!.data() as Map<String, dynamic>;
                adminstatus = data['admin'];
                modstatus = data['moderator'];
                admin = data['admin'];
                moderator = data['moderator'];
                myGender = data['gender'];
                verified = data['verified'];
                if (data['admin'] == true || data['moderator'] == true) {
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 15,
                    decoration: BoxDecoration(
                      color: data['admin'] ? Colors.lightBlue[300] : Color.fromARGB(234, 182, 142, 219)
                    ),
                    child: Column(
                      children: [
                        if(data['admin'] == true)
                          Text('kamu adalah admin', style: TextStyle(fontSize: 9, color: Colors.white),)
                        else if (data['moderator'] == true)
                          Text('kamu adalah moderator', style: TextStyle(fontSize: 9, color: Colors.white),)
                        else 
                          SizedBox()
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
              
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: messageStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    }
                    return ListView(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data!.docs.map((DocumentSnapshot document){
                        var data = document.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: (){
                            FocusManager.instance.primaryFocus!.unfocus();
                            if(data['userid'] == myID && data['system_message'] != true){
                              showModalBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context){
                                return Wrap(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                      ),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: (){
                                            print(data['message_id']);
                                            if (data['message_id'] != null) {
                                              FirebaseFirestore.instance.collection('forumchat')
                                              .doc(data['message_id'])
                                              .update({
                                                'message' : '⨂ Pesan ditarik'
                                              });

                                              Navigator.of(context).pop();
                                              Fluttertoast.showToast(msg: 'pesan berhasil dihapus');
                                            }else{
                                              Navigator.of(context).pop();
                                              Fluttertoast.showToast(msg: 'gagal menghapus pesan!');
                                            }
                                          },
                                          child: Text('Tarik Pesan'),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                            }else{
                              showModalBottomSheet(context: context, backgroundColor: Colors.transparent,builder: (context){
                                return Wrap(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                          color: Colors.white
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: (){
                                                setState(() {
                                                  reply = data['message'];
                                                  reply_to = data['username'];
                                                });
                                                Navigator.of(context).pop();
                                              }, child: Text('Balas')),

                                            if(adminstatus == true && data['system_message'] == false)
                                            data['userid'] != myID ? 
                                              Container(
                                                color: Colors.white,
                                                child: Center(
                                                  child: TextButton(
                                                    onPressed: (){
                                                      FirebaseFirestore.instance.collection('user')
                                                        .doc(data['userid'])
                                                        .get()
                                                        .then((value){
                                                          var user = value.data() as Map<String, dynamic>;
                                                          if (user['moderator'] != true) {
                                                            Navigator.of(context).pop();
                                                            FirebaseFirestore.instance.collection('user')
                                                              .doc(data['userid'])
                                                              .update({
                                                                'moderator' : true
                                                              }).then((value){
                                                                _SystemMessage(data['username']);
                                                              });
                                                          } else {
                                                            Navigator.of(context).pop();
                                                            FirebaseFirestore.instance.collection('user')
                                                              .doc(data['userid'])
                                                              .update({
                                                                'moderator' : false
                                                              }).then((value){
                                                                Fluttertoast.showToast(msg: 'menghapus ${data['username']} sebagai moderator', backgroundColor: Colors.red);
                                                              });
                                                          }
                                                        });
                                                    },
                                                    child: StreamBuilder<DocumentSnapshot>(
                                                      stream: FirebaseFirestore.instance.collection('user').doc(data['userid']).snapshots(),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return SizedBox();
                                                        }
                                                        var mod = snapshot.data!.data() as Map<String, dynamic>;
                                                        return Column(
                                                          children: [
                                                            if(mod['moderator'] == true)
                                                              Text('Hapus Moderator')
                                                            else 
                                                              Text('Jadikan Moderator')
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  ),
                                                ),
                                              ) : SizedBox()
                                            else 
                                              SizedBox(),

                                            if(modstatus == true || adminstatus == true && data['system_message'] != true)
                                              TextButton(
                                                  onPressed: (){
                                                    if (data['message_id'] != null) {
                                                      FirebaseFirestore.instance.collection('forumchat')
                                                      .doc(data['message_id'])
                                                      .update({
                                                        'message' : 'pesan ini telah dihapus pihak waqtu karena menyalahi peraturan!'
                                                      });

                                                      Navigator.of(context).pop();
                                                      Fluttertoast.showToast(msg: 'pesan berhasil dihapus');
                                                    }else{
                                                      Navigator.of(context).pop();
                                                      Fluttertoast.showToast(msg: 'gagal menghapus pesan!');
                                                    }
                                                  },
                                                  child: Text('Beri Peringatan!')
                                              )
                                            else 
                                              SizedBox(),

                                            if(modstatus == true || adminstatus == true && data['system_message'] != true)
                                              TextButton(
                                                  onPressed: (){
                                                    if (data['message_id'] != null) {
                                                      FirebaseFirestore.instance.collection('forumchat')
                                                      .doc(data['message_id'])
                                                      .delete();

                                                      Navigator.of(context).pop();
                                                      Fluttertoast.showToast(msg: 'pesan berhasil dihapus');
                                                    }else{
                                                      Navigator.of(context).pop();
                                                      Fluttertoast.showToast(msg: 'gagal menghapus pesan!');
                                                    }
                                                  },
                                                  child: Text('Hapus Pesan')
                                              )
                                            else 
                                              SizedBox()
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                            }
                          },
                          child: Column(
                            crossAxisAlignment: data['userid'] == myID ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              if(data['reply'] != '')
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: data['userid'] != myID ? MainAxisAlignment.start : MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 150,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        // color: Colors.black.withOpacity(0.05 ),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Balas: ${data['reply_to']}', style: TextStyle(color: Colors.purple[200], fontSize: 11),),
                                          Text(data['reply'], style: TextStyle(color: Colors.grey, fontSize: 10), overflow: TextOverflow.ellipsis,)
                                        ],
                                      ),
                                    ),
                                    if(data['userid'] == myID)
                                      Text('↷', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),)
                                    else 
                                      Text('↷', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),)
                                  ],
                                )
                              else 
                                SizedBox(),
                              if(data['system_message'] == true)
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Text(data['message'], style: TextStyle(fontSize: 11, color: Colors.lightBlue[300]),)
                                )
                              else 
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: data['userid'] == myID ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
                                  child: Wrap(
                                    alignment: data['userid'] == myID ? WrapAlignment.end : WrapAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: data['userid'] == myID ? Colors.lightBlue[50] : Colors.grey[200]
                                        ),
                                        child: Column(
                                          crossAxisAlignment: data['userid'] == myID ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(data['username'], style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54),),
                                                SizedBox(width: 5,),
                                                if(data['admin'] == true)
                                                  Container(
                                                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 2, top: 1),
                                                    decoration: BoxDecoration(
                                                      color: Colors.lightBlue[300],
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Text('admin', style: TextStyle(fontSize: 8, color: Colors.white),),
                                                  )
                                                else if(data['moderator'] == true)
                                                  Container(
                                                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 2, top: 1),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 182, 142, 219),
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Text('mod', style: TextStyle(fontSize: 8, color: Colors.white),),
                                                  )
                                                else if(data['verified'] == true)
                                                  Image(image: AssetImage('assets/icons/verified_icon.png'), height: 16,)
                                                else if(data['gender'] == 'L')
                                                  Container(
                                                    padding: EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.lightBlue[300],
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Icon(Icons.male, size: 10, color: Colors.lightBlue[50],),
                                                  )
                                                else if(data['gender'] == 'P')
                                                  Container(
                                                    padding: EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.pink[200],
                                                      borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Icon(Icons.female, size: 10, color: Colors.pink[50],),
                                                  )
                                                else 
                                                  SizedBox()
                                              ],
                                            ),
                                            Linkify(
                                              onOpen: (link){
                                                launchUrl(Uri.parse(link.toString()));
                                              },
                                              text: data['message'],
                                              style: TextStyle(fontSize: 13, color: Colors.black54),
                                              linkStyle: TextStyle(fontSize: 13, color: Colors.lightBlue),
                                            ),
                                            SizedBox(height: 5,),
                                            if(DateTime.fromMillisecondsSinceEpoch(data['timestamp']).day == DateTime.now().day)
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Hari ini, ', style: TextStyle(fontSize: 11, color: Colors.grey),),
                                                  Text(DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(data['timestamp'])), style: TextStyle(fontSize: 11, color: Colors.grey),)
                                                ],
                                              )
                                            else
                                              Text(DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.fromMillisecondsSinceEpoch(data['timestamp'])), style: TextStyle(fontSize: 11, color: Colors.grey),)
                                          ],
                                        ),
                                      ),
                                    ]
                                  ),
                                ),
                            ],
                          )
                        );
                      })
                      .toList()
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ) : SizedBox(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(reply != '')
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, bottom: 7, right: 10),
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Membalas: ${reply_to}', style: TextStyle(color: Colors.purple[200], fontSize: 12),),
                      Container(
                        width: MediaQuery.of(context).size.width/1.3,
                        child: Text(reply, style: TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis,)
                      )
                    ],
                  ),
                  IconButton(onPressed: (){
                    setState(() {
                      reply = '';
                      reply_to = '';
                    });
                  }, icon: Icon(Icons.close, size: 20,))
                ],
              )
            )
            else 
             SizedBox(),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: TextField(
                controller: _controller,
                maxLength: 1000,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Tulis pesan',
                  border: InputBorder.none,
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: (){
                      _addMessage();
                    },
                    icon: FaIcon(FontAwesomeIcons.paperPlane),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}