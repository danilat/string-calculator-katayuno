require "./string_calculator"

describe "String calculator" do
  context "empty string" do
    it "is zero" do
      result = StringCalculator.new.add("")

      expect(result).to eq 0
    end
  end
  context "whitespace string" do
    it "is zero" do
      result = StringCalculator.new.add(" ")

      expect(result).to eq 0
    end
  end
  context "one number" do
    it "return same value" do
      result = StringCalculator.new.add("4")

      expect(result).to eq 4
    end  
  end
  context "two numbers" do
    it "sum the values" do
      result = StringCalculator.new.add("2,3")

      expect(result).to(eq(5))
    end

    context "with two separators" do
      it "sum the values" do
        result = StringCalculator.new.add("1\n2,3")

        expect(result).to(eq(6))
      end
    end

    context "optional custom separator" do
      it "sum the values" do
        result = StringCalculator.new.add("//;\n1;2")

        expect(result).to(eq(3))
      end
    end
  end
end
