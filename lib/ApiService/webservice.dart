import 'dart:convert';

import 'package:flurn/Model/modelData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http ;
import 'package:http/http.dart';

class Apiservieces{

  Future<List<Items>>getitems()async{
    String url="https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow";
    Response response= await http.get(url);
    var jsonreponse=jsonDecode(response.body);
     List<Items>itmes=[];
     print("type"+jsonreponse.runtimeType.toString());
     print(jsonreponse["items"]);
     var data;
     if(jsonreponse==null){
       Fluttertoast.showToast(msg: "no data coming from api",toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.CENTER);
     }else{
       for( data in jsonreponse["items"]){
         itmes.add( Items( tags:data['tags'].cast<String>(),
             owner : data['owner'] != null ? new Owner.fromJson(data['owner']) : null,
             isAnswered:data['is_answered'],
             viewCount :data['view_count'],
             acceptedAnswerId : data['accepted_answer_id'],
             answerCount : data['answer_count'],
             score :data['score'],
             lastActivityDate : data['last_activity_date'],
             creationDate : data['creation_date'],
             lastEditDate : data['last_edit_date'],
             questionId : data['question_id'],
             contentLicense : data['content_license'],
             link : data['link'],
             title : data['title']));
         print(data["title"]+data['question_id'].toString());
       }
     }

return itmes;
  }
}