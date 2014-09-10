class MembersController < ApplicationController
  load_and_authorize_resource

  # GET /members
  # GET /members.json
  def index
    @members_by_status = @members.group_by(&:status)
    @institutions = @members_by_status['I'] || []
    @discontinued = @members_by_status['D'] || []
    @pending = @members_by_status['P'] || []
    @active = @members_by_status.select { |k, v| "DIP".exclude? k }.values.sum
    respond_to do |format|
      format.html # index.html.erb
      format.text # index.text.erb
      format.xls { send_data Member.to_xls, content_type: 'application/vnd.ms-excel' }
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @institute = Member.find(params[:institute_id])
    if @institute
      @member.address = @institute.address
      @member.status = 'N'
      @member.bulletin = 'yes'
      @member.comment = "added #{Date.today}."
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
end
