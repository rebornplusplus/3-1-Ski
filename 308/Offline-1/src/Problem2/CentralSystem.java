package Problem2;

import Problem2.Computers.*;
import Problem2.Shape.*;

public class CentralSystem {
    public static void display(Computer computer, Shape shape) {
        System.out.println("");
        System.out.println("Trying to display " + shape.getName() + " on Computer " + computer.getName());
        if(shape.canBeInscribed(computer.getWidth(), computer.getHeight())) {
            System.out.println("Successfully printed. ^_^");
        }
        else {
            System.out.println("The shape is too large :'(");
        }
        System.out.println("Computer resolution: " + computer.getWidth() + "x" + computer.getHeight());
        System.out.println(shape.getName() + " surface area: " + shape.getSurfaceArea());
        System.out.println(shape.getName() + " perimeter: " + shape.getPerimeter());
        System.out.println("");
    }
}
