import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF09031D),
            Color(0xFF1B1E44),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text('Lịch Sử Chơi',
              style: TextStyle(color: Color(0xFFA9DED8), fontSize: 30)),
          iconTheme: IconThemeData(color: Colors.blue),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              //title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('USERNAME',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      )),
                  Text('HIGH SCORE',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      )),
                ],
              ),

              //listtile
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .orderBy('score', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final user = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: user.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 5,
                            color: Colors.black87,
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.blue,
                                size: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(30)),
                              title: Text(
                                user[index]['username'].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                              trailing: Text(user[index]['score'].toString(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              subtitle: Text(
                                DateFormat('kk:mm:ss dd-MM-yyyy  a').format(
                                    DateTime.parse(user[index]['date']
                                        .toDate()
                                        .toString())),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
