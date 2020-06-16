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
