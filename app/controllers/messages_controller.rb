class MessagesController < ApplicationController
  include CableReady::Broadcaster
  before_action :set_messages
  before_action :set_message, only: %i[ edit update destroy ]

  def index
    @messages = Message.all
  end

  def new
    @message = @messages.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render operations: cable_car
        .append("#messages", html: @message.to_html)
        .remove("#new_message")
        .push_state(url: messages_path)
    else
      render operations: cable_car.outer_html(@message, html: @message.to_form_html)
    end
  end

  def update
    if @message.update(message_params)
      render operations: cable_car
        .outer_html(@message, html: @message.to_html)
        .push_state(url: messages_path)
    else
      render operations: cable_car.outer_html(@message, html: @message.to_form_html)
    end
  end

  def destroy
    @message.destroy
    render operations: cable_car.remove(@message)
  end

  private
    def set_messages
      @messages = Message.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end
