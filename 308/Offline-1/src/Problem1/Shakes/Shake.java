package Problem1.Shakes;

import Problem1.Ingredients.*;

import java.util.List;

public interface Shake {
    public String name();
    public List<Ingredient> ingredients();
    public double basePrice();
}
