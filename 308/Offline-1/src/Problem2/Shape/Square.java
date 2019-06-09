package Problem2.Shape;

public class Square implements Shape {
    private double side;

    public Square(double side) {
        this.side = side;
    }

    public double getSide() {
        return side;
    }

    public void setSide(double side) {
        this.side = side;
    }

    @Override
    public String getName() {
        return "Square";
    }

    @Override
    public double getSurfaceArea() {
        return side*side;
    }

    @Override
    public double getPerimeter() {
        return side*4.0;
    }

    @Override
    public boolean canBeInscribed(double width, double height) {
        if(side > width || side > height) return false;
        return true;
    }
}