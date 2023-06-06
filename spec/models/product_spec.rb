require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should be able to save a product' do
      newCategory = Category.create(name: "Michael")
      product = Product.new
      product.name = "quica"
      product.price = 2
      product.quantity = 2
      product.category_id = newCategory.id
      product.save
      expect(product.persisted?).to eq(true)
    end


    it 'should have a name' do
      newCategory = Category.create(name: "Michael")
      product = Product.new
      product.name = nil
      product.price = 2
      product.quantity = 2
      product.category_id = newCategory.id
      product.save
      expect(product.persisted?).to eq(false)
      expect(product.errors.full_messages).to include("Name can't be blank")
    end 


    it 'should have a price' do
      newCategory = Category.create(name: "Michael")
      product = Product.new
      product.name = "quica"
      product.price == nil
      product.quantity = 1
      product.category_id = newCategory.id
      product.save
      expect(product.persisted?).to eq(false)
      expect(product.errors.full_messages).to include("Price is not a number")
    end 


    it 'should have a quantity' do
      newCategory = Category.create(name: "Michael")
      product = Product.new
      product.name = "quica"
      product.price = 3
      product.quantity = nil
      product.category_id = newCategory.id
      product.save
      expect(product.persisted?).to eq(false)
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end 

    it 'should have a category' do
      newCategory = Category.create(name: "Michael")
      product = Product.new
      product.name = "quica"
      product.price = 6
      product.quantity = 2
      product.category_id = nil
      product.save
      expect(product.persisted?).to eq(false)
      expect(product.errors.full_messages).to include("Category can't be blank")
    end 
end
end
