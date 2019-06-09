package Problem1.Shakes;

import Problem1.Ingredients.*;

import java.util.ArrayList;
import java.util.List;

public class CoffeeShake implements Shake {
    private List<Ingredient> ingredientsList;

    public CoffeeShake() {
        ingredientsList = new ArrayList<Ingredient>();
        ingredientsList.add(new Milk());
        ingredientsList.add(new Sugar());
        ingredientsList.add(new Coffee());
        ingredientsList.add(new Jello());
    }

    @Override
    public String name() {
        return "Coffee Shake";
    }

    @Override
    public List<Ingredient> ingredients() {
        return ingredientsList;
    }

    @Override
    public double basePrice() {
        return 230;
    }
}
