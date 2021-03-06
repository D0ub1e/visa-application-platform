class MessagesController < ApplicationController
  before_action :check_access_domain, except: [:new, :create]
                                    
  def index
    @messages = Message.where('already_read = ?', 0)
  end
  
  def new
    @applicant = Applicant.find(params[:applicant])
  end

  def create
    message = Message.new(message_params)
    message.already_read = 0
    if message.save
      @m = "The message has been sent successfully"
    else
      @m = "Something wrong hapeened, please try again"
    end
    render 'bootbox.js.erb'
  end

  def update
    message = Message.find(params[:id])
    message.already_read = 1
    message.save!
    @m = 'Success!'
    render 'update.js.erb'
  end

  private
  def message_params
    params.require(:messages).permit(:applicant_id, :content, :already_read, :id)
  end
end
