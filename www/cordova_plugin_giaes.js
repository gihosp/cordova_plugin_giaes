
function cordova_plugin_giaes(){
}

cordova_plugin_giaes.prototype.encrypt = function (options, successCallback,errorCallback) {
  cordova.exec(successCallback, errorCallback, "cordova_plugin_giaes", "encrypt",[options]);
};
cordova_plugin_giaes.prototype.encryptnoencode = function (options, successCallback,errorCallback) {
  cordova.exec(successCallback, errorCallback, "cordova_plugin_giaes", "encryptnoencode",[options]);
};
cordova_plugin_giaes.prototype.decrypt = function (options, successCallback,errorCallback) {
  cordova.exec(successCallback, errorCallback, "cordova_plugin_giaes", "decrypt",[options]);
};

cordova_plugin_giaes.install = function () {
  if (!window.plugins) {
    window.plugins = {};
  }

  window.plugins.cordova_plugin_giaes = new cordova_plugin_giaes();
  return window.plugins.cordova_plugin_giaes;
};

cordova.addConstructor(cordova_plugin_giaes.install);
