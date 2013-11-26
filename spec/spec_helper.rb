puts RUBY_DESCRIPTION

require_relative '../init.rb'

module SetMembership
  def contains?(*items)
    contents = self.to_a
    has_all = true
    items.each do |item|
      has_all &= contents.include?(item) 
    end
    has_all
  end

  def only_contains?(*items)
    contents = self.to_a
    has_all = contents.count == items.count
    items.each do |item|
      has_all &= contents.include?(item) 
    end
    has_all
  end
end

class Array
  include SetMembership
end

module ::Enumerable
  include SetMembership
end
