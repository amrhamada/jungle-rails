require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "name exists in product" do 
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "allstars", price_cents: 2000, quantity:500, category:@category)
      expect(@product.name).to be_present
  
    end
    it "price exists in product" do 
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "allstars", price_cents: 2000, quantity:500, category:@category)
      expect(@product.price).to be_present
  
    end
    it "quantity exists in product" do 
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "allstars", price_cents: 2000, quantity:500, category:@category)
      expect(@product.price).to be_present
  
    end
    it "category exists in product" do 
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "allstars", price_cents: 2000, quantity:500, category:@category)
      expect(@product.category_id).to be_present
  
    end
    it "error to be shown when field is nil" do 
      @category = Category.create(name: "Shoes")
      @product = Product.create( price_cents: 2000, quantity:500, category:@category)
      expect(@product.errors.full_messages).to eq ["Name can't be blank"]
  
    end
  end
end

# validates :name presence true
# validates :price presence true 
# quatinity 
# category