// Reuses the same "calendar" object for all date-type fields on the page
function jscal_selected(cal, date) {
  cal.sel.value = date;
  if (cal.dateClicked)
    cal.callCloseHandler();
}
function jscal_close(cal) {
  cal.hide();
  _dynarch_popupCalendar = null;
}
function showCalendar(id, format) {
  var el = document.getElementById(id);
  if (_dynarch_popupCalendar != null) {
    _dynarch_popupCalendar.hide();
  } else {
    var cal = new Calendar(1, null, jscal_selected, jscal_close);
    cal.showsTime = false;
    cal.showsOtherMonths = true;
    _dynarch_popupCalendar = cal;
    cal.setRange(1900, 2070);
    cal.create();
  }
  _dynarch_popupCalendar.setDateFormat(format);
  _dynarch_popupCalendar.parseDate(el.value);
  _dynarch_popupCalendar.sel = el;
  _dynarch_popupCalendar.showAtElement(el, "Br");
  return false;
}
