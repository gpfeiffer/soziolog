class LabelsController < ApplicationController
  load_and_authorize_resource

  # GET /labels
  # GET /labels.json
  def index
    @transactions = Transaction.all
    @transactions_by_year = @transactions.group_by(&:year)
    @year = params[:year] || @transactions_by_year.keys.sort.last
    @transactions = @transactions_by_year[@year.to_i]
    @labels = @transactions.map(&:labels).sum

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @labels }
    end
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @label }
    end
  end

  # GET /labels/new
  # GET /labels/new.json
  def new
    @label.transaction = Transaction.find(params[:transaction_id])
    @label.amount = @label.transaction.amount - @label.transaction.labels.map(&:amount).sum

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @label }
    end
  end

  # GET /labels/1/edit
  def edit
  end

  # POST /labels
  # POST /labels.json
  def create
    respond_to do |format|
      if @label.save
        format.html { redirect_to @label.transaction, notice: 'Label was successfully created.' }
        format.json { render json: @label, status: :created, location: @label }
      else
        format.html { render action: "new" }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /labels/1
  # PUT /labels/1.json
  def update
    respond_to do |format|
      if @label.update_attributes(params[:label])
        format.html { redirect_to @label.transaction, notice: 'Label was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    @label.destroy

    respond_to do |format|
      format.html { redirect_to @label.transaction }
      format.json { head :no_content }
    end
  end
end
