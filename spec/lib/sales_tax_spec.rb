require "spec"
lib = "#{File.dirname(__FILE__)}/../../lib"
require "#{lib}/sales_tax"
require "#{lib}/item"

describe SalesTax do
  it { should respond_to(:tax_rate, :tax_rate=) }
  it { should respond_to(:amount)                   }
  it { should respond_to(:calculate)                }
  it { should respond_to(:logic)                    }
  specify { subject.tax_rate.should == 0.00       }
  it 'should calculate the sales tax amount' do
    items = [
      Item.new(:description => 'foogah', :amount => 10.00),
      Item.new(:description => 'foobah', :amount => 20.00)]
    subject.tax_rate = 0.10
    subject.calculate items
    subject.amount.should == 3.00
  end
  it 'should accept a tax rate on initialization' do
    lambda { tax = SalesTax.new(0.075) }.should_not raise_error
  end
end