module Types
  class MutationType < Types::BaseObject
    # expose the create_link mutation
    field :create_user, mutation: Mutations::CreateUser
    field :create_link, mutation: Mutations::CreateLink
    field :signin_user, mutation: Mutations::SignInUser
  end
end
