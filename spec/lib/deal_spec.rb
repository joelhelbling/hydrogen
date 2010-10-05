require 'spec'
lib = "#{File.dirname(__FILE__)}/../../lib"
require "#{lib}/deal"

describe Deal do
  context :new do
    it { should respond_to(:description, :description=) }
    it { should respond_to(:amount, :amount=) }
    it { should respond_to(:logic) }
    it { should respond_to(:calculate) }
    it { should_not be_salable }
    specify 'amount should be a float'  do
      subject.amount.should be_instance_of(Float)
    end
  end

  context 'initialize with parameters' do
    subject { Deal.new(:description => 'kungfu grip') }
    specify { subject.description.should == 'kungfu grip' }
  end

end
