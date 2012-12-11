class GuestsController < ApplicationController
  # GET /guests
  # GET /guests.json
  http_basic_authenticate_with :name => AUTH_CONFIG['credentials']['username'] ,:password => AUTH_CONFIG['credentials']['password'], :except => [:new,:show,:create,:list]
  def index
    @guests = Guest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guests }
    end
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = Guest.find(params[:id])
    @guests = Guest.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = Guest.new
    @guests = Guest.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(params[:guest])
    respond_to do |format|
      if verify_captcha(@guest) &&  @guest.save 
        #deliver_mail(@guest)
        format.html { redirect_to @guest, notice: "We have been Notified.  Thank you ! Please find the complete list of attendes #{view_context.link_to('here', list_guests_url, target: '_blank') }.".html_safe}
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = Guest.find(params[:id])

    respond_to do |format|
      if @guest.update_attributes(params[:guest])
        format.html { redirect_to @guest, notice: 'Guest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def list
   @guests = Guest.list
   render :layout => 'guest_list'
  end
  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to guests_url }
      format.json { head :no_content }
    end
  end
end



def deliver_mail guest
  case guest.attending
  when true
    GuestMailer.send_to_attending(@guest).deliver
  when false
    GuestMailer.send_to_not_attending(@guest).deliver 
  end
end


private

def verify_captcha guest
  verify_recaptcha(:model => guest, :message => "Oh! It's error with reCAPTCHA!" ,:private_key => AUTH_CONFIG['recaptcha']['private_key'])
end
