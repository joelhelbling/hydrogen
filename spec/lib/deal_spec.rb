require 'lib/deal'

describe Deal do
  context :new do
    it { should respond_to(:description, :description=) }
    it { should respond_to(:amount, :amount=) }
    it { should respond_to(:logic) }
    it { should respond_to(:run) }
    it { should respond_to(:quantity) }
    specify 'amount should be a float'  do
      subject.amount.should be_instance_of(Float)
    end
    specify 'quantity should always be 1' do
      subject.quantity.should == 1
    end

  end

  context 'initialize with parameters' do
    subject { Deal.new(:description => 'kungfu grip') }
    specify { subject.description.should == 'kungfu grip' }
  end

end
