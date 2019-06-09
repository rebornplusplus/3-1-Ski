package Problem2.Shape;

public class Triangle implements Shape {
    private double side1, side2, side3;

    public Triangle(double side1, double side2, double side3) {
        this.side1 = side1;
        this.side2 = side2;
        this.side3 = side3;
    }

    public double getSide1() {
        return side1;
    }

    public void setSide1(double side1) {
        this.side1 = side1;
    }

    public double getSide2() {
        return side2;
    }

    public void setSide2(double side2) {
        this.side2 = side2;
    }

    public double getSide3() {
        return side3;
    }

    public void setSide3(double side3) {
        this.side3 = side3;
    }

    @Override
    public String getName() {
        return "Triangle";
    }

    @Override
    public double getSurfaceArea() {
        double s = (side1 + side2 + side3) / 2.0;
        double area = Math.sqrt(s * (s-side1) * (s-side2) * (s-side3));
        return area;
    }

    @Override
    public double getPerimeter() {
        return (side1+side2+side3);
    }

    @Override
    public boolean canBeInscribed(double width, double height) {
        // This is a primitive test though
        // doesn't catch all the triangles
        // think tricky cases

        if(width < height) {
            // Java simply sucks!
            double temp = width;
            width = height;
            height = temp;
        }

        double longestSide = side1;
        if(longestSide > side2) longestSide = side2;
        if(longestSide > side3) longestSide = side3;
        double triangleHeight = 2.0 * getSurfaceArea() / longestSide;

        if(longestSide > width || triangleHeight > height) return false;
        return true;
    }
}