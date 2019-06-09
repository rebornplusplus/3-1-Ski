package Problem1.Shakes;

import Problem1.Ingredients.*;

import java.util.ArrayList;
import java.util.List;

public class ChocolateShake implements Shake {
    private List<Ingredient> ingredientsList;

    public ChocolateShake() {
        ingredientsList = new ArrayList<Ingredient>();
        ingredientsList.add(new Milk());
        ingredientsList.add(new Sugar());
        ingredientsList.add(new ChocolateSyrup());
        ingredientsList.add(new ChocolateIcecream());
    }

    @Override
    public String name() {
        return "Chocolate Shake";
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
