require_relative "../../src/models/day"

context "" do
  subject { Day.new(wip, notes) }
  let(:wip) { nil }
  let(:notes) { nil }

  describe ".add_note" do
    let(:note) { "foo" }

    it { expect(Day.add_note(Day.new(wip, notes), note).notes).to eq(Day.new(nil, ["foo"]).notes) }
  end

  describe ".notes" do
    it { expect(subject.notes).to eq([]) }

    context "with notes" do
      let(:notes) { ["foo"] }

      it { expect(subject.notes).to eq(notes) }
    end
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

  describe ".from_json" do
    let(:json) do
      {
        "wip" => "foo",
        "notes" => ["foo"]
      }
    end

    it { expect(Day.from_json json).to eq(Day.new("foo", ["foo"])) }
  end

  describe ".to_json" do
    context "with a nil wip" do
      it { expect(subject.to_json).to eq({"wip" => nil, "notes" => []}.to_json) }
    end

    context "with a wip" do
      let(:wip) { "wip" }

      it { expect(subject.to_json).to eq({"wip" => wip, "notes" => []}.to_json) }
    end
  end

  describe ".to_s" do
    # it { expect(Day.new("foo", ["bar"]).to_s).to eq({}) }
  end

  describe "==" do
    it { expect(Day.new(nil,nil)).to eq(Day.new(nil, nil)) }
  end
end
