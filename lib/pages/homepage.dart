import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Maindrawer.dart';
import 'package:smile_care_connect/helpful/articledisplay.dart';
import 'package:smile_care_connect/models/userModel.dart';
class Homepage extends StatefulWidget {
 final UserModel userModel;
  final User firebaseuser;
   const Homepage({super.key, required this.userModel,required this.firebaseuser});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  List imagelist=[{"id":1,"imagepath":"assets/images/smile1.jpeg"},
  {"id":2,"imagepath":"assets/images/smile2.jpeg"},
  {"id":3,"imagepath":"assets/images/smile3.jpeg"}];

final CarouselController carouselController=CarouselController();
int currentIndex=0;


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle:SystemUiOverlayStyle(statusBarColor: const Color.fromARGB(255, 0, 0, 0)
        // ,statusBarBrightness:Brightness.light),
        centerTitle: true,
        title: const Text("Home Page",
        style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.blue,
      ),
      drawer:  MainDrawer(userModel: widget.userModel, firebaseuser:widget.firebaseuser,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children:<Widget> [
                InkWell(onTap: (){print(currentIndex);},
                child: CarouselSlider(
                  items: 
                  imagelist.map(
                    (item){return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(image: AssetImage(item["imagepath"],
                          ),
                        fit: BoxFit.cover
                          )
                        ),
                      ),
                    );
                    }).toList(),
                
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) => setState(() {
                    currentIndex=index;
                  }),
                )
                )
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imagelist.asMap().entries.map((entry){
                    return GestureDetector(
                      onTap:()=> carouselController.animateToPage(entry.key),
                      child: Container(
                        width: entry.key==currentIndex?17:7,
                        height: 7,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: currentIndex==entry.key?Colors.red:Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: size.height*0.04,),
              
              const Expanded(child: ArticleDisplay()),
              
            ],
          ),
        ),
      ),
    );
  }
}