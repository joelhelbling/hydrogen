require "spec"
lib = "#{File.dirname(__FILE__)}/../../lib"
require "#{lib}/transaction"
require "#{lib}/item"
require "#{lib}/deal"

describe Transaction do
  it { should respond_to(:add) }
  it { should respond_to(:total) }
  it { should respond_to(:line_items) }
  it { should respond_to(:sales_tax, :sales_tax=) }
  context 'adding items' do
    subject { Transaction.new }
    specify { subject.line_items.size.should == 0 }
    it 'should report its line items' do
      subject.add Item.new(:description => 'foobar', :amount => 1.00)
      subject.line_items.size.should == 1
      subject.add Deal.new(:description => 'no deal')
      subject.line_items.size.should == 2
    end
    it 'should report its total' do
      subject.add Item.new(:description => 'fog', :amount => 2.95)
      subject.line_items[0].amount.should == 2.95
      subject.total.should == 2.95
      dealio = Deal.new(:description => '$1.00 off fog')
      dealio.logic do |items|
        items.detect{|i| i.description == 'fog' } && -1.00
      end
      subject.add dealio
      subject.total.should == 1.95
    end
    it 'should adjust total for quantity' do
      subject.add Item.new(:description => 'dog', :amount => 2.12)
      subject.add Item.new(:description => 'dog', :amount => 2.12)
      subject.total.should == 4.24
    end
  end
end