package Problem1.Addons;

public class Candy implements Addon {
    @Override
    public String name() {
        return "Candy";
    }

    @Override
    public double price() {
        return 50;
    }
}
