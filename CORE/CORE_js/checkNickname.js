function checkNickname(nickname) {
   
    var path = "^[a-zA-Z0-9]*$";
    var regv = new RegExp(path);
    if (regv.test(nickname))
      return true;
    return false;
	
  };