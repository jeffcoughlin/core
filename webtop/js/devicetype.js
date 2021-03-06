$fc = window.$fc || {};

$fc.switchDeviceType = function(deviceType) {
	$fc.setDeviceTypeCookie(deviceType);
	window.location = window.location;
}

$fc.setDeviceTypeCookie = function(deviceType) {
	// set device type cookie to expire 30 days from now
	var date = new Date();
	date.setTime(date.getTime()+(30*24*60*60*1000));
	document.cookie = "FARCRYDEVICETYPE=" + deviceType + "; expires=" + date.toGMTString() + "; path=/;";
}

$fc.getDeviceType = function() {
	var re = new RegExp("FARCRYDEVICETYPE=([^;]+)","i");
	var value = re.exec(document.cookie);
	var result = value ? value[1] : "desktop";
	return result;
}


$j(function(){

	$j(".fc-switch-device-desktop").on("click", function(){
		$fc.switchDeviceType("desktop");
		return false;
	});
	$j(".fc-switch-device-mobile").on("click", function(){
		$fc.switchDeviceType("mobile");
		return false;
	});
	$j(".fc-switch-device-tablet").on("click", function(){
		$fc.switchDeviceType("tablet");
		return false;
	});
	
});