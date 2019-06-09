package Problem1;

import Problem1.Addons.Addon;
import Problem1.Ingredients.*;
import Problem1.Shakes.Shake;

import java.util.ArrayList;
import java.util.List;

public class Milkshake {
    private Shake shake;
    private boolean lactose;
    private List<Ingredient> ingredientsList;
    private List<Addon> addonsList;

    public static final double lactoseFreedomCost = 60;

    public Milkshake(String shakeType) {
        shake = ShakeIt.getShake(shakeType);
        lactose = true;
        addonsList = new ArrayList<Addon>();
        if(shake == null) ingredientsList = new ArrayList<Ingredient>();
        else ingredientsList = shake.ingredients();
    }

    public boolean isNull() {
        return shake == null;
    }

    public double price() {
        double total = 0;
        total += shake.basePrice();
        for(Addon addon : addonsList) {
            total += addon.price();
        }
        if(lactose == false) {
            total += lactoseFreedomCost;
        }
        return total;
    }

    public void makeLactoseFree() {
        lactose = false;
        for(int i=0; i<ingredientsList.size(); ++i) {
            Ingredient ingredient = ingredientsList.get(i);
            if(ingredient.name().equalsIgnoreCase("Milk")) {
                ingredientsList.set(i, new AlmondMilk());
            }
        }
    }

    public void print() {
        System.out.println(shake.name());
        System.out.print("Ingredients: ");
        for(Ingredient ingredient : ingredientsList) {
            System.out.print(ingredient.name() + "; ");
        }
        System.out.println("");
        if(!addonsList.isEmpty()) {
            for(Addon addon : addonsList) {
                System.out.println(addon.name() + " on top: \t" + addon.price());
            }
        }
        if(lactose == false) {
            System.out.println("Lactose Free: \t" + lactoseFreedomCost);
        }
        System.out.println("Base Price: \t" + shake.basePrice());
    }

    public void addOnTop(String addonType) {
        Addon addon = AddOnTop.getAddOn(addonType);
        if(addon != null) addonsList.add(addon);
    }
}