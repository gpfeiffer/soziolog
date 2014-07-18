class DoctoratesController < ApplicationController
  load_and_authorize_resource

  # GET /doctorates
  # GET /doctorates.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @doctorates }
    end
  end

  # GET /doctorates/1
  # GET /doctorates/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @doctorate }
    end
  end

  # GET /doctorates/new
  # GET /doctorates/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @doctorate }
    end
  end

  # GET /doctorates/1/edit
  def edit
  end

  # POST /doctorates
  # POST /doctorates.json
  def create
    respond_to do |format|
      if @doctorate.save
        format.html { redirect_to @doctorate, notice: 'Doctorate was successfully created.' }
        format.json { render json: @doctorate, status: :created, location: @doctorate }
      else
        format.html { render action: "new" }
        format.json { render json: @doctorate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /doctorates/1
  # PUT /doctorates/1.json
  def update
    respond_to do |format|
      if @doctorate.update_attributes(params[:doctorate])
        format.html { redirect_to @doctorate, notice: 'Doctorate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doctorate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctorates/1
  # DELETE /doctorates/1.json
  def destroy
    @doctorate.destroy

    respond_to do |format|
      format.html { redirect_to doctorates_url }
      format.json { head :no_content }
    end
  end
end
