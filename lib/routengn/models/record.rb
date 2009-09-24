class Record
  include RouteNGN::Mapper

  field :dialcode, :primary => true
  field :account_id
  field :rn
  field :locale_id
  field :sent
  field :received
  field :detail
  field :server
  field :response_time 
  field :created_at
  field :updated_at

end
