package Problem1;

import java.util.ArrayList;
import java.util.List;

public class Order {
    private static int totalOrders = 0;
    private List<Milkshake> milkshakes;

    public Order() {
        ++totalOrders;
        milkshakes = new ArrayList<Milkshake>();
    }

    public void addMilkshake(Milkshake milkshake) {
        milkshakes.add(milkshake);
    }

    public double totalCost() {
        double total = 0;
        for(Milkshake milkshake : milkshakes) {
            total += milkshake.price();
        }
        return total;
    }

    public int totalShakes() {
        return milkshakes.size();
    }

    public void print() {
        System.out.println("Order #" + totalOrders);
        System.out.println("=====================================\n");
        int counter = 0;
        for(Milkshake milkshake : milkshakes) {
            System.out.println("Shake #" + (++counter));
            milkshake.print();
            System.out.println("");
        }
        System.out.println("=====================================");
        System.out.println("Total Cost: \t" + totalCost());
        System.out.println("\n");
    }
}
