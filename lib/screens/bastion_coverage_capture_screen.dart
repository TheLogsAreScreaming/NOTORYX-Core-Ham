import 'package:flutter/material.dart';

class BastionCoverageCaptureScreen extends StatefulWidget {
  const BastionCoverageCaptureScreen({super.key});
  @override State<BastionCoverageCaptureScreen> createState() => _BastionCoverageCaptureScreenState();
}

class _BastionCoverageCaptureScreenState extends State<BastionCoverageCaptureScreen> {
  static const cyan = Color(0xFF18D3D3);
  bool recording = false;
  DateTime? started;
  int observations = 0;

  void toggle() {
    setState(() {
      recording = !recording;
      if (recording) { started = DateTime.now(); observations = 0; }
    });
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(backgroundColor: const Color(0xFF0B0E11), foregroundColor: Colors.white, title: const Text('COVERAGE CAPTURE', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFF12171C), borderRadius: BorderRadius.circular(18), border: Border.all(color: cyan.withValues(alpha:.45))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children:[Icon(recording ? Icons.radio_button_checked : Icons.route_rounded,color:cyan,size:30),const SizedBox(width:12),Expanded(child:Text(recording ? 'CAPTURE ACTIVE' : 'FIELD COVERAGE SESSION',style:const TextStyle(color:Colors.white,fontSize:20,fontWeight:FontWeight.w900)))]),
          const SizedBox(height:10), const Text('Start a field session before walking or driving a route. Bastion will use this session layer as the home for RX/TX observations, signal measurements, repeater sightings and future heatmap export.',style:TextStyle(color:Color(0xFF9AA6AF),height:1.45)),
        ])),
        const SizedBox(height:16),
        Row(children:[Expanded(child:_Stat(label:'OBSERVATIONS',value:'$observations')),const SizedBox(width:10),Expanded(child:_Stat(label:'STATUS',value:recording?'RECORDING':'READY'))]),
        const SizedBox(height:16),
        FilledButton.icon(style:FilledButton.styleFrom(backgroundColor:recording?const Color(0xFF303A42):cyan,foregroundColor:recording?Colors.white:Colors.black,padding:const EdgeInsets.symmetric(vertical:16)),onPressed:toggle,icon:Icon(recording?Icons.stop_rounded:Icons.play_arrow_rounded),label:Text(recording?'STOP SESSION':'START COVERAGE SESSION',style:const TextStyle(fontWeight:FontWeight.w900))),
        const SizedBox(height:20),
        const _Info(icon:Icons.sensors_rounded,title:'RX / TX OBSERVATIONS',body:'Session framework is now active. Packet events and radio metadata are the next data source to wire into this recorder.'),
        const SizedBox(height:10),
        const _Info(icon:Icons.cell_tower_rounded,title:'REPEATER SIGHTINGS',body:'Coverage sessions are designed to associate heard repeaters and nodes with field observations.'),
        const SizedBox(height:10),
        const _Info(icon:Icons.file_download_outlined,title:'SESSION EXPORT',body:'Structured export and heatmap generation will build on the captured session data in the next coverage iteration.'),
      ]),
    );
  }
}

class _Stat extends StatelessWidget {final String label,value;const _Stat({required this.label,required this.value});@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:const Color(0xFF12171C),borderRadius:BorderRadius.circular(14),border:Border.all(color:const Color(0xFF26313A))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:const TextStyle(color:Color(0xFF9AA6AF),fontSize:10,fontWeight:FontWeight.w800)),const SizedBox(height:5),Text(value,style:const TextStyle(color:Color(0xFF18D3D3),fontSize:16,fontWeight:FontWeight.w900))]));}
class _Info extends StatelessWidget {final IconData icon;final String title,body;const _Info({required this.icon,required this.title,required this.body});@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:const Color(0xFF10151A),borderRadius:BorderRadius.circular(15),border:Border.all(color:const Color(0xFF26313A))),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:const Color(0xFF18D3D3)),const SizedBox(width:11),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w800)),const SizedBox(height:4),Text(body,style:const TextStyle(color:Color(0xFF9AA6AF),fontSize:12.5,height:1.4))]))]));}
