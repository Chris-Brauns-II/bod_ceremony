require_relative "../src/main"

context "when a log from yesterday" do
  subject { Main.new(io) }

  let(:task) { "task_a" }
  let(:input) { nil }
  let(:today_wip) { nil }
  let(:io) {
    Class.new do
      def initialize input
        @input = input
      end

      def output arg
      end

      def input
        @input
      end

      def input_wip
        prompt "foo"
      end

      def prompt o
        output o
        input
      end
    end.new(input)
  }

  context "when a yesterday WIP is nil" do
    let(:yesterday_wip) { nil }
    let(:input) { "foo" }

    it "asks for WIP" do
      expect(io).to receive(:output).with("foo")
      subject.yesterday_or_new_prompt(yesterday_wip, today_wip)
    end
  end

  context "when a yesterday WIP exists" do
    let(:yesterday_wip) { "task_a" }

    context "when the user is working on the same task" do
      let(:input) { "y" }

      it "shows Yesterdays WIP" do
        expect(io).to receive(:output).with("Yesterday you worked on:\n\s\stask_a\nIs that what you're doing today? (y/n) ")
        subject.yesterday_or_new_prompt(yesterday_wip, today_wip)
      end
    end

    context "when the user is working on a different task" do
      it "shows Today's new WIP" do
        allow(io).to receive(:input).and_return('n', 'blah')

        expect(io).to receive(:output).with("Yesterday you worked on:\n\s\s#{yesterday_wip}\nIs that what you're doing today? (y/n) ")
        expect(io).to receive(:output).with("foo")

        subject.yesterday_or_new_prompt(yesterday_wip, today_wip)
      end
    end

    context "when the user gives an invalid response" do
      it "raises an error" do
        allow(io).to receive(:input).and_return('foo', 'foo')

        expect { subject.yesterday_or_new_prompt(yesterday_wip, today_wip) }.to raise_error("Invalid Answer: foo")
      end
    end
  end
end
