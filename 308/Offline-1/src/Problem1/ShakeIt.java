package Problem1;

import Problem1.Shakes.*;

public class ShakeIt {
    public static Shake getShake(String shakeType) {
        if(shakeType == null) {
            return null;
        }
        if(shakeType.equalsIgnoreCase("Chocolate Shake")) {
            return new ChocolateShake();
        }
        if(shakeType.equalsIgnoreCase("Coffee Shake")) {
            return new CoffeeShake();
        }
        if(shakeType.equalsIgnoreCase("Strawberry Shake")) {
            return new StrawberryShake();
        }
        if(shakeType.equalsIgnoreCase("Vanilla Shake")) {
            return new VanillaShake();
        }
        if(shakeType.equalsIgnoreCase("Zero Shake")) {
            return new ZeroShake();
        }
        return null;
    }
}
