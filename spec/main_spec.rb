require_relative "../src/main"

context "when a log from yesterday" do 
  subject { Main.new(datastore, io) }

  let(:task) { "task_a" }
  let(:yesterday_wip) { nil }
  let(:datastore) do
    Class.new do
      def initialize yesterday_wip
        @yesterday_wip = yesterday_wip
      end

      def yesterday_wip
        @yesterday_wip
      end

      def commit_wip wip
        wip
      end
    end.new(yesterday_wip)
  end 
  let(:input) { "foo" }
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
    end.new(input)
  }

  context "when a yesterday WIP does not exist" do 
    it "asks for WIP" do 
      expect(io).to receive(:output).with("What is your WIP?:")
      expect(io).to receive(:output).with("You are working on:\n\s\s#{input}")
      subject.run
    end
  end

  context "when a yesterday WIP exists" do 
    let(:yesterday_wip) { "task_a" }

    context "when the user is working on the same task" do
      let(:input) { "y" }

      it "shows Yesterdays WIP" do 
        expect(io).to receive(:output).with("Yesterday you worked on:\n\s\stask_a\nIs that what you're doing today? (y/n) ")
        expect(io).to receive(:output).with("You are working on:\n\s\s#{yesterday_wip}")
        subject.run
      end
    end

    context "when the user is working on a different task" do 
      it "shows Today's new WIP" do 
        allow(io).to receive(:input).and_return('n', 'blah')

        expect(io).to receive(:output).with("Yesterday you worked on:\n\s\s#{yesterday_wip}\nIs that what you're doing today? (y/n) ")
        expect(io).to receive(:output).with("What is your WIP?:")
        expect(io).to receive(:output).with("You are working on:\n\s\sblah")

        subject.run
      end
    end
  end
end