require_relative "../../src/datastore/file_datastore.rb"

require 'json'
require 'pry'

context "" do
  subject { FileDatastore.new(date_picker, commit_directory) }
  let(:y_string) { "2019-01-01" }
  let(:t_string) { "2019-01-02" }
  let(:wip) { { "wip" => "wip" } }
  let(:date_picker) do
    Class.new do
      def initialize(y_string, t_string)
        @y_string = y_string
        @t_string = t_string
      end

      def yesterday_string
        @y_string
      end

      def today_string
        @t_string
      end
    end.new(y_string, t_string)
  end
  let(:commit_directory) { File.expand_path "." }

  it "exists" do
    expect(subject.class).to eq(FileDatastore)
  end

  describe ".yesterday_wip" do
    context "when a yesterday file does not exist" do
      it "returns nil" do
        expect(subject.yesterday_wip).to eq(nil)
      end
    end

    context "when a yesterday file exists" do
      let(:yesterday_file) { File.new("#{commit_directory}/#{y_string}.json", "w") }

      context "with a WIP" do
        before do
          yesterday_file.write(wip.to_json)
          yesterday_file.close
        end

        after do
          File.delete(yesterday_file)
        end

        it "returns the WIP" do
          expect(subject.yesterday_wip).to eq(wip["wip"])
        end
      end
    end
  end

  describe ".today" do
    let(:today) { Day.new(nil, nil) }

    let(:today_file) { File.new("#{commit_directory}/#{t_string}.json", "w") }

    before do
      today_file.write(today.to_json)
      today_file.close
    end

    after do
      File.delete(today_file) if today_file
    end

    it { expect(subject.today).to eq(today) }
  end

  describe ".today_wip" do
    context "when a today file does not exist" do
      it "returns nil" do
        expect(subject.today_wip).to eq(nil)
      end
    end

    context "when a today file exists" do
      let(:today_file) { File.new("#{commit_directory}/#{t_string}.json", "w") }

      before do
        today_file.write(wip.to_json)
        today_file.close
      end

      after do
        File.delete(today_file) if today_file
      end

      it "returns today_wip" do
        expect(subject.today_wip).to eq(wip["wip"])
      end
    end
  end

  describe ".commit_wip" do
    it "returns the commit wip" do
      expect(subject.commit_wip wip).to eq(wip)
    end

    it "commits the file" do
      subject.commit_wip wip
      if file = File.open("#{commit_directory}/#{t_string}.json")
        File.delete(file)
      else
        raise "nope"
      end
    end
  end

  describe ".today_notes" do
    context "when a today file exists" do
      let(:today_file) { File.new("#{commit_directory}/#{t_string}.json", "w") }
      let(:notes) { ["foo", "bar"] }

      before do
        today_file.write({ :notes => notes }.to_json )
        today_file.close
      end

      after do
        File.delete(today_file) if today_file
      end

      it "returns the notes for today" do
        expect(subject.today_notes).to eq(notes)
      end
    end
  end

  describe ".commit_note" do
    let(:file_name) { "#{commit_directory}/#{t_string}.json" }
    let(:today_file) { File.new(file_name, "w") }
    let(:note) { "foo" }

    context "with no previous notes" do
      before do
        today_file.write({ :notes => [] }.to_json )
        today_file.close
      end

      after do
        File.delete(today_file) if today_file
      end

      it "commits the note" do
        subject.commit_note note

        file = File.open(file_name).read
        expect(JSON.parse(file)["notes"]).to eq([note])
      end
    end

    context "with a previous note" do
      before do
        today_file.write({ :notes => [note] }.to_json )
        today_file.close
      end

      after do
        File.delete(today_file) if today_file
      end

      it "commits the note" do
        subject.commit_note note

        file = File.open(file_name).read
        expect(JSON.parse(file)["notes"]).to eq([note,note])
      end
    end
  end
end
