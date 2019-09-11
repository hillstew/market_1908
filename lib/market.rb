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

  
end
