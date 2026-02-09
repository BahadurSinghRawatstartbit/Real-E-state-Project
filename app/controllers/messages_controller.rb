# class MessagesController < ApplicationController
#   def new
#     @message=Message.new
#   end

#   # def create
    
#   #   @message=Message.create(msg_params)
    
#   #   if @message.save
#   #     ActionCable.server.broadcast('room_channel',{content: @message.content})
#   #   end
#   # end
 


#   private

#   def msg_params
#     params.require(:message).permit(:content)
#   end

# end
# 
#
class MessagesController < ApplicationController
  before_action :require_user
  
def index
  admin = User.with_role(:admin).first

  if current_user.has_role?(:admin)
    # admin MUST receive conversation_id from params
    @conversation = Conversation.find(params[:conversation_id])
  else
    # user always has one conversation with admin
    @conversation = Conversation.find_or_create_by!(
      user: current_user,
      admin: admin
    )
  end

  @messages = @conversation.messages.includes(:sender)
  @message  = Message.new
end

 

  def create
    @conversation = Conversation.find(params[:conversation_id])

    @message = @conversation.messages.create!(
      content: params[:message][:content],
      sender: current_user
    )

    RoomChannel.broadcast_to(
      @conversation,
      {
        content: @message.content,
        sender_name: @message.sender.name,
        sender_id: @message.sender_id,
        time: @message.created_at.strftime("%H:%M")
      }
    )
  end
end
