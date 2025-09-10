import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smile_care_connect/helpful/Maindrawer.dart';
import 'package:smile_care_connect/models/userModel.dart';
class About extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const About({super.key, required this.userModel, required this.firebaseuser});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
List imagelist=[{"id":1,"imagepath":"assets/images/smile1.jpeg"},
  {"id":2,"imagepath":"assets/images/smile2.jpeg"},
  {"id":3,"imagepath":"assets/images/smile3.jpeg"}];

final CarouselController carouselController=CarouselController();

int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      drawer: MainDrawer(firebaseuser: widget.firebaseuser, userModel: widget.userModel),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About Us",
        style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(child: 
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width:double.infinity,
              height: size.height*0.3,
              //color: const Color.fromRGBO(255, 193, 7, 1),
              child:InkWell(onTap: (){print(currentIndex);},
                child: CarouselSlider(
                  items: 
                  imagelist.map(
                    (item){return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(20),
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
            ),
            Padding(
              padding:  EdgeInsets.all(size.width*0.04),
              child: const Wrap(
                spacing: 20,
                children:<Widget> [
                    Center(
                      child: Text("Our Vision",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Text("To revolutionize dental care through seamless connectivity and advanced technology."),
                    Text("To be the leading platform for patient-dentist interactions globally."),
                    Text("To ensure every individual has access to high-quality dental care and education."),
                        //SizedBox(height: size.height*0.2,),
                    //Mission
                    Center(child: Text("Our Mission",style: TextStyle(fontWeight: FontWeight.bold),)),
                      Text("To provide a user-friendly platform connecting patients with dental professionals.",),
                      Text("o enhance patient experience through personalized dental care solutions."),
                      Text("To promote preventive dental care and regular check-ups through easy accessibility"),
                      
                       //SizedBox(height: size.height*0.2,),
                    //Core Values
                    Center(child: Text("Core Values",style: TextStyle(fontWeight: FontWeight.bold),)),
                    Text("• Accessibility: Ensuring dental care is within reach for everyone."),
                    Text("• Innovation: Continuously improving our platform with the latest technology"),
                    Text("• Education: Promoting awareness and knowledge about dental health and hygiene.") 
                  ]
              ),
            ),
          ],
        ),
      )
      ),
    );
  }
}