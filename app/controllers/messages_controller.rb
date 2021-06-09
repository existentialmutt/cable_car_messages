class MessagesController < ApplicationController
  include CableReady::Broadcaster
  before_action :set_message, only: %i[ edit update destroy ]


  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    render(
      operations: cable_car.append(
            selector: "#messages",
            html: self.class.render(@message, assigns: {message: @message})
          ))
  end

  def edit
    render operations: cable_car.outer_html(
      selector: dom_id(@message),
      html: self.class.render(@message, assigns: {message: @message})
    )
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render operations: cable_car
        .append(selector: "#messages", html: self.class.render(@message))
        .remove(selector: "#new_message")
    else
      render operations: cable_car
        .outer_html(selector: dom_id(@message), html: self.class.render(@message, assigns: {message: @message}))
    end
  end

  def update
    if @message.update(message_params)
      render operations: cable_car
        .outer_html(selector: dom_id(@message), html: self.class.render(@message))
    else
      render operations: cable_car
        .outer_html(selector: dom_id(@message), html: self.class.render(@message, assigns: {message: @message}))
    end
  end

  def destroy
    @message.destroy
    render operations: cable_car
      .remove(selector: dom_id(@message))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end
