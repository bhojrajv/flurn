import 'package:flurn/Model/modelData.dart';
import 'package:flurn/paggination.dart';
import 'package:flurn/viewpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:loadmore/loadmore.dart';
import 'package:path_provider/path_provider.dart';

import 'ApiService/webservice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),routes: {
        "home":(context)=>MyHomePage(),
         "viewpage":(context)=>WebViewExample(),
           "page":(context)=>MyHomePage2()
    },
      initialRoute: "home",
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Box box;
  int get count => filteritems.length;
  AnimationController controller;
  List<Items>dataItems=[];
  Apiservieces apiservieces;
  List<Items>filteritems=[];
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
   apiservieces=new Apiservieces();
    getdata();
    super.initState();


  }

  void load() {
    print("load");
    setState(() {
        filteritems.addAll(List.generate(dataItems.getRange(0, 9).length, (index) => dataItems[index]));
      print("data count = ${filteritems.length}");
    });
  }

  /// the list of positive integers starting from 0
  void getdata(){
    apiservieces.getitems().then((value){
      if(value!=null){
        setState(() {
          dataItems=value;
          //openbox(value);
          load();
       //filteritems=dataItems;
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title:  Container(
          height: 40,
          margin: const EdgeInsets.only(left: 0,right: 0,top: 5,bottom: 10),
          child: TextFormField(
            onChanged: (searchtx){
              setState(() {
                filteritems=dataItems.where((element){
                  return element.title.toLowerCase().contains(searchtx.toLowerCase());
                }).toList();
              });
            },
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 15),
                hintText: "Enter your search query here",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey,width: 1)
                ),
                enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey,width: 1)
                ),focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey,width: 1)
            )
            ),
          ),
        )
      ),
      body:
         dataItems.length==null?
          Center(
            child:CircularProgressIndicator(backgroundColor: Colors.blue,
            valueColor: AlwaysStoppedAnimation(Colors.green),)
          ):
            datatitle(),


      );
  }
  Widget datatitle(){
    return RefreshIndicator(
      child: LoadMore(
        isFinish: count>=dataItems.length,
        onLoadMore: _loadMore,
        delegate: DefaultLoadMoreDelegate(),
        textBuilder: DefaultLoadMoreTextBuilder.english,
        whenEmptyLoad: false,
        child: ListView.separated(itemBuilder: (context,index){
        return  GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, "viewpage",arguments: filteritems[index].link);
          },
          child: Container(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 8),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${filteritems[index].score}",style: TextStyle(color: Colors.grey,fontSize: 15),),
                            Padding(child: Image.asset("images/trinagel.png",width: 30,height: 30,),
                              padding: const EdgeInsets.only(left: 10),)
                          ],)
                        ,SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Text("${filteritems[index].viewCount}",style: TextStyle(color: Colors.grey,fontSize: 15),),
                          Padding(child: Icon(Icons.message,size: 30,),
                            padding: const EdgeInsets.only(left: 10),)
                        ],)
                      ],),
                      Expanded(
                        child: Padding(padding: const EdgeInsets.only(top: 5,left: 25,right: 5),
                          child: Text("${filteritems[index].title}",style: TextStyle(
                              color: Colors.blue[600],fontSize: 18,fontWeight: FontWeight.bold
                          ),),),
                      )
                    ],
                  ),
                  SizedBox(height: 0,),
                  tags(index),
                  SizedBox(height: 5,),
                  Container(
                    margin: const EdgeInsets.only(left: 65),
                    child: Row(
                      children: [
                        Text("${filteritems[index].creationDate}",style: TextStyle(color: Colors.grey),),
                        SizedBox(width: 10,),
                        Expanded(child: Text("${filteritems[index].owner.displayName}",style: TextStyle(color: Colors.grey)))
                      ],),
                  )
                ],
              ) ,
            ),
        );
        }, separatorBuilder: (context,index){
          return Divider(height: 1,thickness: 1,color: Colors.grey,);
        }, itemCount:count,shrinkWrap: true,),
      ),
      onRefresh: _refresh,
    );
  }
  Widget tags(int indx){
    return ListView.builder(itemBuilder: (context,index){
      return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom:0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 70),
              width: 60,
              height: 30,
              color: Colors.blue[100],
              child: Padding(padding: const EdgeInsets.only(left: 5,top: 5,bottom: 5),
                  child: Text("${filteritems[indx].tags[index]}",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),)),
            ),
          ],
        ),
      );
    },itemCount: filteritems[indx].tags.length,shrinkWrap: true,scrollDirection: Axis.vertical,
    physics: BouncingScrollPhysics(),);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    filteritems.clear();
    getdata();
  }

  Future openbox(List<Items>datavalue)async{
    Hive.registerAdapter(ItemsAddapter());
   var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box=await Hive.openBox<Items>("data");
   setState(() {
     box.addAll(datavalue);
   if(box.values.isEmpty){
     dataItems.add(Items(title: "empty"));
   }else{
    var boxdata=box.toMap().values.toList();
    dataItems=boxdata;
    print("offlinedata:"+dataItems.first.title);
   }
   });
 return;
  }
}

class ItemsAddapter extends TypeAdapter<Items>{
  final typeId2 = 0;

  @override
  Items read(BinaryReader reader) {
    // TODO: implement read
  return Items(title: reader.read(),
  link: reader.read(),tags: reader.read(),viewCount: reader.read(),score: reader.read(),
  );
  }

  @override
  // TODO: implement typeId
  int get typeId => typeId2;

  @override
  void write(BinaryWriter writer, Items obj) {
    // TODO: implement write
    writer.write(obj.title);
    writer.write(obj.link);
    writer.write(obj.tags);
    writer.write(obj.creationDate);
    writer.write(obj.viewCount);
    writer.write(obj.owner.displayName);
  }

}