/**
 * 
 * KeyDown jQuery
 * Version 0.1 (201210)
 *
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * 
 * @author RafMas 
 * @since 2012
 *
 **/

//Pressione tasti
$(document).keydown(function(e){

	function arrow(toward){ //duplicata da interface_control.js temporaneamente
		var d_page, l_page;
		if ($("#imgd_link").attr("class") !== "current_mode"){
			if (toward === "left"){
				if($('.main_pp_select .option_container .option.selected').prev().attr("id").substr(6)){
					window.location.hash = $('.main_pp_select .option_container .option.selected').prev().attr("id").substr(6);
				}
			}
			if (toward === "right"){
				if($('.main_pp_select .option_container .option.selected').next().attr("id").substr(6)){
					window.location.hash = $('.main_pp_select .option_container .option.selected').next().attr("id").substr(6);
				}
			}
		} else {
			if (toward === "left"){
				if($('.main_dd_select .option_container .option.selected').prev().attr("id").substr(6)){
					d_page = $('.main_dd_select .option_container .option.selected').prev().attr("id").substr(6);
					l_page = $('.main_dd_select .option_container .option.selected').prev().text();
					$(".main_dd_select .label_selected").text(l_page).attr("id_value", d_page).trigger("change");
					//window.location.hash = $('.main_dd_select .option_container .option.selected').prev().attr("id").substr(6);
				}
			}
			if (toward === "right"){
				if($('.main_dd_select .option_container .option.selected').next().attr("id").substr(6)){
					d_page = $('.main_dd_select .option_container .option.selected').next().attr("id").substr(6);
					l_page = $('.main_dd_select .option_container .option.selected').next().text();
					$(".main_dd_select .label_selected").text(l_page).attr("id_value", d_page).trigger("change");
					//window.location.hash = $('.main_dd_select .option_container .option.selected').next().attr("id").substr(6);
				}
			}
		}
	}


	if (e.keyCode == 37) { //left
		arrow("left");
		return false;
	}				
	if (e.keyCode == 39) { //right
		arrow("right");
		return false;
	}		
	if (e.keyCode == 27) { //escape
		if ($('#header_collapse').hasClass('fa-caret-down'))
			$("#header_collapse").trigger('click');
		if ($("#main_left_frame").hasClass("full"))
			$("#closeFullScreenLeft").trigger('click');
		if ($("#main_right_frame").hasClass("full"))
			$("#closeFullScreenRight").trigger('click');
		keycount=0;
		return false;
	}	
	
	/*if (e.keyCode == 189) { // - 109 .. _ 189
		if(keycount==1){
			if($("#main_left_menu-openlink").css('display')=="none"){
				$("#main_left_frame header").hide('slide', {direction: 'left'}, 1000);
				$("#main_left_menu-openlink").toggle();
				$("#main_left_menu-closelink").toggle();
			keycount=0;
			}
			
		}
		if(keycount==0){
			if($("#main_right_menu-openlink").css('display')=="none"){
				$("#main_right_frame header").hide('slide', {direction: 'right'}, 1000);
				$("#main_right_menu-openlink").toggle();
				$("#main_right_menu-closelink").toggle();
			keycount=1
			}
			
		}
		return false;
	}			
	if (e.keyCode == 187) { // + 107 ... } 187
		if(keycount==0){
			if($("#main_left_menu-openlink").css('display')!="none"){
				$("#main_left_frame header").show('slide', {direction: 'left'}, 1000);
				$("#main_left_menu-openlink").toggle();
				$("#main_left_menu-closelink").toggle();
				//keycount=1;
			} 
			keycount=1;
		}
		else{
			if($("#main_right_menu-openlink").css('display')!="none"){
				$("#main_right_frame header").show('slide', {direction: 'right'}, 1000);
				$("#main_right_menu-openlink").toggle();
				$("#main_right_menu-closelink").toggle();						
			}
		keycount=0;
		return false;
		}
	}*/

	/*if (e.keyCode == 70) { // f
		if(!fulltogg){
			if($("#main_left_menu-openlink").css('display')=="none"){
				$("#main_left_frame header").css({
					display: 'none',
				});
				//$("#main_left_frame header").hide('slide', {direction: 'left'}, 1000);
				$("#main_left_menu-openlink").toggle();
				$("#main_left_menu-closelink").toggle();
			}
			if($("#main_right_menu-openlink").css('display')=="none"){
				$("#main_right_frame header").css({
					display: 'none',
				});
				//$("#main_right_frame header").hide('slide', {direction: 'right'}, 1000);
				$("#main_right_menu-openlink").toggle();
				$("#main_right_menu-closelink").toggle();
			}			
			
			$("#main_right_frame").appendTo($("#global_wrapper"));
			$("#main_right_frame").css({
				position: 'absolute',
				top: '2px',
				left: '2px',
				margin: 'auto 0 auto 0',
				width: '99.5%',
				height: '99%',
			});
			//$("#main_right_menu").css({
				//'left': '-80px',
				//'position': 'relative',
				//'margin-top': '38px',
				//'height': '89px',
				//'border': '2px solid white',
				//display: 'none',
			//});
			fulltogg=true;
		} else{
			$("#main_right_frame").prependTo($("#central_wrapper"));
			$("#main_right_frame").css({
				border: '2px solid #786e64',
				position: 'relative',
				width: '49.8%',
				height: '100%',
				'float': 'right',						
			});
			fulltogg=false;
		}
		
		return false;

	}*/
});