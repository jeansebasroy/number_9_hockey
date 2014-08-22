require 'rails_helper'

describe Camp do

	before { @camp = Camp.new(name: "Test Camp", 
								description: "This is a camp built for testing") }

	subject { @camp }

	it { should respond_to(:name) }
 	it { should respond_to(:description) }
 	
  	it { should be_valid }
  	
end
