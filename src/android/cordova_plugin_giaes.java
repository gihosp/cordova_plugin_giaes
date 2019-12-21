package cordova_plugin_giaes;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class cordova_plugin_giaes extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("encrypt")) {
            String message = args.getString(0);
            callbackContext.success(AES.encrypt(message));
            return true;
        }else if (action.equals("encryptnoencode")) {
            String message = args.getString(0);
            callbackContext.success(AES.encryptnoencode(message));
            return true;
        }else if (action.equals("decrypt")) {
            String message = args.getString(0);
            callbackContext.success(AES.decrypt(message));
            return true;
        }
        return false;
    }
}
