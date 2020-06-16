module Mutations
  class CreateUser < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    type Types::UserType

    def resolve(name: nil, auth_provider: nil)
      User.create!(
        name: name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )
    end
  end
end

# and...
# mutation {
#   createUser(
#     name: "Adam Caron",
#     authProvider: {
#       credentials: {
#         email: "adam@example.com",
#         password: "123"
#       }
#     }
#   ) {
#     id
#     name
#     email
#   }
# }

# does this...
# {
#   "data": {
#     "createUser": {
#       "id": "1",
#       "name": "Adam Caron",
#       "email": "adam@example.com"
#     }
#   }
# }
