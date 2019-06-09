package Problem1;

import Problem1.Addons.*;

public class AddOnTop {
    public static Addon getAddOn(String addonType) {
        if(addonType == null) {
            return null;
        }
        if(addonType.equalsIgnoreCase("Candy")) {
            return new Candy();
        }
        if(addonType.equalsIgnoreCase("Cookie")) {
            return new Cookie();
        }
        return null;
    }
}
