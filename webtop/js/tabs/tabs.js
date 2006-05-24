function initTabNavigation(tab,currentclass,disabledclass){
	var i = 0;			
	tablinks = $$("#" + tab + " .links li a")
	tablinks.each(function(tablink) {	
		i++;
		tablink.setAttribute("onclick", "loadTabNavigation('" + tab + "'," + i + ",'" + currentclass + "','" + disabledclass + "');");
		tablink.setAttribute("href", "#");	

	});

	var i = 0;			
	tablistitems = $$("#" + tab + " .links li")
	tablistitems.each(function(tablistitem) {	
		i++;
		if (tablistitem.getAttribute("class") == currentclass) {					
			loadTabNavigation(tab,i,currentclass,disabledclass);
		}			
	});
				
	
}
function loadTabNavigation (tab,selection,currentclass,disabledclass){
	var i = 0;
	panels = $$("#" + tab + " .panel");			
	panels.each(function(panel) {	
		i++;
		if (i == selection) {
			panel.show();
		}
		else{
			panel.hide();					
		}					
	});
	
	
	var i = 0;			
	tablistitems = $$("#" + tab + " .links li")
	tablistitems.each(function(tablistitem) {	
		i++;
		if (i == selection) {
			tablistitem.setAttribute("class", currentclass);
		}
		else{
			tablistitem.setAttribute("class", disabledclass);
		}				
	});
	
	return false;
}