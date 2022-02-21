import 'package:covid/model/data.dart';
import 'package:flutter/material.dart';


class container extends StatelessWidget {
  container(this.provinsi);

  Provinsi provinsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(provinsi.key!,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, top: 10),
            child: Text("Case Detail : ", style: TextStyle(fontSize: 16),),
          ),
          ListTile(
            leading: Icon(Icons.coronavirus_outlined,color: Colors.lightBlueAccent,size: 35,),
            title: Text("All Case",style: TextStyle(fontSize: 16,),),
            subtitle: Text("${provinsi.docCount}",style: TextStyle(fontSize: 16,),),
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline,color: Colors.lightBlueAccent,size: 35,),
            title: Text("Active Case",style: TextStyle(fontSize: 16,),),
            subtitle: Text("${provinsi.status!.buckets!.firstWhere((element) => element.key == StatusKey.DALAM_PERAWATAN, orElse: () => Bucket(key: StatusKey.DALAM_PERAWATAN, docCount: 0)).docCount.toString()} (+${provinsi.penambahan?.positif ?? 0})",
            style: TextStyle(fontSize: 16,),),
          ),
          ListTile(
            leading: Icon(Icons.arrow_circle_up_outlined,color: Colors.lightBlueAccent,size: 35,),
            title: Text("Cured",style: TextStyle(fontSize: 16,),),
            subtitle: Text("${provinsi.status!.buckets!.firstWhere((element) => element.key == StatusKey.SEMBUH, orElse: () => Bucket(key: StatusKey.SEMBUH, docCount: 0)).docCount} (+${provinsi.penambahan?.sembuh ?? 0})",
              style: TextStyle(fontSize: 16,),),
          ),
          ListTile(
            leading: Icon(Icons.coronavirus,color: Colors.lightBlueAccent,size: 35,),
            title: Text("Death",style: TextStyle(fontSize: 16,),),
            subtitle: Text("${provinsi.status!.buckets!.firstWhere((element) => element.key == StatusKey.MENINGGAL, orElse: () => Bucket(key: StatusKey.MENINGGAL, docCount: 0)).docCount} (+${provinsi.penambahan!.meninggal ?? 0})",
              style: TextStyle(fontSize: 16,),),
          ),
        ],
      ),
    );
  }
}
