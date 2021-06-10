class Message < ApplicationRecord
  validates :content, presence: true

  def to_html
    MessagesController.render(self)
  end

  def to_form_html
    MessagesController.render(partial: "form", locals: {message: self})
  end
end
