
function initMenu(id, obj){
//  var datalist = $("#" + id);
 // var data = eval("(" + obj + ")");
	var data = obj;
//  datalist.append("<div id='result' style='display:none'></div>");
  // var resultArea = datalist.find("#result");
  // datalist.append("<div class='menu' id='firstMenu' >" + "" + "</div>");
  var firstMenu = $("#firstMenu");
  firstMenu.html("");
  firstMenu.append("<div id='result' style='display:none' ></div>");
  var resultArea = firstMenu.find("#result");
  var secondMenu = $("#secondMenu"); 
  firstMenu.append("<ul></ul>");
  $.each(data, function (i, obj) {   // 循环第一级
	  
      $(firstMenu).find("ul").append("<li id='dl_" + i + "' name='" + i + "'><a>" + obj.product + "</a></li>");
        // if (datalist.find("div[class='sub-menu']").length <= 0) {
        //     datalist.append("<div class='sub-menu' id='secondMenu'></div>");
        // }
        //var secondMenu = datalist.find("#secondMenu");
          
       //$(firstMenu).find("ul li:first").addClass("sele").trigger("click");
  });
  $("#firstMenu ul li").click(function () {
      //判断是否是点击自己
      if($(this).hasClass("sele"))
    	  {
    	  //判断a标签状态
    	  debugger;
    	  	var temp = $(this).find("a").hasClass("sele");
    	  	if($(this).find("a").hasClass("sele"))
    	  		{
    	  			$(this).find("a").removeClass("sele");
    	  			$("#secondMenu dt a").removeClass("sele");
    	  		}
    	  	else{ 
    	  			$(this).find("a").addClass("sele");   
    	  			$("#secondMenu dt a").addClass("sele");
    	  		}
    	  }
      else
    	  {
    	  	  secondMenu.html("");  
              $("#firstMenu ul li").removeClass("sele");
              $("#firstMenu ul li a").removeClass("sele");	              
              $(this).addClass("sele");
              
              var index = $(this).attr("name");    
              
              //第二级
              $.each(data[index].children, function (j, item) {
                secondMenu.append("<dl id='dl_" + j + "'></dl>");
               
                var dtItem = "<dt id='dt_" + j + "'><a onClick='secondTypeSelect("+j+",this)'>" + item.type + "</a></dt>";
                	
                secondMenu.find("dl[id='dl_" + j + "']").append(dtItem);
                secondMenu.find("dl[id='dl_" + j + "']").append("<dd id='dd_" + j + "'></dd>");
                $("#dd_"+j).hide();
                //第三级
                $.each(data[index].children[j].children, function (m, dist) {
                	
                	if(dist.selected!=null&&dist.selected==1){
                        var threeMenu = "<a onClick='thirdTypeSelect("+dist.id+",this)' class='sele' href='javascript:void(0)' id='" +  dist.id  + "'>"
                        + dist.subProduct + ' - ' + dist.format + ' - ' + dist.material + "</a>";
                         resultArea.find("a[id='c_" + dist.id + "']").remove();
                         resultArea.append("<a href='#' id='c_" +dist.id + "'>" +dist.id + "</a>");                               
                         $("#dd_"+j).show();
                      }else{
                        var threeMenu = "<a onClick='thirdTypeSelect("+dist.id+",this)' href='javascript:void(0)' id='" +  dist.id  + "'>"
                        + dist.subProduct + ' - ' + dist.format + ' - ' + dist.material + "</a>";                                   
                    }
                  secondMenu.find("dl[id='dl_" + j + "'] dd[id='dd_" + j + "']").append(threeMenu);
                });
                
                
              });
              
    	  }
      
      //$(this).find("a").addClass("sele");
   
      
      var resultItems = resultArea.find("a");
        $.each(resultItems, function (n, ritem) {
            var rid = $(ritem).attr("id").substr(2, $(ritem).attr("id").length);
            secondMenu.find("a[id='" + rid + "']").addClass("sele");
        });
    }); 
  
}
 
 
 
  //监听 dd 下的产品 a 标签 (1级)
  $("dd").find("a").bind("click", function () { 
 	  var id = $(this).parent().attr("id").substr(3);
 	  //如果 a 标签  被选中  就 去掉选中 
 	  //判断 是否还有其它 a 标签 被选中 如果 没有  就把 dt 下的 选中状态去掉 
      if ($(this).hasClass("sele")){
        $(this).removeClass("sele");    
        var temp = $(this).parent().find(".sele");
        if(temp.length!= 0)
     	   {
     	   	return;
     	   }
        else if(temp.length==0)
     	   {
          
     	   $("#dt_"+id).find("a").removeClass("sele");
     	   }
      }else{
        $(this).addClass("sele");
        $("#dt_"+id).find("a").addClass("sele");                   
      }
   });
  
  


/*$("#firstMenu").find("li a").bind("click", function () {
	debugger;
    if ($(this).hasClass("sele")){
      $(this).removeClass("sele");
      //resultArea.find("a[id='c_" + $(this).attr("id") + "']").remove();
    }else{
      $(this).addClass("sele");
      //resultArea.append("<a href='#' id='c_" + $(this).attr("id") + "'>" + $.trim($(this).attr("id")) + "</a>");
    }            
 });*/
	// 列表项点击事件，选中则在结果容器中显示添加选中样式

	//监听 二级科目  显示三级科目
	function secondTypeSelect(id,obj)
	{
		var resultArea = $("#result");
	
		 $("#dd_"+id).show(); 	 
		 if ($(obj).hasClass("sele")){		 	 
		      $(obj).removeClass("sele");
		      var alist = $("#dd_"+id).find("a");
		     // $("#dd_"+id).find("a").removeClass("sele");
		      for (var i = 0; i < alist.length; i++) {
				var a = alist[i];
				$(a).removeClass("sele")
				var tempId = a.id;
				$("#c_" + tempId + "").remove();
			}
		      
		     // $("#c_" + id + "").remove(); 
		      
		    }else{		 	   
		      $(obj).addClass("sele");
		      $("#dd_"+id).find("a").addClass("sele");
		      var alist = $("#dd_"+id).find("a");
		      for (var i = 0; i < alist.length; i++) {
					var a = alist[i];
					var tempId = a.id;					
					$("#c_" + tempId + "").remove();
					resultArea.append("<a href='#' id='c_" +tempId + "'>" +tempId + "</a>");  
				}     
		    }
	}
	//监听 dd 下的产品 a 标签 
	function thirdTypeSelect(id,obj)
	{		
		var resultArea = $("#result");
	 if ($(obj).hasClass("sele")){		 	 
	      $(obj).removeClass("sele");
	      $("#dt_"+id).find("a").removeClass("sele");
	      $("#c_" + id + "").remove(); 
	    }else{		 	   
	      $(obj).addClass("sele");
	      resultArea.append("<a href='#' id='c_" +id + "'>" +id + "</a>");   
	    }
	}

	function setSelected(){
	  var resultArea = datalist.find("#result");
	
	}
	function getSelected(){
		var firstMenu = $("#firstMenu");
		var resultArea = firstMenu.find("#result");
	    var selectedItems = resultArea.find("a");
	    var results = "";
	    $.each(selectedItems, function (i, item) {
	        results += $.trim($(item).html()) + ",";
	    });
	    if (results.length > 0) {
	      results = results.substr(0, results.length - 1);
	    }
	    return results;
	}
