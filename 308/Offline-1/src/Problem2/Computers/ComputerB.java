package Problem2.Computers;

public class ComputerB implements Computer {
    private CPU cpu;
    private MMU mmu;

    public ComputerB() {
        cpu = new CPU("B");
        mmu = new MMU("B");
    }

    @Override
    public CPU getCPU() {
        return cpu;
    }

    @Override
    public MMU getMMU() {
        return mmu;
    }

    @Override
    public String getName() {
        return "B";
    }

    @Override
    public int getWidth() {
        return 350;
    }

    @Override
    public int getHeight() {
        return 250;
    }
}
