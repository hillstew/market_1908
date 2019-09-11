class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(produce_type)
    @vendors.find_all do |vendor|
      vendor.inventory.has_key?(produce_type)
    end
  end

  def sorted_item_list
    @vendors.map { |vendor| vendor.inventory.keys }.flatten.uniq.sort { |a, b| a <=> b }
  end

  def total_inventory
    total_items = Hash.new
    total = @vendors.each do |vendor|
      vendor.inventory.each do |type, amount|
        if total_items.has_key?(type)
          total_items[type] += amount
        elsif !total_items.has_key?(type)
          total_items[type] = amount
        end
      end
    end
    total_items
  end

  def sell(produce_type, amount)
    return false if !total_inventory.has_key?(produce_type) || total_inventory[produce_type] < amount

    @vendors.each do |vendor|
      if vendor.inventory.has_key?(produce_type)
        if vendor.inventory[produce_type] >= amount
          vendor.inventory[produce_type] -= amount
        elsif !(vendor.inventory[produce_type] >= amount)
          amount -= vendor.inventory[produce_type]
          vendor.inventory[produce_type] -= vendor.inventory[produce_type]
        end
      end
    end
  end
end
