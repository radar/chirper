module Chirper
  class Account < ROM::Struct
    attribute :id, Types::Integer
    attribute :address, Types::String

    def local_address
      address.split("@").first
    end
  end
end
