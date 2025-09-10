import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class ArticleDisplay extends StatefulWidget {
  const ArticleDisplay({super.key});

  @override
  State<ArticleDisplay> createState() => _ArticleDisplayState();
}
  
class _ArticleDisplayState extends State<ArticleDisplay> {

late Future<List<Article>>future;

@override
  void initState() {
    future=getNewsData();
    super.initState();
  }

  Future<List<Article>> getNewsData() async{
    NewsAPI newsAPI=NewsAPI(apiKey: "bf38180cbc904d7fa8221a432fa41047");
    //newsAPI.getTopHeadlines(country: "in",query: "dental care");
    return await newsAPI.getEverything(query: "dental care",queryInTitle: "oral hygine routine",language: "en",sortBy: "relevancy");
    //return await newsAPI.getTopHeadlines(country: "in",category: "health");
  }

Widget buildArticleViewList(List<Article>articlelist){
    return 
    ListView.builder(itemBuilder: (context,index)
    {
     Article article=articlelist[index];
     return buildArticleList(article) ;
    },
    itemCount: articlelist.length,
    );
  }

  Widget buildArticleList(Article article)
  {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
        height: 80,
        width: 80,
        child: Image.network(article.urlToImage??"",
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace){return const Icon(Icons.photo,color: Colors.blue,);}
        ),
          ),
          const SizedBox(width: 20,),

          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(article.title!,
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                maxLines: 2,
                ),
                Text(article.source.name!,style: const TextStyle(fontSize: 16),)
            ]
        
          ))
        ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
        children: [
          Expanded(
            child: FutureBuilder(future: future, builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting)
              {
                return const Center(child: CircularProgressIndicator());
              }
              else if(snapshot.hasError)
              {
                return const Center(child: Text("error loading the content"),);
              }
              else
              {
                if(snapshot.hasData && snapshot.data!.isNotEmpty )
                {
                  return buildArticleViewList(snapshot.data as List<Article>);
                }
                else
                {
                  return const Center(child: Text("No article available"));
                }
              }
            }),
          )
        ],
      )),
    );

  



  }
}