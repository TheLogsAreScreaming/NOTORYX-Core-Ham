import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'map_cache_screen.dart';
import 'region_management_screen.dart';
import 'bastion_coverage_capture_screen.dart';

class BastionMapHubScreen extends StatelessWidget {
  const BastionMapHubScreen({super.key});
  static const _cyan=Color(0xFF18D3D3),_bg=Color(0xFF0B0E11),_panel=Color(0xFF12171C),_muted=Color(0xFF9AA6AF);
  @override Widget build(BuildContext context)=>Scaffold(backgroundColor:_bg,appBar:AppBar(backgroundColor:_bg,foregroundColor:Colors.white,surfaceTintColor:Colors.transparent,title:const Text('BASTION FIELD MAP',style:TextStyle(fontWeight:FontWeight.w900,letterSpacing:1.2))),body:SafeArea(top:false,child:ListView(padding:const EdgeInsets.fromLTRB(18,18,18,28),children:[
    Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:_panel,borderRadius:BorderRadius.circular(18),border:Border.all(color:_cyan.withValues(alpha:.42))),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Icon(Icons.map_rounded,color:_cyan,size:30),SizedBox(width:12),Expanded(child:Text('MAP + COVERAGE',style:TextStyle(color:Colors.white,fontSize:21,fontWeight:FontWeight.w900,letterSpacing:.7)))]),SizedBox(height:10),Text('Live maps, offline areas, regional profiles and Bastion field coverage sessions.',style:TextStyle(color:_muted,height:1.45))])),
    const SizedBox(height:18),
    _MapAction(icon:Icons.radio_button_checked,title:'COVERAGE CAPTURE',subtitle:'Start and stop a field coverage session',badge:'NEW',onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const BastionCoverageCaptureScreen()))),
    const SizedBox(height:12),
    _MapAction(icon:Icons.public_rounded,title:'LIVE MESH MAP',subtitle:'Nodes, repeaters, positions, routes and map tools',badge:'LIVE',onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const MapScreen()))),
    const SizedBox(height:12),
    _MapAction(icon:Icons.offline_pin_rounded,title:'OFFLINE MAP PACKS',subtitle:'Cache map tiles for trips and no-service areas',badge:'OFFLINE',onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const MapCacheScreen()))),
    const SizedBox(height:12),
    _MapAction(icon:Icons.hub_rounded,title:'REGION PROFILES',subtitle:'Manage and fetch regional mesh definitions',badge:'REGIONS',onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const RegionManagementScreen()))),
  ])));
}
class _MapAction extends StatelessWidget {final IconData icon;final String title,subtitle,badge;final VoidCallback onTap;const _MapAction({required this.icon,required this.title,required this.subtitle,required this.badge,required this.onTap});@override Widget build(BuildContext context)=>Material(color:const Color(0xFF12171C),borderRadius:BorderRadius.circular(16),child:InkWell(borderRadius:BorderRadius.circular(16),onTap:onTap,child:Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(border:Border.all(color:const Color(0xFF26313A)),borderRadius:BorderRadius.circular(16)),child:Row(children:[Container(width:48,height:48,decoration:BoxDecoration(color:BastionMapHubScreen._cyan.withValues(alpha:.12),borderRadius:BorderRadius.circular(13)),child:Icon(icon,color:BastionMapHubScreen._cyan)),const SizedBox(width:13),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Expanded(child:Text(title,style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w800,letterSpacing:.4))),Container(padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),decoration:BoxDecoration(color:BastionMapHubScreen._cyan.withValues(alpha:.12),borderRadius:BorderRadius.circular(999)),child:Text(badge,style:const TextStyle(color:BastionMapHubScreen._cyan,fontSize:9,fontWeight:FontWeight.w900,letterSpacing:.7)))]),const SizedBox(height:4),Text(subtitle,style:const TextStyle(color:BastionMapHubScreen._muted,fontSize:12.5))])),const SizedBox(width:8),const Icon(Icons.chevron_right_rounded,color:BastionMapHubScreen._cyan)]))));}
