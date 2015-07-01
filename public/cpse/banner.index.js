indexSlides.parameterUpdate=function(){
	
	var winW=$(window).width();
	if(winW<1000)
		winW=1000;
	$('#slide-index').width(winW);
	$('#slide-index .slides').width(winW*(indexSlides.styleLength+1));
	indexSlides.obj.width(winW);

	var offset=(winW-1000)/2;
}

indexSlides.ini=function(){
	
	// clone obj
	indexSlides.css=[];
	
	
	for(var i=0; i<indexSlides.styleLength; i++){
		indexSlides.css[i]={}
		indexSlides.css[i].button={};
		indexSlides.css[i].button.left=0;
		indexSlides.css[i].button.top=0;
	}
	
	indexSlides.parameterUpdate();
	
	indexSlides.obj.eq(0).clone().appendTo('#slide-index .slides');
	
	$('#slide-index .control a').each(function(i){
		$(this).click(function(e){
			e.preventDefault();
			indexSlides.pause();
			indexSlides.goto(i);
			indexSlides.start();
		});
	});
	
	indexSlides.goto(0);
	indexSlides.start();

}

indexSlides.goto=function(i){

	if(indexSlides.animating || i==indexSlides.current)
		return false;

	indexSlides.animating=true;

	var j=i;
	if(i>=indexSlides.styleLength)
		j=0;

	indexSlides.clearStage(i);

	indexSlides.current=j;
	
	$('#slide-index .control a').removeClass('active').eq(j).addClass('active');
	$obj=$('#slide-index .slide').eq(i);
	
	var left=-i*indexSlides.obj.width();
	
	$('#slide-index .slides').animate({'margin-left':left},500,function(){
		$obj.animate(indexSlides.css[j].text,300,function(){
			$obj.animate(indexSlides.css[j].button,300, "swing",function(){
				
				if(i>=indexSlides.css.length){
					$obj=$('#slide-index .slide').eq(0);
					$('#slide-index .slides').css('margin-left','0px');
				}
				indexSlides.animating=false;
				indexSlides.reformat();
			});
		});
	});
	
}

indexSlides.start=function(){
	indexSlides.timer=setInterval(indexSlides.next,5000); //修改自动滚动间隔
}

indexSlides.pause=function(){
	if(indexSlides.timer)
		clearInterval(indexSlides.timer);
}

indexSlides.next=function(){
	var next=indexSlides.current+1;
	indexSlides.goto(next);
}

indexSlides.clearStage=function(i){
	if(indexSlides.current>-1){
		indexSlides.animating=true;
		var left=3000;
		if(i<indexSlides.current)
			left=-1000;
	}
}

indexSlides.reformat=function(){
	indexSlides.parameterUpdate();
	if(!indexSlides.animating){
		var left=-indexSlides.current*indexSlides.obj.width();
		$('#slide-index .slides').css({
			'margin-left':left
		});
		$obj=$('#slide-index .slide').eq(indexSlides.current);
		
	}
}

