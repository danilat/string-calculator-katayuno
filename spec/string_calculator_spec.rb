require "./string_calculator"

describe StringCalculator do
  subject(:string_calculator) { described_class.new }

  context "empty string" do
    it "is zero" do
      result = string_calculator.add("")

      expect(result).to eq 0
    end
  end
  context "whitespace string" do
    it "is zero" do
      result = string_calculator.add(" ")

      expect(result).to eq 0
    end
  end
  context "one number" do
    it "return same value" do
      result = string_calculator.add("4")

      expect(result).to eq 4
    end  
  end
  context "two or more numbers" do
    context "with the comma default separator" do
      it "sum the values" do
        result = string_calculator.add("2,3")

        expect(result).to eq 5
      end
    end

    context "with the two default separators" do
      it "sum the values" do
        result = string_calculator.add("1\n2,3\n1")

        expect(result).to eq 7
      end
    end

    context "with some negative values" do
      it "raise an error" do
        expect {
          string_calculator.add("2,-3")
        }.to raise_error NegativesNotAllowed
      end
    end

    context "with some bigger value than 1000" do
      it "are ignored in the sum" do
        result = string_calculator.add("1,1000,1001")
        
        expect(result).to eq 1001
      end
    end

    context "with a custom one character separator" do
      it "sum the values" do
        result = string_calculator.add("//;\n1;2")

        expect(result).to eq 3
      end
    end

    context "with a custom multiple characters separator" do
      it "sum the values" do
        result = string_calculator.add("//[***]\n1***2***3")

        expect(result).to eq 6
      end
    end
  end
end
