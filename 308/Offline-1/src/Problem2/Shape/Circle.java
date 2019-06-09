package Problem2.Shape;

public class Circle implements Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    public double getRadius() {
        return radius;
    }

    public void setRadius(double radius) {
        this.radius = radius;
    }

    @Override
    public String getName() {
        return "Circle";
    }

    @Override
    public double getSurfaceArea() {
        return Math.PI*radius*radius;
    }

    @Override
    public double getPerimeter() {
        return 2.0*Math.PI*radius;
    }

    @Override
    public boolean canBeInscribed(double width, double height) {
        double diameter = radius + radius;
        if(diameter > width || diameter > height) return false;
        return true;
    }
}
