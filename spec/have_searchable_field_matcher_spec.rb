require 'sunspot'
require 'sunspot_matchers'

describe SunspotMatchers::HaveSearchableField do
  subject do
    described_class.new(:field).tap do |matcher|
      matcher.matches? klass
    end
  end

  context "when a class has no searchable fields" do
    let(:klass) { NotALotGoingOn = Class.new }

    its(:failure_message_for_should) { should =~ /Sunspot was not configured/ }
  end

  context "when a class has an unexpected searchable field" do
    let(:klass) { IndexedWithWrongThings = Class.new }
    before do
      Sunspot.setup(klass) { text :parachute }
    end

    its(:failure_message_for_should) { should_not =~ /Sunspot was not configured/ }
  end
end
