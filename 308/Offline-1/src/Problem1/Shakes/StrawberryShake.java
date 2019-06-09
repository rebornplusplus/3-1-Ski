package Problem1.Shakes;

import Problem1.Ingredients.*;

import java.util.ArrayList;
import java.util.List;

public class StrawberryShake implements Shake {
    private List<Ingredient> ingredientsList;

    public StrawberryShake() {
        ingredientsList = new ArrayList<Ingredient>();
        ingredientsList.add(new Milk());
        ingredientsList.add(new Sugar());
        ingredientsList.add(new StrawberrySyrup());
        ingredientsList.add(new StrawberryIcecream());
    }

    @Override
    public String name() {
        return "Strawberry Shake";
    }

    @Override
    public List<Ingredient> ingredients() {
        return ingredientsList;
    }

    @Override
    public double basePrice() {
        return 200;
    }
}
