require 'spec/matchers'
require 'lib/item'

describe Item do

  context :new do
    it { should respond_to(:id, :id=) }
    it { should respond_to(:description, :description=) }
    it { should respond_to(:amount, :amount=) }
    it { should respond_to(:quantity, :quantity=) }
    it { should be_salable }
    it 'should default to quantity of 1' do
      subject.quantity.should == 1
    end
    specify { subject.amount.should be_instance_of(Float) }
  end

  context 'initialize with parameters' do
    subject { Item.new(:description => 'gizmo', :amount => 1.79, :quantity => 3) }
    specify { subject.description.should == 'gizmo' }
    specify { subject.amount.should == 1.79 }
    specify { subject.quantity == 3 }
  end

end

