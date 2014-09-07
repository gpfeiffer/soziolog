class FundingsController < ApplicationController
  # GET /fundings
  # GET /fundings.json
  def index
    @fundings = Funding.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundings }
    end
  end

  # GET /fundings/1
  # GET /fundings/1.json
  def show
    @funding = Funding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @funding }
    end
  end

  # GET /fundings/new
  # GET /fundings/new.json
  def new
    @funding = Funding.new
    @funding.transaction = Transaction.find(params[:transaction_id])
    @funding.amount = -@funding.transaction.amount

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @funding }
    end
  end

  # GET /fundings/1/edit
  def edit
    @funding = Funding.find(params[:id])
  end

  # POST /fundings
  # POST /fundings.json
  def create
    @funding = Funding.new(params[:funding])

    respond_to do |format|
      if @funding.save
        format.html { redirect_to @funding.transaction, notice: 'Funding was successfully created.' }
        format.json { render json: @funding, status: :created, location: @funding }
      else
        format.html { render action: "new" }
        format.json { render json: @funding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundings/1
  # PUT /fundings/1.json
  def update
    @funding = Funding.find(params[:id])

    respond_to do |format|
      if @funding.update_attributes(params[:funding])
        format.html { redirect_to @funding.transaction, notice: 'Funding was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @funding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundings/1
  # DELETE /fundings/1.json
  def destroy
    @funding = Funding.find(params[:id])
    @funding.destroy

    respond_to do |format|
      format.html { redirect_to @funding.transaction }
      format.json { head :no_content }
    end
  end
end
