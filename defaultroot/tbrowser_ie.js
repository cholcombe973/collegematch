q58="style.visibility=\"visible\"";
q59="style.visibility=\"hidden\"";
q82=null;q93=null;
q94=null;
q95=null;
strict=((q147)&&(document.compatMode=="CSS1Compat"));
if((q150)&&(document.doctype)){
	tval=document.doctype.name.toLowerCase();
	if((tval.indexOf("dtd")>-1)&&((tval.indexOf("http")>-1)||(tval.indexOf("xhtml")>-1)))
		strict=true;
}
if((navigator.appVersion.toLowerCase().indexOf("msie 5.0")> -1)||(strict)||(q150)){
	dqm__sub_menu_effect="none";  
	dqm__sub_item_effect="none";
}
sub_q98=q97(true);
item_q98=q97();
off_y=0;
off_x=0;
off2_x=0;
off2_y=0;
if(q150){
	if(document.body.leftMargin)
		off_x=parseInt(document.body.leftMargin);
	if(document.body.topMargin)
		off_y=parseInt(document.body.topMargin);
	off2_x=off_x-dqm__main_margin_left;
	off2_y=off_y-dqm__main_margin_top;
	document.onmousemove=dqm__handleMousemove;
	onresize=dqm__handleResize;
	onload=dqm__handleOnload;
}
else {
	document.attachEvent("onmousemove",dqm__handleMousemove);
	attachEvent("onresize",dqm__handleResize);
	attachEvent("onload",dqm__handleOnload);}
	q18=q100();
	for(var m=0;m<q18;m++)
		if(q105[m])
			q0(m+"");
	for(var j=0;j<q19.length;j++)
		q0(q19[j]);
	write_mainbar();
	if(!q150)
		check_loaded();;
	function check_loaded(){
		if((q64=window.imgbar)&&((q64.offsetLeft>0)||(q64.offsetTop>0)))
			dqm__handleOnload();
		else 
			setTimeout("check_loaded()",200);
	};
	function write_mainbar(){
		sd="<div id='dqmbar' style='position:absolute;z-index:900;
		visibility:hidden;
		top:0;
		left:0;'>";
		mitemx=0;
		mitemy=0;
		if(dqm__main_use_dividers)
			dqm__main_item_gap=0;
		max_h=0;
		max_w=0;
		for(i=0;i<q18;i++){
			if((mitemh=q15("dqm__main_height",0,i))>max_h)
				max_h=mitemh;
			if((mitemw=q15("dqm__main_width",0,i))>max_w)
				max_w=mitemw;
		}
		for(i=0;i<q18;i++){
			dibw=dqm__main_border_width;
			mitemw=q15("dqm__main_width",0,i);
			mitemh=q15("dqm__main_height",0,i);
			q130=q15("dqm__main_text_alignment",0,i);
			mbgc=q15("dqm__main_bgcolor",0,i);
			mhlbgc=q15("dqm__main_hl_bgcolor",0,i);
			mtc=q15("dqm__main_textcolor",0,i);
			mhltc=q15("dqm__main_hl_textcolor",0,i);
			mtd=q15("dqm__main_textdecoration",0,i);
			mhltd=q15("dqm__main_hl_textdecoration",0,i);
			mff=q15("dqm__main_fontfamily",0,i);
			mfs=q15("dqm__main_fontsize",0,i);
			mfw=q15("dqm__main_fontweight",0,i);
			mft=q15("dqm__main_fontstyle",0,i);
			mtm=q15("dqm__main_margin_top",0,i);
			mbm=q15("dqm__main_margin_bottom",0,i);
			iid=-1;
			tval=window["dqm__micon_index"+i];
			if((tval || tval==0)&& window["dqm__icon_image"+tval]){
				iid=tval;
				q52=q33(q16("dqm__icon_image_wh"+iid));
				q51=window["dqm__icon_rollover"+iid];
			}
			if(dqm__align_items_bottom_and_right){
				if(dqm__main_horizontal)
					mitemy=max_h-mitemh;
				else 
					mitemx=max_w-mitemw;
			}
			q47=" font-style:"+mft+";
			font-weight:"+mfw+";
			font-size:"+mfs+"px;
			font-family:"+mff+";
			padding-left:"+dqm__main_margin_left+"px;
			padding-right:"+dqm__main_margin_right+"px;
			padding-top:"+mtm+"px;padding-bottom:"+mbm+"px;";
			sd+="<div align='"+q130+"' style='position:absolute;
			cursor:hand;
			top:"+mitemy+"px;
			left:"+mitemx+"px;
			width:"+(mitemw+(dibw*2))+"px;
			height:"+(mitemh+(dibw*2))+"px;";
			if(dqm__main_border_color!="transparent")
				sd+="background-color:"+dqm__main_border_color+";";sd+="'>";
			smargin=0;
			bmargin=0;
			if(strict){
				smargin=dqm__main_margin_right+dqm__main_margin_left;
				bmargin=mbm+mtm;
			}
			sd+="<div  id='menu"+i+"' style='position:absolute;
			top:"+dibw+"px;
			left:"+dibw+"px;
			width:"+(mitemw-smargin)+"px;height:"+(mitemh-bmargin)+"px;";
			if(mbgc!="transparent")
				sd+="background-color:"+mbgc+";";
			sd+=" color:"+mtc+";text-decoration:"+mtd+";";
			sd+=q47;
			sd+="'>";
			q125="";
			if(iid>-1) 
				q125="<img src='"+q16("dqm__icon_image"+iid)+"' border=0 width='"+q52[0]+"' height='"+q52[1]+"'>";
			tval=q16("dqm__maindesc"+i);
			(q130=="right")? sd+=tval+q125:sd+=q125+tval;
			sd+="</div>";
			sd+="<div id='qmim"+i+"'   onclick=\"q32('"+i+"')\" align='"+q130+"' style='position:absolute;
			visibility:hidden;
			top:"+dibw+"px;
			left:"+dibw+"px;
			width:"+(mitemw-smargin)+"px;
			height:"+(mitemh-bmargin)+"px;";
			if(mhlbgc!="transparent")
				sd+="background-color:"+mhlbgc+";";
			sd+=" color:"+mhltc+";
			text-decoration:"+mhltd+";";
			sd+=q47;sd+="'>";
			q125="";
			if(iid>-1) 
				q125="<img src='"+q51+"' border=0 width='"+q52[0]+"' height='"+q52[1]+"'>";
			tval=q15("dqm__hl_maindesc"+i,q16("dqm__maindesc"+i));
			(q130=="right")? sd+=tval+q125:sd+=q125+tval;
			sd+="</div>";
			sd+="</div>";
			if((!dqm__main_use_dividers)||(i==(q18-1)))
				dibw=(dibw*2);
			if(dqm__main_horizontal)
				mitemx+=mitemw+dibw+dqm__main_item_gap;
			else 
				mitemy+=mitemh+dibw+dqm__main_item_gap;
		}
		sd+="</div>";
		document.write(sd); 
};
function generate_mainitems(){
	dibw=dqm__main_border_width;
	max_h=0;
	max_w=0;
	tot_h=0;
	tot_w=0;
	for(i=0;i<q18;i++){
		if((mitemh=q15("dqm__main_height",0,i))>max_h)
			max_h=mitemh;
		if((mitemw=q15("dqm__main_width",0,i))>max_w)
			max_w=mitemw;
		tot_h+=mitemh;
		tot_w+=mitemw;
	}
	max_h+=dibw*2;
	max_w+=dibw*2;
	the_w=max_w;
	the_h=max_h;
	if(dqm__main_horizontal){
		the_w=tot_w;
		if(dqm__main_use_dividers)
			the_w+=(q18*dibw)+dibw;
		else 
			the_w+=(q18*(dibw*2))+((q18-1)*dqm__main_item_gap);
	}
	else {
		the_h=tot_h;
		if(dqm__main_use_dividers)
			the_h+=(q18*dibw)+dibw;
		else 
			the_h+=(q18*(dibw*2))+((q18-1)*dqm__main_item_gap);
	}
	document.write("<img id='imgbar' src='"+dqm__codebase+"tdqm_pixel.gif' width="+the_w+" height="+the_h+">")
};
function q0(mindex){
	level=0;i=0;
	while((i=mindex.indexOf("_",i+1))>-1)
		level++;
	bw=q15("dqm__border_width",0,mindex);
	q50=q15("dqm__sub_menu_width",0,mindex);
	bc=q15("dqm__border_color",0,mindex);       
	hltc=q15("dqm__hl_textcolor",0,mindex);       
	q144=q15("dqm__textcolor",0,mindex);
	sd="<div id=qm"+mindex+" style='z-index:900"+level+";
	position:absolute;
	top:"+0+"px;
	left:"+0+"px;
	visibility:hidden;
	width:"+q50+"px;";
	if(bc!="transparent")
		sd+=" background-color:"+bc+";";
	sd+=sub_q98;
	(sub_q98.indexOf("filter")>-1)? t_val="":t_val="filter:";
	if(dqm__sub_menu_opacity<100)
		sd+=" "+t_val+"progid:DXImageTransform.Microsoft.Alpha(opacity="+dqm__sub_menu_opacity+");";
	if(dqm__dropshadow_color.toLowerCase()!="none")
		sd+=" "+t_val+"progid:DXImageTransform.Microsoft.dropshadow(color="+dqm__dropshadow_color+",offx="+dqm__dropshadow_offx+",offy="+dqm__dropshadow_offy+");";
	sd+="'>";
	i=0;
	while(window["dqm__subdesc"+mindex+"_"+i]){
		id=mindex+"_"+i;
		if(window["dqm__subdesc"+id+"_0"])
			q19=q19.concat(new Array(id));
		iid=-1;
		tval=window["dqm__icon_index"+mindex+"_"+i];
		if((tval || tval==0)&& window["dqm__icon_image"+tval]){
			iid=tval;
			q52=q33(q16("dqm__icon_image_wh"+iid));
			q51=window["dqm__icon_rollover"+iid];
		}
		smargin=0;
		if(strict)
			smargin=dqm__margin_right+dqm__margin_left;
		q47="style='position:absolute;
		cursor:hand;
		left:"+bw+"px;top:"+bw+"px;
		width:"+(q50-(bw*2)-smargin)+"px;";
		q48=" font-style:"+dqm__fontstyle+";
		font-weight:"+dqm__fontweight+";
		font-size:"+dqm__fontsize+"px;
		font-family:"+dqm__fontfamily+";
		padding-left:"+dqm__margin_left+"px;
		padding-right:"+dqm__margin_right+"px;
		padding-top:"+dqm__margin_top+"px;
		padding-bottom:"+dqm__margin_bottom+"px;";
		q49="";
		if(iid>-1)
			q49="' border=0 width='"+q52[0]+"' height='"+q52[1]+"'>";
		q92=q15("dqm__menu_bgcolor",0,mindex);
		mbgc_hl=q15("dqm__hl_bgcolor",0,mindex);
		q130=q15("dqm__text_alignment",0,mindex);
		sd+="<div align='"+q130+"' id=qmitemst"+id+" "+q47+" background-color:"+q92+";";
		sd+=q48+" text-decoration:"+dqm__textdecoration+";
		color:"+q144+";'>";q125="";
		if(iid>-1)
			q125="<img src='"+q16("dqm__icon_image"+iid)+q49;
		tval=q16("dqm__subdesc"+id);
		(q130=="right")? sd+=tval+q125:sd+=q125+tval;
		q131="";
		q132="";
		q129="";
		q134="";
		tval=window["dqm__2nd_icon_index"+mindex+"_"+i];
		if((tval || tval==0)&& window["dqm__2nd_icon_image"+tval]){
			q126=tval;
			q127=q33(q16("dqm__2nd_icon_image_wh"+q126));
			q128=q33(q16("dqm__2nd_icon_image_xy"+q126));
			q129=q16("dqm__2nd_icon_rollover"+q126);
			q134=q16("dqm__2nd_icon_image"+q126);
			(q130=="left")? tval=(q50-(bw*2)-dqm__margin_right-q127[0]+q128[0]):tval=bw+dqm__margin_left+q128[0];
			q131="<div style='position:absolute;
			top:"+q128[1]+"px;left:"+tval+"px;'><img src='";q132="' width='"+q127[0]+"' height='"+q127[1]+"'></div>";
		}
		sd+=q131+q134+q132+"</div><div align='"+q130+"' id=qmitemhl"+id+" "+q47+" visibility:hidden;
		background-color:"+mbgc_hl+";";
		sd+=q48+" text-decoration:"+dqm__hl_textdecoration+";
		color:"+hltc+";"+item_q98;
		sd+="' onclick=\"q32('"+id+"')\">";
		q125="";
		if(iid>-1)
			q125+="<img src='"+q51+q49;
		tval=q15("dqm__hl_subdesc"+id,q16("dqm__subdesc"+id));
		(q130=="right")? sd+=tval+q125:sd+=q125+tval;
		sd+=q131+q129+q132+"</div>";i++;
	}
	document.write(sd+"</div>");
};
function q97(main){
	q98="";
	tval="q98=\" filter:progid:DXImageTransform.Microsoft.";
	q115="duration=";
	q108=dqm__sub_item_effect_duration;
	q114=dqm__sub_item_effect.toLowerCase();
	if(main){
		q114=dqm__sub_menu_effect.toLowerCase();
		q108=dqm__sub_menu_effect_duration;
	}
	if(q114!="none"){
		if(q114=="fade")
			q16(tval+"Fade("+q115+q108+")\"");
		else  
			if(q114=="pixelate")
				q16(tval+"Pixelate("+q115+q108+",maxSquare="+dqm__effect_pixelate_maxsqare+")\"");
			else  
				if(q114=="iris")
					q16(tval+"Iris("+q115+q108+",irisStyle="+dqm__effect_iris_irisstyle+")\"");
				else  
					if(q114=="slide")
						q16(tval+"slide("+q115+q108+",slideStyle=PUSH)\"");
				else  
					if(q114=="gradientwipe")
						q16(tval+"GradientWipe("+q115+q108+",gradientSize=1.0,motion=FORWARD)\"");
					else  
						if(q114=="checkerboard")
							q16(tval+"CheckerBoard("+q115+q108+",direction="+dqm__effect_checkerboard_direction+",SquaresX="+dqm__effect_checkerboard_squaresx+",SquaresY="+dqm__effect_checkerboard_squaresY+")\"");
						else  
							if(q114=="radialwipe")
								q16(tval+"RadialWipe("+q115+q108+")\"");
							else  
								if(q114=="randombars")
									q16(tval+"RandomBars("+q115+q108+")\"");
								else  
									if(q114=="randomdissolve")
										q16(tval+"RandomDissolve("+q115+q108+")\"");
									else  
										if(q114=="stretch")
											q16(tval+"Stretch("+q115+q108+",stretchStyle=PUSH)\"");
	}
	return q98;
};
function q1(id,main){
	sub=q16("qm"+id);
	q113=sub.style;
	subc=sub.children;
	bw=q15("dqm__border_width",0,id);
	dh=q15("dqm__divider_height",0,id);
	ih=bw;
	for(j=0;j<subc.length;j=j+2){
		subc[j].style.top=ih+"px";
		subc[j+1].style.top=ih+"px";
		ih+=subc[j].offsetHeight+dh;
		if(j>subc.length-3)
			ih -=dh;
	}
	ih+=bw;
	q113.height=ih+"px";
	sxy=q33(q15("dqm__sub_xy"+id,dqm__sub_xy));
	if(main){
		q85=q16("menu"+id);
		tc=q17(q85);
		q113.left=(tc.x+sxy[0]+q85.offsetWidth+off2_x)+"px";
		q113.top=(tc.y+sxy[1]+off2_y)+"px";
	}
	else {
		psub=q16("qm"+id.substring(0,id.lastIndexOf("_")));
		q113.left=(psub.offsetLeft+psub.offsetWidth+sxy[0]+off_x)+"px";
		q113.top=(psub.offsetTop+q16("qmitemst"+id).offsetTop+sxy[1]+off_y)+"px";
	}
};
function q103(){
	q87=q17(document.getElementById("imgbar"));
	dqmbar.style.left=(q87.x+off_x)+"px";
	dqmbar.style.top=(q87.y+off_y)+"px";q16("dqmbar."+q58);
}
;function q4(menu){
	q16("q16(qmitemhl"+menu.lasthl+")."+q59);
	q122(true);
	menu.lasthl=null;
};
function q5(menu,hl_id){
	q30(menu);
	try{
		if(item_q98!="" &&(sub_q98=="" || menu.filters[0].status!=2)){
			if(tval=window["qmitemhl"+hl_id].filters);{
				tval=tval[0];
				tval.apply();
				tval.play();
			}
		}
	}catch(e){}
	q16("q16(qmitemhl"+hl_id+")."+q58);
	q122(false,hl_id);q86=menu.q60;
	if(q86!=null && hl_id.indexOf(q86)<0){
		q16("q16(qmitemhl"+q86+")."+q59);q6(q86);
	}
	menu.q60=null;
	if(popIt(hl_id))
		menu.q60=hl_id;
	menu.lasthl=hl_id;q95=menu;
};
function detectSource(o){
	if(o.id==null || o.id==""){
		q64=o.parentElement;
		while(q64 !=null){
			if(q64.id!="")
				return q64.id;
			q64=q64.offsetParent;
		}
	return "";
	}
return o.id;
};
function dqm__handleMousemove(e){
	if(!q61)
		return;
	if((q81=detectSource(event.srcElement)).indexOf("menu")>-1){
		q111();
		q79(q81.substring(4));
	}
	else {
		if((q82!=null)&&(q81.indexOf("qm")<0)){
			q122(true); 
			q94=q82;
			if(q95!=null)
				q30(q95);
				q111();
				(q105[q94])? q93=setTimeout("q96()",dqm__mouse_off_delay):q96();
			return;
		}
		if(q81.indexOf("qmim")>-1){
			q111();
			q84=q81.substring(4);
			q122(false,q84);
			if(q105[q84])
				q89(q84);
			return;
		}
		q111();
		q84=q81.substring(8);
		if(q81.indexOf("qmitemst")>-1)
			q5(q16("qm"+q84.substring(0,q84.lastIndexOf("_"))),q84);
		else  
			if(q81.indexOf("qmitemhl")>-1){
				q90=q16('qm'+q84.substring(0,q84.lastIndexOf('_')));
				if(q90.q60!=null){
					q122(false,q84);q89(q84);
			}
		}
	}
};
function q89(index){
	if((q91=q16("qm"+index))!=null){
		q6(q91.q60);
		q91.q60=null;
	}
	q30(q91);
};
function q79(id){
	if(q82!=id){
		q122(false,id);
		if(q82!=null){
			if(window["dqm__subdesc"+q82+"_0"])
				q6(q82);
			q27(q82);
		}
		q16("q16(qmim"+id+")."+q58);
		popIt(id);
		q82=id;
		q16(window["dqm__showmenu_code"+q82]);
	}
};
function popIt(id){
	if(q15("dqm__subdesc"+id+"_0",null)!=null){
		t_obj=q16("qm"+id);
		if(dqm__sub_menu_effect.toLowerCase()!="none"){
		try{
			if(t_obj.filters){
				t_obj.filters[0].apply();
				t_obj.filters[0].play();
			}
		}catch(e){}
	}
	q16("t_obj."+q58);return true;}};function q96(){q6(q94);q27(q82);q82=null;};function q6(id){if(window["dqm__subdesc"+id+"_0"]){tm=q16("qm"+id);q16("tm."+q59);if(tm.lasthl!=null)q16("q16(qmitemhl"+tm.lasthl+")."+q59);if((ts=tm.q60)!=null){q16("q16(qmitemhl"+tm.q60+")."+q59);tm.q60=null;q6(ts);}}};function hideMenu(){};function showMenu(){};function q15(pname,rv,id){tindex="";if(id || id==0){tindex=id;rv=q16(pname);}if(window[pname+tindex])return q16(pname+tindex);else return rv;};function q16(id){return eval(id);};function q111(){if(q93!=null)clearTimeout(q93);};function dqm__handleResize(){q103();for(i=0;i<q18;i++){if(q105[i])q1(i,true);}for(i=0;i<q19.length;i++)q1(q19[i],false);};function q17(o){q70=new Object();q70.x=o.offsetLeft;q70.y=o.offsetTop;q64=o.offsetParent;while(q64 !=null){q70.y+=q64.offsetTop;q70.x+=q64.offsetLeft;q64=q64.offsetParent;}return q70;};function dqm__handleOnload(){if(!q61){q61=true;dqm__handleResize();if(q146 && !q29())q28();if(!q150){q64=document.getElementsByTagName("IFRAME");for(i=0;i<q64.length;i++)q64[i].attachEvent("onmouseover",dqm__handleMousemove);}q61=true;onload_finished=true;eval(window.dqm__onload_code);}};function q27(uid){eval("q16(qmim"+uid+")."+q59);eval(eval("window.dqm__hidemenu_code"+uid));}







