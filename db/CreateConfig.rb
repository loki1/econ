class CreateVictim < ActiveRecord::Migration
  def self.up
		create_table :victims do |t|
			t.datetime :date_of_create
			t.datetime :date_of_change
			t.text :content
			t.boolean :free
		end
  end
	
	def self.down
		drop_table :victims
	end
end
