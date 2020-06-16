module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      # basic validation
      return unless credentials

      user = User.find_by email: credentials[:email]

      # ensures we have the correct user
      return unless user
      return unless user.authenticate(credentials[:password])

      # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{ user.id }")

      { user: user, token: token }
    end
  end
end

# This...
# mutation {
#   signinUser(
#     credentials: {
#       email: "adam@example.com",
#       password: "123"
#     }
#   ) {
#     token
#     user {
#       id
#     }
#   }
# }

# produces this...
# {
#   "data": {
#     "signinUser": {
#       "token": "/xVe2zfkJDyyBNF0HdsSGxAUnw==--GQg0rQiHyzBbu3vq--/7AWRp6SwP3KuK65oWaXxg==",
#       "user": {
#         "id": "1"
#       }
#     }
#   }
# }
