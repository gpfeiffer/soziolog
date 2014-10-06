class SubscriptionsController < ApplicationController
  load_and_authorize_resource

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions_by_year = @subscriptions.group_by(&:year)
    @year = params[:year] || @subscriptions_by_year.keys.sort.last
    @member = Member.find(params[:member_id]) if params[:member_id]
    @subscriptions = @subscriptions_by_year[@year]

    respond_to do |format|
      format.html # index.html.erb
      format.tex
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription.transaction = Transaction.find(params[:transaction_id])
    @subscription.year = @subscription.transaction.date.year.to_s
    @subscription.payment = @subscription.transaction.amount
    @subscription.paid_on = @subscription.transaction.date
    @subscription.currency = "EUR"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription.transaction, notice: 'Subscription was successfully created.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription.transaction, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to @subscription.transaction }
      format.json { head :no_content }
    end
  end
end
