import 'dart:convert';
import 'package:covid/model/data.dart';
import 'package:covid/widget/container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Data data = Data();
  Future getData() async {var response = await http.get(Uri.parse("https://data.covid19.go.id/public/api/prov_list.json"));
    data = Data.fromJson(jsonDecode(response.body));
    if (data.listData != null) {
      data.listData!.sort((a, b) => a.key!.compareTo(b.key!));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INFO COVID INDONESIA"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getData();
                });
              }, icon: Icon(Icons.refresh))
        ],
      ),
      body: 
      SingleChildScrollView(
          child: Container(
        decoration : BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
              Color.fromARGB(255, 39, 148, 199),
              Color.fromARGB(255, 113, 201, 241),
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, s) =>
                  s.connectionState == ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.all(8),
                              child: Text("Last Updated : ${data.lastDate != null ? DateFormat('EEEEEE, d MMM y').format(data.lastDate!) : ''}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: data.listData?.length ?? 0,
                                itemBuilder: (context, index) {
                                Provinsi provinsi = data.listData![index];
                                return container(provinsi);
                                }),
                          ],
                        ),
            ),
          ],
        ),
      )),
    );
  }
}

