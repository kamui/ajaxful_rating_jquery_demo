class CarsController < ApplicationController
  def index
    @cars = Car.all
  end
  
  def show
    @car = Car.find(params[:id])
  end
  
  def new
    @car = Car.new
  end
  
  def create
    @car = Car.new(params[:car])
    if @car.save
      flash[:notice] = "Successfully created car."
      redirect_to @car
    else
      render :action => 'new'
    end
  end
  
  def edit
    @car = Car.find(params[:id])
  end
  
  def update
    @car = Car.find(params[:id])
    if @car.update_attributes(params[:car])
      flash[:notice] = "Successfully updated car."
      redirect_to @car
    else
      render :action => 'edit'
    end
  end
  
  def rate
    @car = Car.find(params[:id])
    @car.rate(params[:stars], current_user, params[:dimension])
    average = @car.rate_average(true, params[:dimension])
    width = (average / @car.class.max_stars.to_f) * 100
    render :json => {:id => @car.wrapper_dom_id(params), :average => average, :width => width}
  end
  
  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    flash[:notice] = "Successfully destroyed car."
    redirect_to cars_url
  end
end
