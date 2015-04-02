require 'digress'

class TestLiterateBuilder
  attr_reader :value

  def initialize(value = 0)
    @value = value
  end

  def increment
    TestLiterateBuilder.new(value + 1)
  end
end

describe "digress in a pipeline" do
  it "never runs the block if given false" do
    expect(TestLiterateBuilder.new
      .digress(false) { |b| b.increment }
      .value
    ).to eq 0
  end

  it "runs the block if given a truthy value" do
    expect(TestLiterateBuilder.new
      .digress(true) { |b| b.increment }
      .value
    ).to eq 1
  end

  it "is easily chainable" do
    expect(TestLiterateBuilder.new
      .digress(true)              { |b| b.increment }
      .digress(1 == 1)            { |b| b.increment }
      .digress("not a nil value") { |b| b.increment }
      .value
    ).to eq 3
  end

  it "can use a proc as its bool value" do
    lt2 = ->(i) { i.value < 2 }

    expect(TestLiterateBuilder.new
      .digress(lt2) { |b| b.increment }
      .digress(lt2) { |b| b.increment }
      .digress(lt2) { |b| b.increment }
      .digress(lt2) { |b| b.increment }
      .digress(lt2) { |b| b.increment }
      .digress(lt2) { |b| b.increment }
      .value
    ).to eq 2
  end
end

