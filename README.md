# Digress

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'digress'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install digress

## Usage

```ruby
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
```

## Contributing

1. Fork it ( https://github.com/cschneid/digress/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
