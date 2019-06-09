package Problem2;

import Problem2.Computers.*;
import Problem2.Shape.*;

import java.util.Scanner;

public class Tester {
    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(System.in);

        while(true) {
            System.out.println("Enter Computer Name: [A/B/C]");
            String computerChoice = scanner.nextLine();
            if(computerChoice.equalsIgnoreCase("QUIT")) break;

            Computer computer = ComFac.getComputer(computerChoice);
            if(computer == null) {
                System.out.println("Sorry dear! No such computer right now.");
                System.out.println("Try again...");
                continue;
            }

            System.out.println("Enter shape name: [Circle/Square/Rectangle/Triangle]");
            String shapeType = scanner.nextLine();

            if(shapeType == null) {
                System.out.println("Null string entered!");
                continue;
            }
            else if(shapeType.equalsIgnoreCase("Circle")) {
                System.out.print("Enter radius: ");
                double radius = scanner.nextDouble();
                scanner.nextLine();

                Circle circle = new Circle(radius);
                CentralSystem.display(computer, circle);
            }
            else if(shapeType.equalsIgnoreCase("Square")) {
                System.out.print("Enter side: ");
                double side = scanner.nextDouble();
                scanner.nextLine();

                Square square = new Square(side);
                CentralSystem.display(computer, square);
            }
            else if(shapeType.equalsIgnoreCase("Rectangle")) {
                System.out.print("Enter width: ");
                double width = scanner.nextDouble();
                scanner.nextLine();
                System.out.print("Enter height: ");
                double height = scanner.nextDouble();
                scanner.nextLine();

                Rectangle rectangle = new Rectangle(width, height);
                CentralSystem.display(computer, rectangle);
            }
            else if(shapeType.equalsIgnoreCase("Triangle")) {
                System.out.print("Enter side1: ");
                double side1 = scanner.nextDouble();
                scanner.nextLine();
                System.out.print("Enter side2: ");
                double side2 = scanner.nextDouble();
                scanner.nextLine();
                System.out.print("Enter side3: ");
                double side3 = scanner.nextDouble();
                scanner.nextLine();

                Triangle triangle = new Triangle(side1, side2, side3);
                CentralSystem.display(computer, triangle);
            }
            else {
                System.out.println("Unrecognized shape!");
                continue;
            }
        }
    }
}
