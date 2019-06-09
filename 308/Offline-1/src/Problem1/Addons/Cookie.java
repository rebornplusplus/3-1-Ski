package Problem1.Addons;

public class Cookie implements Addon {
    @Override
    public String name() {
        return "Cookie";
    }

    @Override
    public double price() {
        return 40;
    }
}