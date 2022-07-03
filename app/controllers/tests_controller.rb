class TestsController < ApplicationController
	def new
		@test = Test.new
	end
	def create
		@test = Test.new( test_params )
    @test.save
    redirect_to @test
	end
	def test_params
		params.require(:test).permit(:name)
	end
  def index
    @tests = Test.all.where("user_id = 9")
  end

end

