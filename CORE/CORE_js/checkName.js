function checkName(nickname) {
   
    var path = "^[a-zA-Z\ ]*$";
    var regv = new RegExp(path);
    if (regv.test(nickname))
      return true;
    return false;
	
  };