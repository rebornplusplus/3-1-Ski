package Problem2.Shape;

public interface Shape {
    public String getName();
    public double getSurfaceArea();
    public double getPerimeter();
    public boolean canBeInscribed(double width, double height);
}