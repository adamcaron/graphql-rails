module Mutations
  class CreateLink < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: true
    argument :url, String, required: true

    # return type from the mutation
    type Types::LinkType

    def resolve(description: nil, url: nil)
      Link.create!(
        description: description,
        url: url,
        user: context[:current_user]
      )
    end
  end
end

# This...
# mutation {
#   createLink(
#     url: "http://npmjs.com/package/graphql-tools",
#     description: "Best tools!",
#   ) {
#     id
#     url
#     description
#   }
# }

# Returns...
# {
#   "data": {
#     "createLink": {
#       "id": "5",
#       "url": "http://npmjs.com/package/graphql-tools",
#       "description": "Best tools!"
#     }
#   }
# }


# And now after adding
# Link belongs_to :user
# references to the links table
# posted_by field on the link_type
# and user to the resolver here ...
# This...
# mutation {
#   createLink(
#       url: "http://localhost:3000/graphiql",
#       description: "Your testing playground",
#   ) {
#     id
#     url
#     description
#     postedBy {
#       id
#       name
#     }
#   }
# }

# Returns this...
# {
#   "data": {
#     "createLink": {
#       "id": "6",
#       "url": "http://localhost:3000/graphiql",
#       "description": "Your testing playground",
#       "postedBy": {
#         "id": "1",
#         "name": "Adam Caron"
#       }
#     }
#   }
# }
