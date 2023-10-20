import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({Key? key}) : super(key: key);

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  // final int _currentIndex = 2;
  // final PageController _pageController = PageController();

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  int? currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((currentYear! - 2).toString()),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentYear = currentYear! - 2;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border: Border.all(
                                    width: 10, color: Colors.transparent),
                              ),
                            ),
                          ),
                          //this the ligne
                          Expanded(
                              child: Container(
                            height: 5,
                            color: Colors.black12,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((currentYear! - 1).toString()),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentYear = currentYear! - 1;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border: Border.all(
                                    width: 10, color: Colors.transparent),
                              ),
                            ),
                          ),
                          //this the ligne
                          Expanded(
                              child: Container(
                            height: 5,
                            color: Colors.black12,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentYear.toString()),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border:
                                    Border.all(width: 10, color: Colors.grey),
                              ),
                            ),
                          ),
                          //this the ligne
                          Expanded(
                              child: Container(height: 5, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((currentYear! + 1).toString()),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentYear = currentYear! + 1;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border: Border.all(
                                    width: 10, color: Colors.transparent),
                              ),
                            ),
                          ),
                          //this the ligne
                          Expanded(
                              child: Container(
                            height: 5,
                            color: Colors.black12,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text((currentYear! + 2).toString()),
                    Row(
                      children: [
                        //this is the bubble
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentYear = currentYear! + 2;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              border: Border.all(
                                  width: 10, color: Colors.transparent),
                            ),
                          ),
                        ),
                        //this the line
                        Container(
                          height: 15,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Audit Universe Year",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// class StepperComponent extends StatelessWidget {
//   int index;

//   int currentIndex;
//   VoidCallback onTap;

//   bool isLast;
//   StepperComponent({
//     super.key,
//     required this.currentIndex,
//     required this.index,
//     required this.onTap,
//     this.isLast = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return isLast
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('202${index + 1}'),
//               Row(
//                 children: [
//                   //this is the bubble
//                   GestureDetector(
//                     onTap: onTap,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         // borderRadius: BorderRadius.circular(150),
//                         color:
//                             index == currentIndex ? Colors.white : Colors.grey,
//                         border: Border.all(
//                             width: 10,
//                             color: currentIndex >= index
//                                 ? Colors.grey
//                                 : Colors.transparent),
//                       ),
//                     ),
//                   ),
//                   //this the line
//                   Container(
//                     height: 15,
//                     color: currentIndex >= index + 1
//                         ? Colors.grey
//                         : Colors.black12,
//                   ),
//                 ],
//               ),
//             ],
//           )
//         : Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('202${index + 1}'),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: onTap,
//                       child: Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: index == currentIndex
//                               ? Colors.white
//                               : Colors.grey,
//                           border: Border.all(
//                               width: 10,
//                               color: currentIndex >= index
//                                   ? Colors.grey
//                                   : Colors.transparent),
//                         ),
//                       ),
//                     ),
//                     //this the ligne
//                     Expanded(
//                         child: Container(
//                       height: 5,
//                       color: currentIndex >= index + 1
//                           ? Colors.grey
//                           : Colors.black12,
//                     )),
//                   ],
//                 ),
//               ],
//             ),
//           );
//   }
// }
