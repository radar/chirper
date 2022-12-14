module Chirper
  module Graphql
    module Types
      class BaseMutation < GraphQL::Schema::RelayClassicMutation
        # Add your custom classes if you have them:
        # This is used for generating payload types
        object_class Types::BaseObject
        # This is used for return fields on the mutation's payload
        field_class Types::BaseField
        # This is used for generating the `input: { ... }` object type
        input_object_class Types::BaseInputObject
      end
    end
  end
end
