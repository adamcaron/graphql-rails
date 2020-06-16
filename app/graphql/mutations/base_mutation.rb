# module Mutations
#   class BaseMutation < GraphQL::Schema::RelayClassicMutation
#     argument_class Types::BaseArgument
#     field_class Types::BaseField
#     input_object_class Types::BaseInputObject
#     object_class Types::BaseObject
#   end
# end

# Careful! The above boilerplate breaks stuff! Use the below:
# Note: the difference between ::RelayClassicMutation and ::Mutation. Important!

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    null false
  end
end
