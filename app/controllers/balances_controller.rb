class BalancesController < ApplicationController
  load_and_authorize_resource

  def import
    Balance.import(params[:file])
    redirect_to root_url, notice: "CSV data imported."
  end

  # GET /balances
  # GET /balances.json
  def index
    @balances_by_year = @balances.group_by(&:year)
    @year = params[:year] || @balances_by_year.keys.sort.last
    @balances_year = @balances_by_year[@year.to_i]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @balances_year }
    end
  end

  # GET /balances/1
  # GET /balances/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @balance }
    end
  end

  # GET /balances/new
  # GET /balances/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @balance }
    end
  end

  # GET /balances/1/edit
  def edit
  end

  # POST /balances
  # POST /balances.json
  def create
    respond_to do |format|
      if @balance.save
        format.html { redirect_to @balance, notice: 'Balance was successfully created.' }
        format.json { render json: @balance, status: :created, location: @balance }
      else
        format.html { render action: "new" }
        format.json { render json: @balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /balances/1
  # PUT /balances/1.json
  def update
    respond_to do |format|
      if @balance.update_attributes(params[:balance])
        format.html { redirect_to @balance, notice: 'Balance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /balances/1
  # DELETE /balances/1.json
  def destroy
    @balance.destroy

    respond_to do |format|
      format.html { redirect_to balances_url }
      format.json { head :no_content }
    end
  end
end
