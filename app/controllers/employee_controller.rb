class EmployeeController < ApplicationController
	def index
    		@employee = Employee.where(nil) # creates an anonymous scope
  		@employee = @employee.location(params[:location]) if params[:location].present?
  	end

	def create
		@employee = Employee.new(employee_params)
 
  		@employee.save
  		redirect_to @employee
	end 

	def show
		@employee = Employee.find(params[:id])
	end

	def new
		@employee = Employee.new()
	end

	private
	def employee_params
		params.require(:employee).permit(:name, :location)
	end
end
