module Types
  class MutationType < Types::BaseObject
    # expose the create_link mutation
    field :create_link, mutation: Mutations::CreateLink
  end
end
