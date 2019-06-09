package Problem1.Shakes;

import Problem1.Ingredients.*;

import java.util.ArrayList;
import java.util.List;

public class ZeroShake implements Shake {
    private List<Ingredient> ingredientsList;

    public ZeroShake() {
        ingredientsList = new ArrayList<Ingredient>();
        ingredientsList.add(new Milk());
        ingredientsList.add(new Sweetener());
        ingredientsList.add(new VanillaFlavoring());
        ingredientsList.add(new SugarFreeJello());
    }

    @Override
    public String name() {
        return "Zero Shake";
    }

    @Override
    public List<Ingredient> ingredients() {
        return ingredientsList;
    }

    @Override
    public double basePrice() {
        return 240;
    }
}
