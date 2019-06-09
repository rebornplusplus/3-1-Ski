package Problem1.Shakes;

import Problem1.Ingredients.*;

import java.util.ArrayList;
import java.util.List;

public class VanillaShake implements Shake {
    private List<Ingredient> ingredientsList;

    public VanillaShake() {
        ingredientsList = new ArrayList<Ingredient>();
        ingredientsList.add(new Milk());
        ingredientsList.add(new Sugar());
        ingredientsList.add(new VanillaFlavoring());
        ingredientsList.add(new Jello());
    }

    @Override
    public String name() {
        return "Vanilla Shake";
    }

    @Override
    public List<Ingredient> ingredients() {
        return ingredientsList;
    }

    @Override
    public double basePrice() {
        return 190;
    }
}
