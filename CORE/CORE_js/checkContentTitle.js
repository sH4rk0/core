function checkContentTitle(title) {
   
    var path = "^[a-zA-Z0-9\ \,\.\!\?\'\:\à\ò\è\é\ì\ù\;\°]*$";
    var regv = new RegExp(path);
    if (regv.test(title))
    return true;
    return false;
	
  };