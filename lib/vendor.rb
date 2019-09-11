class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(produce_type)
    return 0 if !@inventory.has_key?(produce_type)

    @inventory[produce_type]
  end

  def stock(produce_type, amount)
    if !@inventory.has_key?(produce_type)
      @inventory[produce_type] = amount
    elsif @inventory.has_key?(produce_type)
      @inventory[produce_type] += amount
    end
  end
end
