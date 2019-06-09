package Problem2.Computers;

public class ComputerA implements Computer {
    private CPU cpu;
    private MMU mmu;

    public ComputerA() {
        cpu = new CPU("A");
        mmu = new MMU("A");
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
        return "A";
    }

    @Override
    public int getWidth() {
        return 200;
    }

    @Override
    public int getHeight() {
        return 200;
    }
}
