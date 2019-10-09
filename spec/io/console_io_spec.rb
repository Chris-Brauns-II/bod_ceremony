require_relative "../../src/io/console_io.rb"

context "" do
  subject { ConsoleIO.new }

  before do
    @orginal_std_out = $stdout

    $stdout = File.open(File::NULL, "w")
  end

  after do
    $stdout = @orginal_std_out
  end

  it "exists" do
    expect(subject.class).to eq(ConsoleIO)
  end

  it "returns the value after outputting" do
    expect(subject.output "blah").to eq("blah")
  end
end
