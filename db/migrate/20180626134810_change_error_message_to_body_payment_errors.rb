class ChangeErrorMessageToBodyPaymentErrors < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_errors, :body, :text
  end
end
