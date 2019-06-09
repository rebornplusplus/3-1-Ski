package Problem2.Computers;

public class ComputerC implements Computer {
    private CPU cpu;
    private MMU mmu;

    public ComputerC() {
        cpu = new CPU("C");
        mmu = new MMU("C");
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
        return "C";
    }

    @Override
    public int getWidth() {
        return 550;
    }

    @Override
    public int getHeight() {
        return 430;
    }
}
