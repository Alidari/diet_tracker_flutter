import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';
import '../models/question.dart';
import '../widgets/question_widget.dart';
import '../widgets/optioncard.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final List<Question>_questions=[
    
    Question(image: Image.asset('assets/muz.jpg'),
      id: '1', title: "Muz Meyvesi kac kalori içerir?(100g)", options: {'A)76 kcal':false ,'B)88 kcal':true,'C)92 kcal':false,'D)58 kcal':false },
   ),
   
    Question(image: Image.asset( 'assets/portakal.jpg'),
      id: '2', title: "Portakal meyvesi kaç kalori içerir(100g)?", options: {'A)47 kcal':true ,'B)62 kcal':false,'C)81 kcal':false,'D)105 kcal':false },
    ),
    Question(image:Image.asset( 'assets/karpuz.jpg'),
      id: '3', title: " Karpuz meyvesi kaç kalori içerir(100g)?", options: {'A)72 kcal':false ,'B)48 kcal':false,'C)58 kcal':false,'D)30 kcal':true },
    ),
    Question(image: Image.asset('assets/cilek.jpg'),
      id: '4', title: "Çilek meyvesi kaç kalori içerir?(100g)", options: {'A)23 kcal':false ,'B)41 kcal':false,'C)32 kcal':true,'D)67 kcal':false },
    ),
    Question(image:Image.asset( 'assets/ananas.jpg'),
      id: '5', title: " Ananas meyvesi kaç kalori içerir?(100g)", options: {'A)35 kcal':false ,'B)50 kcal':true,'C)68 kcal':false,'D)82 kcal':false },
    )
    
  ];
  
  late final AnimationController _correctController;
  late final AnimationController _wrongController;


  int index=0;

  int trueScore=0;
  int falseScore=0;

  int pressedButtonIndex = -1;

  bool isPressed=false;
  bool correctAnimEnabled = false;
  Duration correctAnimDuration = Duration(seconds: 1);

  bool wrongAnimEnabled = false;
  Duration wrongAnimDuration = Duration(seconds: 1);

  @override
  void initState() {
    _correctController =
        AnimationController(vsync: this, duration: correctAnimDuration);

    _wrongController =
        AnimationController(vsync: this,duration:  wrongAnimDuration);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _correctController.dispose();
  }
  void nextQuestion(){
    if(index==_questions.length-1){
      return;
    }
    else{
    setState(() {
      correctAnimEnabled = false;
      index++;
      isPressed=false;
      pressedButtonIndex = -1;
    });
    }
  }
  void changeColor(int selecetedOptionIndex){
    setState(() {


      isPressed=true;
      pressedButtonIndex = selecetedOptionIndex;
      int i = 0;
      for(i;i<_questions[index].options.length;i++){
        print(_questions[index].options.values.toList()[i]);
        if(_questions[index].options.values.toList()[i]){
          if(i == selecetedOptionIndex){
            correctAnimEnabled = true;
            // Animasyonun başlangıcını tetikle
            _correctController.forward();

            _correctController.forward().then((value) => {
  _correctController.reverse().then((value) => {
    setState(() {
      correctAnimEnabled = false; // Doğru animasyon tamamlandığında correctAnimEnabled değerini false olarak ayarla
    }),
    nextQuestion(),
  })
});

            trueScore++;
            return;
          }
        }
      }

      if(i == _questions[index].options.length) {
        wrongAnimEnabled = true;
        _wrongController.forward().then((value) => {
          _wrongController.reverse().then((value) => {
            nextQuestion(),
            wrongAnimEnabled = false
          })
        });

        falseScore ++;}

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:background ,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Color.fromARGB(0, 74, 11, 11),
        actions: [

        ],
      ),
      body: Stack(

        children:  [
          Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children:[
              QuestionWidget(question: _questions[index].title, indexAction: index, totalQuestions: _questions.length,image: _questions[index].image
              ),
              const SizedBox(height: 25.0,),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        for(int i=0;i<_questions[index].options.length-2;i++)
                        OptionCard(option: _questions[index].options.keys.toList()[i],
                        color: isPressed ? _questions[index].options.values.toList()[i]==true ?  correct : incorrect : neutralOption,
                          optionIndex: i,
                          onTap: changeColor,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        for(int i=2;i<_questions[index].options.length;i++)
                          OptionCard(option: _questions[index].options.keys.toList()[i],
                            color: isPressed ? _questions[index].options.values.toList()[i]==true ?  correct : incorrect : neutralOption,
                            optionIndex: i,
                            onTap: changeColor,
                          ),
                      ],
                    ),

                  ],
                ),
              ),


              SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.check_box_rounded,size: 50,color: Colors.green,),
                          Text("Doğru:" + trueScore.toString(),
                          style: GoogleFonts.aDLaMDisplay(
                            color: Colors.green,
                            fontSize: 25,
                            fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.close_rounded,size: 55,color: Colors.red,),
                          Text("Yanlış: " + falseScore.toString(),
                            style: GoogleFonts.aDLaMDisplay(
                              color: Colors.red,
                              fontSize: 25,
                                fontWeight: FontWeight.w600)
                          ),
                        ],

                      )
                    ],
                  ),
                ),
              )



          ],

          ),

            ),
          if(correctAnimEnabled)
            Center(
              child: Lottie.asset(
                  "assets/correctAnim.json",
                  width: 200,
                  height: 200,
                  controller: _correctController
              ),
            ),
          if(wrongAnimEnabled)
            Center(
              child: Lottie.asset(
                  "assets/wrongAnim.json",
                  width: 200,
                  height: 200,
                  controller: _wrongController
              ),
            ),


        ],
      ),

   /* floatingActionButton: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: NextButton(
        nextQuestion: nextQuestion,
      ),
    ),*/
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}