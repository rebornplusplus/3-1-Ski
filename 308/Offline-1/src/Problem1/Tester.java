package Problem1;

import Problem1.Addons.Addon;
import Problem1.Addons.Candy;
import Problem1.Addons.Cookie;
import Problem1.Shakes.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Tester {
    private static List<Shake> shakesOnDisplay;
    private static List<Addon> addonsForDisplay;

    static {
        shakesOnDisplay = new ArrayList<Shake>();
        shakesOnDisplay.add(new ChocolateShake());
        shakesOnDisplay.add(new CoffeeShake());
        shakesOnDisplay.add(new StrawberryShake());
        shakesOnDisplay.add(new VanillaShake());
        shakesOnDisplay.add(new ZeroShake());

        addonsForDisplay = new ArrayList<Addon>();
        addonsForDisplay.add(new Cookie());
        addonsForDisplay.add(new Candy());
    }

    private static void displayShakes() {
        System.out.println("Available Shakes ( Type the names to order )");
        for(Shake shake : shakesOnDisplay) {
            System.out.println(shake.name() + " \tTk " + shake.basePrice());
        }
    }

    private static void displayAddons() {
        for(Addon addon : addonsForDisplay) {
            System.out.println(addon.name() + " for \tTk " + addon.price());
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("ShakeShak's Amazing Shakes");
        System.out.println("==========================");
        System.out.println("M - See Menu");
        System.out.println("O - Start Order");
        System.out.println("E - End Order");
        System.out.println("Q - Leave Shop");

        while(true) {
            String newLine = scanner.nextLine();
            if(newLine.equalsIgnoreCase("Q")) break;
            else if(newLine.equalsIgnoreCase("M")) {
                displayShakes();
                continue;
            }
            else if(!newLine.equalsIgnoreCase("O")) continue;

            Order newOrder = new Order();
            while(true) {
                String line = scanner.nextLine();
                if(line.isEmpty()) continue;
                else if(line.equalsIgnoreCase("O")) {
                    System.out.println("Finish your current order.");
                    continue;
                }
                else if(line.equalsIgnoreCase("E")) {
                    if(newOrder.totalShakes() == 0) {
                        System.out.println("You have to at least order something!");
                    }
                    else break;
                }
                else {
                    Milkshake milkshake = new Milkshake(line);
                    if(milkshake.isNull()) {
                        System.out.println("No shake like that!");
                        continue;
                    }
                    else {
                        System.out.println("Make it lactose free at Tk 60? [Y/n]");
                        String confirmString = scanner.nextLine();
                        if(confirmString.equalsIgnoreCase("Y")) {
                            milkshake.makeLactoseFree();
                        }
                        while(true) {
                            System.out.println("Add (another) Cookie/Candy on top? [Y/n]");
                            confirmString = scanner.nextLine();
                            if (confirmString.equalsIgnoreCase("Y")) {
                                displayAddons();
                                String addonString = scanner.nextLine();
                                milkshake.addOnTop(addonString);
                            }
                            else break;
                        }
                    }
                    newOrder.addMilkshake(milkshake);
                }
            }
            newOrder.print();
        }
    }
}
