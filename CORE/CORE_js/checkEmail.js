function checkEmail(email) {
  if (window.RegExp) {
    var notValid = "(@.*@)|(\\.\\.)|(@\\.)|(\\.@)|(^\\.)";
    var valid = "^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    var regnv = new RegExp(notValid);
    var regv = new RegExp(valid);
    if (!regnv.test(email) && regv.test(email))
      return true;
    return false;
	}
  else {
    if(email.indexOf("@") >= 0)
      return true;
    return false;
  	}
  };