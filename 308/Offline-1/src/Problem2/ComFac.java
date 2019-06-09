package Problem2;

import Problem2.Computers.*;

public class ComFac {
    public static Computer getComputer(String name) {
        if(name.equalsIgnoreCase("A")) {
            return new ComputerA();
        }
        else if(name.equalsIgnoreCase("B")) {
            return new ComputerB();
        }
        else if(name.equalsIgnoreCase("C")) {
            return new ComputerC();
        }
        return null;
    }
}
