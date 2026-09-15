import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';

class BastionFieldStatsScreen extends StatelessWidget {
  const BastionFieldStatsScreen({super.key});
  static const _cyan=Color(0xFF18D3D3),_bg=Color(0xFF0B0E11),_panel=Color(0xFF12171C);
  @override Widget build(BuildContext context){
    final connector=context.watch<MeshCoreConnector>(); final contacts=connector.contacts; final now=DateTime.now();
    final repeaters=contacts.where((c)=>c.type==advTypeRepeater).length;
    final rooms=contacts.where((c)=>c.type==advTypeRoom).length;
    final sensors=contacts.where((c)=>c.type==advTypeSensor).length;
    final chats=contacts.where((c)=>c.type==advTypeChat).length;
    final located=contacts.where((c)=>c.hasLocation).length;
    final favorites=contacts.where((c)=>c.isFavorite).length;
    final recent=contacts.where((c)=>now.difference(c.lastSeen).inMinutes<=60).length;
    final routed=contacts.where((c)=>c.pathLength>0||c.path.isNotEmpty).length;
    final direct=contacts.where((c)=>c.pathLength==0).length;
    final flood=contacts.where((c)=>c.pathLength<0).length;
    return Scaffold(backgroundColor:_bg,appBar:AppBar(backgroundColor:_bg,foregroundColor:Colors.white,title:const Text('FIELD INTELLIGENCE',style:TextStyle(fontWeight:FontWeight.w900,letterSpacing:1.2))),body:ListView(padding:const EdgeInsets.fromLTRB(18,10,18,28),children:[
      Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:_panel,borderRadius:BorderRadius.circular(18),border:Border.all(color:_cyan.withValues(alpha:.45))),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('LIVE MESH SNAPSHOT',style:TextStyle(color:_cyan,fontSize:12,fontWeight:FontWeight.w900,letterSpacing:1.4)),SizedBox(height:8),Text('What Bastion knows right now.',style:TextStyle(color:Colors.white,fontSize:21,fontWeight:FontWeight.w800)),SizedBox(height:6),Text('These counters are calculated from the connected MeshCore contact table, locations, paths and last-seen timestamps.',style:TextStyle(color:Color(0xFFB8C1C9),height:1.4))])),
      const SizedBox(height:16),_grid([['TOTAL','${contacts.length}'],['ACTIVE 1H','$recent'],['REPEATERS','$repeaters'],['CHAT NODES','$chats'],['ROOMS','$rooms'],['SENSORS','$sensors'],['LOCATED','$located'],['FAVORITES','$favorites']]),
      const SizedBox(height:18),const _Title('ROUTE SNAPSHOT'),const SizedBox(height:8),_grid([['ROUTED','$routed'],['DIRECT','$direct'],['FLOOD','$flood'],['GPS','$located']]),
      const SizedBox(height:18),const _Panel(Icons.route_rounded,'PATH INTELLIGENCE','Bastion’s path engine separately tracks attempts, hop counts, success/failure, trip time and route weighting. The Path Analysis module is being expanded around those persisted records.'),
      const SizedBox(height:10),const _Panel(Icons.map_rounded,'COVERAGE SESSIONS','Coverage Capture is active as a field-session module. Radio event + GPS persistence is the next wiring layer before we call it true wardrive logging.'),
    ]));
  }
  Widget _grid(List<List<String>> v)=>GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing:10,mainAxisSpacing:10,childAspectRatio:1.8),itemCount:v.length,itemBuilder:(_,i)=>Container(padding:const EdgeInsets.all(13),decoration:BoxDecoration(color:const Color(0xFF10151A),borderRadius:BorderRadius.circular(14),border:Border.all(color:const Color(0xFF26313A))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[Text(v[i][1],style:const TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.w900)),Text(v[i][0],style:const TextStyle(color:_cyan,fontSize:9,fontWeight:FontWeight.w900,letterSpacing:1))]));
}
class _Title extends StatelessWidget{final String t;const _Title(this.t);@override Widget build(BuildContext c)=>Text(t,style:const TextStyle(color:Color(0xFF18D3D3),fontSize:11,fontWeight:FontWeight.w900,letterSpacing:1.3));}
class _Panel extends StatelessWidget{final IconData i;final String t,b;const _Panel(this.i,this.t,this.b);@override Widget build(BuildContext c)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:const Color(0xFF10151A),borderRadius:BorderRadius.circular(15),border:Border.all(color:const Color(0xFF26313A))),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(i,color:const Color(0xFF18D3D3)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w800)),const SizedBox(height:5),Text(b,style:const TextStyle(color:Color(0xFF9AA6AF),height:1.4))]))]));}
