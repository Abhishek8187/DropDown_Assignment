import 'package:drop_down/provider/container_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Utils/mainContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> selectedOptionIndex = [-1,-1,-1,-1];

  void onOptionSelected(int index, int serialNo) {
    setState(() {
      selectedOptionIndex[index] = serialNo;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final sizeProvider = Provider.of<SizeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ******* PROFILE PICTURE ******** //
                Container(
                  height: 0.15 * screenHeight,
                  width: 0.15 * screenHeight,
                  decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.circular(0.15 * screenHeight)),
                  child: const Image(
                    image: AssetImage('asset/images/avatar.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),

                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Abhishek',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    )),

                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'A highly motivated product designer with 3 years of experience who worked with a variety of clients and projects. I have successfully led projects from ideation to launch.\n\nProduct designer\nDeveloper',
                      style: TextStyle(),
                    )),

                // ********* LIST OF CONTAINERS **********//
                Consumer<SizeProvider>(builder: (context, value, child){
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                        return  Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              if (value.selectedOptionIndex[index] == 0)
                                MainContainer(
                                  height: 50,
                                  width: double.infinity,
                                  borderRadius: 5,

                                )
                              else if (value.selectedOptionIndex[index] == 1)
                                MainContainer(
                                  height: 100,
                                  width: double.infinity,
                                  borderRadius: 8,

                                )
                              else if (value.selectedOptionIndex[index] == 2)
                                  MainContainer(
                                    height: 0.3 * screenHeight,
                                    width: 0.5 * screenHeight,
                                    borderRadius: 28,

                                  )
                                else
                                  MainContainer(
                                    height: 0.25 * screenHeight,
                                    width: 0.25 * screenHeight,
                                    borderRadius: 28,

                                  ),
                              const SizedBox(
                                height: 2,
                              ),
                              if (value.selectedOptionIndex[index] == -1)
                                Container(
                                  height: 33,
                                  width: 0.2 * screenHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        optionContainer(sizeProvider,index, 0,8,30),
                                        optionContainer(sizeProvider,index, 1,13,30),
                                        optionContainer(sizeProvider,index, 2,25,25),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // *********  SHOWING OPTIONS OF DIFFERENT SIZE CONTAINERS  ********//
  InkWell optionContainer(SizeProvider sizeProvider,int index,int serialNo, double height, double width) {
    return InkWell(
      onTap: () {
        sizeProvider.onOptionSelected(index,serialNo);
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      ),
    );
  }
}
