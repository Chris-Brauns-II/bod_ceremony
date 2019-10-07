require_relative "../../src/datastore/file_datastore.rb"

context "" do
  subject { FileDatastore.new date_picker }
  let(:y_string) { "2019-01-01" }
  let(:t_string) { "2019-01-02" }
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
      let(:yesterday_file) { File.new("./#{y_string}", "w") }

      context "with a WIP" do 
        let(:wip) { "TODO" }

        before do
          yesterday_file.write(wip) 
          yesterday_file.close
        end

        after do 
          File.delete(yesterday_file)
        end
        
        it "returns the WIP" do
          expect(subject.yesterday_wip).to eq(wip)
        end
      end
    end
  end

  describe ".commit_wip" do 
    it "returns the commit wip" do 
      expect(subject.commit_wip "foo").to eq("foo")
    end

    it "commits the file" do
      subject.commit_wip "foo"
      if file = File.open("./#{t_string}")
        File.delete(file)
      else
        raise "nope"
      end
    end
  end 
end