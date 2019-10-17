require_relative "../../src/models/day"

context "" do
  subject { Day.new(wip) }
  let(:wip) { nil }

  it "exists" do
    expect(subject.class).to eq(Day)
  end

  describe ".wip" do
    it "works" do
      expect(subject.wip).to eq(wip)
    end

    context "with a non nil wip" do
      let(:wip) { "wip" }

      it "works" do
        expect(subject.wip).to eq(wip)
      end
    end
  end

  describe ".to_json" do
    context "with a nil wip" do
      it { expect(subject.to_json).to eq({"wip" => nil}.to_json) }
    end

    context "with a wip" do
      let(:wip) { "wip" }

      it { expect(subject.to_json).to eq({"wip" => wip}.to_json) }
    end
  end
end